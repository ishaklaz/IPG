#!/bin/bash

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Reset color

# Banner
clear
echo -e "${BLUE}"
echo "██╗██████╗  ██████╗ "
echo "██║██╔══██╗██╔════╝ "
echo "██║██████╔╝██║  ███╗"
echo "██║██╔═══╝ ██║   ██║"
echo "██║██║     ╚██████╔╝"
echo "╚═╝╚═╝      ╚═════╝ "
echo -e "      IP Ghost (IPG) v1.0        "
echo -e "  Coded by: Ishak Lazri (Lazarus)"
echo -e "  Telegram: @ishaklaz            "
echo -e "====================================${NC}"
echo ""

# Main Menu
while true; do
    echo -e "${GREEN}Select an option:${NC}"
    echo "1️⃣ Scan Your Network"
    echo "2️⃣ Targeting IP"
    echo "0️⃣ Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) 
            echo -e "${BLUE}Scanning your network...${NC}"
            sudo arp-scan --localnet
            ;;
        2)
            echo -e "${GREEN}Targeting IP - Select an option:${NC}"
            echo "1️⃣ Scan Open Ports"
            echo "2️⃣ Track IP Location"
            echo "3️⃣ Analyzing OS"
            echo "4️⃣ IP / MAC OSINT"
            read -p "Enter your choice: " target_choice

            case $target_choice in
                1) 
                    read -p "Enter target IP: " target
                    echo -e "${BLUE}Scanning open ports on $target...${NC}"
                    nmap -sV $target
                    ;;
                2)
                    read -p "Enter target IP: " target
                    echo -e "${BLUE}Tracking location for $target...${NC}"
                    curl -s "http://ip-api.com/json/$target" | jq .
                    ;;
                3)
                    read -p "Enter target IP: " target
                    echo -e "${BLUE}Analyzing OS for $target...${NC}"
                    nmap -O $target | grep "OS details"
                    ;;
                4)
                    echo "1️⃣ IP OSINT"
                    echo "2️⃣ MAC OSINT"
                    read -p "Enter your choice: " osint_choice
                    if [ "$osint_choice" -eq 1 ]; then
                        read -p "Enter IP Address: " ip
                        echo -e "${BLUE}Fetching OSINT data for $ip...${NC}"
                        curl -s "http://ip-api.com/json/$ip" | jq .
                    elif [ "$osint_choice" -eq 2 ]; then
                        read -p "Enter MAC Address: " mac
                        echo -e "${BLUE}Fetching device information...${NC}"
                        curl -s "https://api.macvendors.com/$mac"
                    else
                        echo -e "${RED}Invalid choice!${NC}"
                    fi
                    ;;
                *)
                    echo -e "${RED}Invalid option!${NC}"
                    ;;
            esac
            ;;
        0)
            echo -e "${RED}Exiting...${NC}"
            exit
            ;;
        *)
            echo -e "${RED}Invalid choice! Please select a valid option.${NC}"
            ;;
    esac
done