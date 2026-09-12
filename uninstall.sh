#!/bin/bash

# IP-Tool Uninstall Script
# Script de desinstalación para IP-Tool

echo "╔════════════════════════════════════════╗"
echo "║  IP-Tool - Script de Desinstalación   ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Confirmación
echo "⚠️  Esto desinstalará IP-Tool de tu sistema."
echo "¿Deseas continuar? (s/n)"
read -r response

if [ "$response" != "s" ] && [ "$response" != "S" ]; then
    echo "✗ Desinstalación cancelada"
    exit 0
fi

echo ""
echo "🗑️  Desinstalando IP-Tool..."
echo ""

# Detectar sistema
if [[ "$OSTYPE" == "linux-android"* ]]; then
    INSTALL_DIR="$HOME/.local/bin"
else
    INSTALL_DIR="/usr/local/bin"
fi

# Eliminar binario
if [ -f "$INSTALL_DIR/ip-tool" ]; then
    rm -f "$INSTALL_DIR/ip-tool"
    echo "✓ Binario eliminado"
else
    echo "! Binario no encontrado en $INSTALL_DIR/ip-tool"
fi

# Preguntar si eliminar archivos de configuración
echo ""
echo "¿Deseas eliminar los archivos de configuración? (s/n)"
read -r config_response

if [ "$config_response" = "s" ] || [ "$config_response" = "S" ]; then
    if [ -d "$HOME/.ip-tool" ]; then
        rm -rf "$HOME/.ip-tool"
        echo "✓ Archivos de configuración eliminados"
    else
        echo "! No se encontraron archivos de configuración"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ IP-Tool ha sido desinstalado"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Gracias por usar IP-Tool 👋"
echo ""
