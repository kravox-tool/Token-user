#!/bin/bash

# IP-Tool - Configuración de Ejemplo
# Copia este archivo a config.sh para personalizar IP-Tool

# ═══════════════════════════════════════════════════════
# COLORES - Personaliza los colores de la interfaz
# ═══════════════════════════════════════════════════════

# Colores disponibles:
# 0;31m = Rojo
# 0;32m = Verde
# 1;33m = Amarillo
# 0;34m = Azul
# 0;36m = Cyan
# 0;35m = Magenta

COLOR_PRIMARY='\033[0;36m'      # Color principal (Cyan)
COLOR_SECONDARY='\033[1;33m'    # Color secundario (Amarillo)
COLOR_SUCCESS='\033[0;32m'      # Color de éxito (Verde)
COLOR_ERROR='\033[0;31m'        # Color de error (Rojo)
COLOR_INFO='\033[0;34m'         # Color de información (Azul)
COLOR_RESET='\033[0m'           # Resetear colores

# ═══════════════════════════════════════════════════════
# APIs - Configuración de APIs externas
# ═══════════════════════════════════════════════════════

# API para obtener IP pública
PUBLIC_IP_API="https://api.ipify.org?format=json"
BACKUP_PUBLIC_IP_API="https://api.myip.com"

# API para información de IP
IP_INFO_API="http://ip-api.com/json/"

# Timeout en segundos para las consultas
API_TIMEOUT=10

# ═══════════════════════════════════════════════════════
# PUERTOS - Puertos a verificar
# ═══════════════════════════════════════════════════════

# Puertos comunes a verificar (separados por espacio)
COMMON_PORTS="21 22 23 25 53 80 110 143 443 445 3306 5432 8080 8443"

# Timeout para verificación de puertos (segundos)
PORT_CHECK_TIMEOUT=2

# ═══════════════════════════════════════════════════════
# INTERFAZ - Configuración de la interfaz
# ═══════════════════════════════════════════════════════

# Mostrar banner al iniciar
SHOW_BANNER=true

# Mostrar información de depuración
DEBUG_MODE=false

# Número de intentos para ping
PING_COUNT=4

# Limpiar pantalla después de cada opción
AUTO_CLEAR=true

# ═══════════════════════════════════════════════════════
# LOGGING - Configuración de logs
# ═══════════════════════════════════════════════════════

# Habilitar logging
ENABLE_LOGGING=false

# Directorio de logs
LOG_DIR="$HOME/.ip-tool/logs"

# Archivo de log
LOG_FILE="$LOG_DIR/ip-tool.log"

# ═══════════════════════════════════════════════════════
# HISTORIAL - Configuración del historial
# ═══════════════════════════════════════════════════════

# Guardar historial de consultas
SAVE_HISTORY=true

# Archivo de historial
HISTORY_FILE="$HOME/.ip-tool/history.txt"

# Máximo número de entradas en el historial
MAX_HISTORY_ENTRIES=100

# ═══════════════════════════════════════════════════════
# IDIOMA - Configuración de idioma
# ═══════════════════════════════════════════════════════

# Idioma: es (español), en (inglés)
LANGUAGE="es"

# ═══════════════════════════════════════════════════════
# NOTAS SOBRE LA CONFIGURACIÓN
# ═══════════════════════════════════════════════════════

# Para usar este archivo de configuración:
# 1. Copia este archivo a: config.sh
# 2. Edita los valores según tus necesidades
# 3. El script cargará automáticamente config.sh si existe
#
# Las variables de este archivo anularán los valores por defecto
# del script principal (ip-tool.sh)

# ═══════════════════════════════════════════════════════
# EJEMPLO DE PERSONALIZACIÓN
# ═══════════════════════════════════════════════════════

# Para usar colores diferentes:
# COLOR_PRIMARY='\033[0;35m'  # Magenta
# COLOR_SUCCESS='\033[0;32m'  # Verde brillante

# Para verificar más puertos:
# COMMON_PORTS="21 22 23 25 53 80 110 143 443 445 3306 5432 8080 8443 9000 9001 5900"

# Para deshabilitar el banner:
# SHOW_BANNER=false

# Para habilitar el modo debug:
# DEBUG_MODE=true
