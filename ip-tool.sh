#!/bin/bash

# IP Tool - Herramienta de información de IP para Termux
# Autor: Tu nombre
# Versión: 1.0

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner ASCII
print_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════════════╗
    ║                                                       ║
    ║           ██╗██████╗         ████████╗ ██████╗      ║
    ║           ██║██╔══██╗        ╚══██╔══╝██╔═══██╗     ║
    ║           ██║██████╔╝█████╗     ██║   ██║   ██║     ║
    ║           ██║██╔═══╝ ╚════╝     ██║   ██║   ██║     ║
    ║           ██║██║               ██║   ╚██████╔╝     ║
    ║           ╚═╝╚═╝               ╚═╝    ╚═════╝      ║
    ║                                                       ║
    ║            🌐 Herramienta de Información IP 🌐       ║
    ║                     v1.0 - Termux                   ║
    ║                                                       ║
    ╚═══════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

# Menú principal
show_menu() {
    echo -e "${YELLOW}═══════════════════════════════════════${NC}"
    echo -e "${GREEN}  📋 MENÚ PRINCIPAL${NC}"
    echo -e "${YELLOW}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}1)${NC} Mi IP Pública"
    echo -e "${BLUE}2)${NC} Mi IP Local"
    echo -e "${BLUE}3)${NC} Información Completa de IP"
    echo -e "${BLUE}4)${NC} Geolocalización de IP"
    echo -e "${BLUE}5)${NC} Consultar IP Específica"
    echo -e "${BLUE}6)${NC} Ping a Host"
    echo -e "${BLUE}7)${NC} Información DNS"
    echo -e "${BLUE}8)${NC} Verificar Puertos"
    echo -e "${BLUE}9)${NC} Acerca de"
    echo -e "${BLUE}0)${NC} Salir"
    echo -e "${YELLOW}═══════════════════════════════════════${NC}"
}

