# 🚀 Inicio Rápido - IP-Tool

## Instalación en 30 segundos

### Opción 1: Instalación automática (Recomendado)

```bash
# Clonar y entrar al directorio
git clone https://github.com/tuusuario/ip-tool.git
cd ip-tool

# Ejecutar instalador
chmod +x install.sh
./install.sh

# ¡Listo! Ejecuta:
ip-tool
```

### Opción 2: Ejecución directa

```bash
# Clonar
git clone https://github.com/tuusuario/ip-tool.git
cd ip-tool

# Ejecutar
chmod +x ip-tool.sh
./ip-tool.sh
```

### Opción 3: En Termux

```bash
# Actualizar Termux
apt update && apt upgrade

# Instalar dependencias
apt install curl wget iputils dnsutils git

# Clonar e instalar
git clone https://github.com/tuusuario/ip-tool.git
cd ip-tool
chmod +x install.sh
./install.sh

# Ejecutar
ip-tool
```

---

## Primeros pasos

### 1. Obtener tu IP pública

```
Selecciona opción: 1
↓
🌐 Obteniendo IP Pública...
IP Pública: 203.0.113.45
```

### 2. Ver información de tu IP

```
Selecciona opción: 3
↓
Ingresa la IP a consultar (Enter para tu IP):
↓
Información completa de tu IP mostrada
```

### 3. Consultar otra IP

```
Selecciona opción: 5
↓
Ingresa la IP: 8.8.8.8
↓
Información de Google DNS
```

---

## Uso desde terminal (Sin menú)

Si quieres usar IP-Tool en scripts, puedes extraer funciones del script principal:

```bash
# Obtener IP pública
curl -s https://api.ipify.org?format=json

# Obtener info de una IP
curl -s "http://ip-api.com/json/8.8.8.8"

# Hacer ping
ping -c 4 google.com
```

---

## Accesos directos útiles

### Obtener solo tu IP

```bash
curl -s api.ipify.org && echo
```

### Información completa en formato JSON

```bash
curl -s "http://ip-api.com/json/" | jq '.'
```

### Verificar conectividad

```bash
ping -c 1 8.8.8.8
```

### Información DNS

```bash
nslookup google.com
```

---

## Solución rápida de problemas

### "Comando no encontrado"

```bash
# Verifica que está instalado
which ip-tool

# Si no aparece, reinstala
cd ip-tool
./install.sh
```

### "Permiso denegado"

```bash
# Hacer ejecutable
chmod +x ip-tool.sh

# O usar bash explícitamente
bash ip-tool.sh
```

### "No se obtiene IP"

```bash
# Verifica conexión a internet
ping -c 1 8.8.8.8

# Verifica si curl está instalado
which curl
```

---

## Próximas opciones

Una vez instalado:

- Lee [GUIA_AVANZADA.md](GUIA_AVANZADA.md) para usos avanzados
- Consulta [README.md](../README.md) para documentación completa
- Abre un [Issue](https://github.com/tuusuario/ip-tool/issues) si tienes problemas
- Contribuye en [GitHub](https://github.com/tuusuario/ip-tool)

---

## Referencias rápidas

| Acción | Comando |
|--------|---------|
| Ejecutar | `ip-tool` |
| Instalar | `cd ip-tool && ./install.sh` |
| Desinstalar | `cd ip-tool && ./uninstall.sh` |
| Ayuda | Ver en la aplicación, opción 9 |
| Actualizar | `git pull` en el directorio del repo |

---

## ¿Necesitas ayuda?

- 📖 Documentación: [README.md](../README.md)
- 🚀 Guía avanzada: [GUIA_AVANZADA.md](GUIA_AVANZADA.md)
- 🐛 Reportar bug: [GitHub Issues](https://github.com/tuusuario/ip-tool/issues)
- 💬 Preguntas: [GitHub Discussions](https://github.com/tuusuario/ip-tool/discussions)

---

**¡Listo para empezar! 🎉**

Ejecuta `ip-tool` y comienza a explorar.
