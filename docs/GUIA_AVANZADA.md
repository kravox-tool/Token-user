# Guía Avanzada de IP-Tool

## Índice

1. [Instalación Avanzada](#instalación-avanzada)
2. [Personalización](#personalización)
3. [Scripting](#scripting)
4. [Optimización](#optimización)
5. [Solución de Problemas](#solución-de-problemas)

---

## Instalación Avanzada

### Instalación desde fuente (Desarrollo)

```bash
# Clonar repositorio
git clone https://github.com/tuusuario/ip-tool.git
cd ip-tool

# Crear rama de desarrollo
git checkout -b desarrollo

# Instalar dependencias de desarrollo
pkg install build-essential git

# Hacer ejecutable e instalar
chmod +x install.sh
./install.sh
```

### Instalación personalizada

```bash
# Copiar a ubicación personalizada
cp ip-tool.sh /tu/directorio/custom-ip-tool
chmod +x /tu/directorio/custom-ip-tool

# Crear alias en .bashrc
echo "alias ip-tool='/tu/directorio/custom-ip-tool'" >> ~/.bashrc
source ~/.bashrc
```

---

## Personalización

### Modificar colores

Edita el archivo `ip-tool.sh` y localiza:

```bash
# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
```

**Códigos de color ANSI:**

```
0;30m = Negro
0;31m = Rojo
0;32m = Verde
0;33m = Amarillo
0;34m = Azul
0;35m = Magenta
0;36m = Cyan
0;37m = Blanco

1;30m = Gris
1;31m = Rojo brillante
1;32m = Verde brillante
1;33m = Amarillo brillante
1;34m = Azul brillante
1;35m = Magenta brillante
1;36m = Cyan brillante
1;37m = Blanco brillante
```

### Crear tema personalizado

```bash
# En tu archivo de configuración
MY_THEME_PRIMARY='\033[0;35m'      # Magenta
MY_THEME_SECONDARY='\033[0;36m'    # Cyan
MY_THEME_SUCCESS='\033[1;32m'      # Verde brillante
MY_THEME_ERROR='\033[1;31m'        # Rojo brillante
```

### Agregar más puertos a verificar

En la función `check_ports()`, localiza:

```bash
common_ports=(21 22 23 25 53 80 110 143 443 445 3306 5432 8080 8443)
```

Agrega los puertos que necesites:

```bash
common_ports=(21 22 23 25 53 80 110 143 443 445 3306 5432 5900 8000 8080 8443 9000 9001)
```

---

## Scripting

### Usar IP-Tool en tus propios scripts

#### Obtener IP pública

```bash
#!/bin/bash
source /usr/local/bin/ip-tool

# Obtener IP pública
public_ip=$(curl -s https://api.ipify.org?format=json | grep -o '"ip":"[^"]*' | grep -o '[0-9.]*')
echo "Mi IP es: $public_ip"
```

#### Consultar información de IP

```bash
#!/bin/bash

QUERY_IP="8.8.8.8"

# Obtener información de IP usando la API
response=$(curl -s "http://ip-api.com/json/$QUERY_IP")

# Parsear JSON (sin jq)
country=$(echo $response | grep -o '"country":"[^"]*' | cut -d'"' -f4)
city=$(echo $response | grep -o '"city":"[^"]*' | cut -d'"' -f4)
isp=$(echo $response | grep -o '"isp":"[^"]*' | cut -d'"' -f4)

echo "IP: $QUERY_IP"
echo "País: $country"
echo "Ciudad: $city"
echo "ISP: $isp"
```

#### Automatizar verificación de IPs

```bash
#!/bin/bash

# Script para verificar múltiples IPs
MYGIT_LIST="8.8.8.8 1.1.1.1 208.67.222.222"

for ip in $IP_LIST; do
    echo "Verificando: $ip"
    response=$(curl -s "http://ip-api.com/json/$ip")
    echo $response
    echo "---"
    sleep 1  # Esperar entre consultas
done
```

### Crear funciones personalizadas

```bash
# Función para verificar múltiples puertos rápidamente
function quick_port_check() {
    local host=$1
    local ports=$2
    
    echo "Verificando puertos en $host..."
    
    for port in $ports; do
        timeout 1 bash -c "</dev/tcp/$host/$port" 2>/dev/null \
            && echo "Puerto $port: ABIERTO" \
            || echo "Puerto $port: CERRADO"
    done
}

# Uso:
# quick_port_check "google.com" "80 443 8080"
```

---

## Optimización

### Mejora de rendimiento

#### Usar cache local

```bash
# Crear archivo de cache
CACHE_FILE="$HOME/.ip-tool/cache.tmp"
CACHE_TTL=3600  # 1 hora en segundos

# Función con cache
get_cached_ip() {
    local ip=$1
    
    # Verificar si el cache existe y es válido
    if [ -f "$CACHE_FILE" ] && [ $(($(date +%s) - $(stat -f%m "$CACHE_FILE"))) -lt $CACHE_TTL ]; then
        cat "$CACHE_FILE"
    else
        # Obtener datos nuevos
        local result=$(curl -s "http://ip-api.com/json/$ip")
        echo "$result" > "$CACHE_FILE"
        echo "$result"
    fi
}
```

#### Paralelizar consultas

```bash
# Verificar múltiples IPs en paralelo
check_ips_parallel() {
    local ips=("8.8.8.8" "1.1.1.1" "208.67.222.222")
    
    for ip in "${ips[@]}"; do
        (
            curl -s "http://ip-api.com/json/$ip"
        ) &
    done
    
    wait  # Esperar a que terminen todos los procesos
}
```

### Reducir uso de datos

```bash
# Usar versión comprimida de APIs
response=$(curl -s --compressed "http://ip-api.com/json/$ip")

# Usar wget con compresión
response=$(wget -q -O- --compression=auto "http://ip-api.com/json/$ip")
```

---

## Solución de Problemas

### El script no se ejecuta

```bash
# Verificar permisos
ls -l ip-tool.sh

# Dar permisos de ejecución
chmod +x ip-tool.sh

# Ejecutar explícitamente con bash
bash ip-tool.sh
```

### No se obtiene IP pública

```bash
# Verificar conexión a internet
ping -c 1 8.8.8.8

# Probar con wget si curl no funciona
wget -qO- https://api.ipify.org?format=json

# Verificar proxy/firewall
curl -v https://api.ipify.org?format=json
```

### Las APIs no responden

```bash
# Verificar disponibilidad de API
curl -I http://ip-api.com/

# Usar API alternativa
curl https://ifconfig.io

# Aumentar timeout
timeout 30 curl -s "http://ip-api.com/json/8.8.8.8"
```

### Problemas con DNS

```bash
# Verificar configuración DNS actual
cat /etc/resolv.conf

# Probar con DNS público
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

# Usar dig directamente
dig @8.8.8.8 google.com
```

### Errores de permisos

```bash
# En Termux
sudo chown $USER:$USER /usr/local/bin/ip-tool

# En Linux
sudo chown $USER:$USER ~/.local/bin/ip-tool
```

---

## Ejemplos Avanzados

### Generar reporte de IPs

```bash
#!/bin/bash

echo "Generando reporte de IPs..." > report.txt
echo "Fecha: $(date)" >> report.txt
echo "---" >> report.txt

# Obtener IP pública
PUBLIC_IP=$(curl -s https://api.ipify.org?format=json | grep -o '[0-9.]*')
echo "IP Pública: $PUBLIC_IP" >> report.txt

# Obtener IPs locales
echo "IPs Locales:" >> report.txt
ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print "  " $2}' >> report.txt

# Obtener información
response=$(curl -s "http://ip-api.com/json/$PUBLIC_IP")
echo "Información:" >> report.txt
echo $response | jq '.' >> report.txt

echo "✓ Reporte guardado en report.txt"
```

### Monitorear cambios de IP

```bash
#!/bin/bash

LAST_IP_FILE="$HOME/.ip-tool/last-ip.txt"

check_ip_changed() {
    CURRENT_IP=$(curl -s https://api.ipify.org?format=json | grep -o '[0-9.]*')
    
    if [ -f "$LAST_IP_FILE" ]; then
        LAST_IP=$(cat "$LAST_IP_FILE")
        
        if [ "$CURRENT_IP" != "$LAST_IP" ]; then
            echo "⚠️  Tu IP ha cambiado de $LAST_IP a $CURRENT_IP"
            # Aquí puedes enviar notificaciones, logs, etc.
        fi
    fi
    
    echo "$CURRENT_IP" > "$LAST_IP_FILE"
}

# Ejecutar cada 5 minutos con cron
# */5 * * * * /path/to/check-ip-changed.sh
```

---

## Contribuir Mejoras

¿Tienes optimizaciones o nuevas funciones? ¡Abre un Pull Request!

Consulta [CONTRIBUTING.md](../CONTRIBUTING.md) para más información.

---

**Última actualización**: 2024  
**Versión**: 1.0