# Mi IP Pública
get_public_ip() {
    echo -e "${GREEN}🌐 Obteniendo IP Pública...${NC}"
    public_ip=$(curl -s https://api.ipify.org?format=json | grep -o '"ip":"[^"]*' | grep -o '[0-9.]*')
    if [ -z "$public_ip" ]; then
        public_ip=$(wget -qO- https://api.ipify.org?format=json | grep -o '"ip":"[^"]*' | grep -o '[0-9.]*')
    fi
    echo -e "${CYAN}IP Pública: ${YELLOW}$public_ip${NC}"
}

# Mi IP Local
get_local_ip() {
    echo -e "${GREEN}🏠 IP Local:${NC}"
    ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | while read ip; do
        echo -e "${CYAN}→ ${YELLOW}$ip${NC}"
    done
}

# Información completa de IP
get_ip_info() {
    read -p "Ingresa la IP a consultar (o presiona Enter para tu IP pública): " ip_input
    
    if [ -z "$ip_input" ]; then
        ip_input=$(curl -s https://api.ipify.org?format=json | grep -o '"ip":"[^"]*' | grep -o '[0-9.]*')
    fi
    
    echo -e "${GREEN}📊 Información de IP: ${YELLOW}$ip_input${NC}"
    echo -e "${YELLOW}─────────────────────────────────────${NC}"
    
    # Usando ip-api.com
    response=$(curl -s "http://ip-api.com/json/$ip_input")
    
    echo -e "${CYAN}Status: ${YELLOW}$(echo $response | grep -o '"status":"[^"]*' | cut -d'"' -f4)${NC}"
    echo -e "${CYAN}País: ${YELLOW}$(echo $response | grep -o '"country":"[^"]*' | cut -d'"' -f4)${NC}"
    echo -e "${CYAN}Ciudad: ${YELLOW}$(echo $response | grep -o '"city":"[^"]*' | cut -d'"' -f4)${NC}"
    echo -e "${CYAN}ISP: ${YELLOW}$(echo $response | grep -o '"isp":"[^"]*' | cut -d'"' -f4)${NC}"
    echo -e "${CYAN}Latitud: ${YELLOW}$(echo $response | grep -o '"lat":[^,}]*' | cut -d':' -f2)${NC}"
    echo -e "${CYAN}Longitud: ${YELLOW}$(echo $response | grep -o '"lon":[^,}]*' | cut -d':' -f2)${NC}"
}

# Geolocalización
get_geo_ip() {
    read -p "Ingresa la IP a geolocalizar: " ip_geo
    echo -e "${GREEN}📍 Geolocalización de: ${YELLOW}$ip_geo${NC}"
    echo -e "${YELLOW}─────────────────────────────────────${NC}"
    
    response=$(curl -s "http://ip-api.com/json/$ip_geo")
    country=$(echo $response | grep -o '"country":"[^"]*' | cut -d'"' -f4)
    city=$(echo $response | grep -o '"city":"[^"]*' | cut -d'"' -f4)
    lat=$(echo $response | grep -o '"lat":[^,}]*' | cut -d':' -f2)
    lon=$(echo $response | grep -o '"lon":[^,}]*' | cut -d':' -f2)
    
    echo -e "${CYAN}🌍 País: ${YELLOW}$country${NC}"
    echo -e "${CYAN}🏙️  Ciudad: ${YELLOW}$city${NC}"
    echo -e "${CYAN}📌 Coordenadas: ${YELLOW}$lat, $lon${NC}"
}

# Ping
ping_host() {
    read -p "Ingresa el host a hacer ping: " host
    echo -e "${GREEN}🔔 Haciendo ping a ${YELLOW}$host${NC}"
    echo -e "${YELLOW}─────────────────────────────────────${NC}"
    ping -c 4 "$host"
}

# DNS
get_dns_info() {
    read -p "Ingresa el dominio: " domain
    echo -e "${GREEN}🔍 Información DNS de ${YELLOW}$domain${NC}"
    echo -e "${YELLOW}─────────────────────────────────────${NC}"
    nslookup "$domain" 2>/dev/null || dig "$domain"
}

# Verificar Puertos
check_ports() {
    read -p "Ingresa el host: " host
    echo -e "${GREEN}🔐 Puertos abiertos en ${YELLOW}$host${NC}"
    echo -e "${YELLOW}─────────────────────────────────────${NC}"
    
    common_ports=(21 22 23 25 53 80 110 143 443 445 3306 5432 8080 8443)
    
    for port in "${common_ports[@]}"; do
        timeout 1 bash -c "</dev/tcp/$host/$port" 2>/dev/null && echo -e "${GREEN}✓ Puerto $port: ABIERTO${NC}" || echo -e "${RED}✗ Puerto $port: CERRADO${NC}"
    done
}

# Acerca de
show_about() {
    echo -e "${CYAN}"
    cat << "EOF"
╔════════════════════════════════════════════════════════╗
║                  ACERCA DE IP-TOOL                    ║
╚════════════════════════════════════════════════════════╝

📋 Información:
   • Herramienta de información de IP para Termux
   • Versión: 1.0
   • Plataforma: Linux/Termux
   
🛠️  Características:
   • Obtener IP pública y local
   • Información detallada de IPs
   • Geolocalización
   • Ping a hosts
   • Consultas DNS
   • Verificación de puertos
   
📝 Requisitos:
   • curl o wget
   • ping
   • nslookup o dig
   
👨‍💻 Desarrollador: Tu Nombre
📧 Email: tu@email.com
🌐 GitHub: https://github.com/tuusuario/ip-tool

═══════════════════════════════════════════════════════════
EOF
    echo -e "${NC}"
}

# Loop principal
main() {
    print_banner
    
    while true; do
        show_menu
        read -p "Selecciona una opción: " option
        
        case $option in
            1) clear; get_public_ip; echo; read -p "Presiona Enter para continuar..."; ;;
            2) clear; get_local_ip; echo; read -p "Presiona Enter para continuar..."; ;;
            3) clear; get_ip_info; echo; read -p "Presiona Enter para continuar..."; ;;
            4) clear; get_geo_ip; echo; read -p "Presiona Enter para continuar..."; ;;
            5) clear; get_ip_info; echo; read -p "Presiona Enter para continuar..."; ;;
            6) clear; ping_host; echo; read -p "Presiona Enter para continuar..."; ;;
            7) clear; get_dns_info; echo; read -p "Presiona Enter para continuar..."; ;;
            8) clear; check_ports; echo; read -p "Presiona Enter para continuar..."; ;;
            9) clear; show_about; read -p "Presiona Enter para continuar..."; ;;
            0) echo -e "${YELLOW}¡Hasta pronto! 👋${NC}"; exit 0; ;;
            *) echo -e "${RED}Opción inválida${NC}"; read -p "Presiona Enter para continuar..."; ;;
        esac
        clear
    done
}

# Ejecutar
main
