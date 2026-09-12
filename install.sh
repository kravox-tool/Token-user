#!/bin/bash

# IP-Tool Installation Script
# Script de instalación automática para IP-Tool

echo "╔════════════════════════════════════════╗"
echo "║   IP-Tool - Script de Instalación     ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Detectar sistema operativo
if [[ "$OSTYPE" == "linux-android"* ]]; then
    echo "✓ Sistema detectado: Termux"
    IS_TERMUX=true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✓ Sistema detectado: Linux"
    IS_TERMUX=false
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✓ Sistema detectado: macOS"
    IS_TERMUX=false
else
    echo "⚠ Sistema no soportado"
    exit 1
fi

echo ""
echo "📦 Verificando dependencias..."
echo ""

# Función para verificar comandos
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo "✗ $1 no está instalado"
        return 1
    else
        echo "✓ $1 instalado"
        return 0
    fi
}

# Verificar dependencias
MISSING_DEPS=false
check_command "bash" || MISSING_DEPS=true
check_command "curl" || MISSING_DEPS=true
check_command "ping" || MISSING_DEPS=true

echo ""

if [ "$MISSING_DEPS" = true ]; then
    echo "⚠️  Faltan dependencias. ¿Deseas instalarlas? (s/n)"
    read -r response
    
    if [ "$response" = "s" ] || [ "$response" = "S" ]; then
        echo "📥 Instalando dependencias..."
        if [ "$IS_TERMUX" = true ]; then
            pkg update -y
            pkg install -y curl wget iputils dnsutils
        else
            sudo apt-get update
            sudo apt-get install -y curl wget iputils-ping dnsutils
        fi
        echo "✓ Dependencias instaladas"
    fi
fi

echo ""
echo "🔧 Preparando instalación..."
echo ""

# Hacer ejecutable el script principal
chmod +x ip-tool.sh

# Crear directorio de instalación
if [ "$IS_TERMUX" = true ]; then
    INSTALL_DIR="$HOME/.local/bin"
else
    INSTALL_DIR="/usr/local/bin"
fi

mkdir -p "$INSTALL_DIR"

# Copiar archivo
echo "📋 Copiando archivos..."
cp ip-tool.sh "$INSTALL_DIR/ip-tool"
chmod +x "$INSTALL_DIR/ip-tool"

echo "✓ Archivos copiados"
echo ""

# Verificar si está en PATH
if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]] || [ "$IS_TERMUX" = false ]; then
    echo "✓ Instalación completada exitosamente"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎉 ¡IP-Tool está listo para usar!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Para ejecutar la herramienta, escribe:"
    echo "  $ ip-tool"
    echo ""
else
    echo "⚠️  Necesitas agregar $INSTALL_DIR a tu PATH"
    echo ""
    echo "Agrega esta línea a tu ~/.bashrc o ~/.zshrc:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
    echo "Luego ejecuta: source ~/.bashrc"
    echo ""
    echo "O ejecuta directamente:"
    echo "  $ $INSTALL_DIR/ip-tool"
fi

echo ""
echo "📚 Más información: Ver README.md"
echo "🐛 Reportar problemas: GitHub Issues"
echo ""
