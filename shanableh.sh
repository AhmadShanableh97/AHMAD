#!/bin/bash

# الألوان (تم تحويل المتغيرات للإنجليزية لتجنب خطأ bad substitution)
GRAY="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# شعار الأداة
function banner() {
    clear
    echo -e "${GRAY}=========================================================================="
    echo -e "${RED}  ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗ █████╗ ██████╗ ██╗     ███████╗██╗  ██╗"
    echo -e "${RED}  ██╔════╝ ██║  ██║██╔══██╗████╗  ██║██╔══██╗██╔══██╗██║     ██╔════╝██║  ██║"
    echo -e "${RED}  ╚█████╗  ███████║███████║██╔██╗ ██║███████║██████╔╝██║     █████╗  ███████║"
    echo -e "${RED}   ╚═══██╗ ██╔══██║██╔══██║██║╚██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██║"
    echo -e "${RED}  ██████╔╝ ██║  ██║██║  ██║██║ ╚████║██║  ██║██████╔╝███████╗███████╗██║  ██║"
    echo -e "${RED}  ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝"
    echo -e "${YELLOW}               ADVANCED CYBERSECURITY FRAMEWORK BY AHMAD SHANABLEH"
    echo -e "${GRAY}=========================================================================="
}

# القائمة الرئيسية
function main_menu() {
    banner
    echo -e "${GREEN}[1]${RESET} فحص الشبكات (Nmap)"
    echo -e "${GREEN}[2]${RESET} جمع النطاقات الفرعية (Subfinder)"
    echo -e "${GREEN}[3]${RESET} فحص ثغرات SQL (Sqlmap)"
    echo -e "${GREEN}[4]${RESET} تخمين كلمات المرور (Hydra)"
    echo -e "${GREEN}[5]${RESET} فحص اتصال Proxychains"
    echo -e "${GREEN}[6]${RESET} تحديث وتثبيت الأدوات"
    echo -e "${RED}[7]${RESET} خروج"
    echo
    echo -n -e "${BLUE}اختر رقم العملية: ${RESET}"
    read choice
    
    case $choice in
        1) nmap_scan ;;
        2) subfinder_scan ;;
        3) sqlmap_scan ;;
        4) hydra_attack ;;
        5) check_proxy ;;
        6) update_system ;;
        7) exit 0 ;;
        *) echo -e "${RED}خيار خاطئ!${RESET}"; sleep 1; main_menu ;;
    esac
}

# الوظائف التفاعلية
function nmap_scan() { banner; echo -n "أدخل الهدف: "; read target; nmap -A $target; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function subfinder_scan() { banner; echo -n "أدخل النطاق: "; read domain; subfinder -d $domain; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function sqlmap_scan() { banner; echo -n "أدخل الرابط المصاب: "; read url; sqlmap -u "$url" --dbs --batch; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function hydra_attack() { banner; echo -n "الهدف: "; read target; echo -n "الخدمة: "; read service; hydra -l admin -P /usr/share/wordlists/rockyou.txt $target $service; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function check_proxy() { banner; proxychains curl ifconfig.me; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function update_system() { sudo apt update && sudo apt install -y nmap hydra sqlmap subfinder; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }

main_menu

#!/bin/bash

# الألوان
الرمادي="\033[1;30m"
الأحمر="\033[1;31m"
الأخضر="\033[1;32m"
الأصفر="\033[1;33m"
الأزرق="\033[1;34m"
الاستعادة="\033[0m"

# شعار الأداة المعدل
function banner() {
    clear
    echo -e "${الرمادي}=========================================================================="
    echo -e "${الأحمر}  ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗ █████╗ ██████╗ ██╗     ███████╗██╗  ██╗"
    echo -e "${الأحمر}  ██╔════╝ ██║  ██║██╔══██╗████╗  ██║██╔══██╗██╔══██╗██║     ██╔════╝██║  ██║"
    echo -e "${الأحمر}  ╚█████╗  ███████║███████║██╔██╗ ██║███████║██████╔╝██║     █████╗  ███████║"
    echo -e "${الأحمر}   ╚═══██╗ ██╔══██║██╔══██║██║╚██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██║"
    echo -e "${الأحمر}  ██████╔╝ ██║  ██║██║  ██║██║ ╚████║██║  ██║██████╔╝███████╗███████╗██║  ██║"
    echo -e "${الأحمر}  ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝"
    echo -e "${الأصفر}               ADVANCED CYBERSECURITY FRAMEWORK BY AHMAD SHANABLEH"
    echo -e "${الرمادي}=========================================================================="
}

# القائمة الرئيسية
function main_menu() {
    banner
    echo -e "${الأخضر}[1]${الاستعادة} فحص الشبكات (Nmap)"
    echo -e "${الأخضر}[2]${الاستعادة} جمع النطاقات الفرعية (Subfinder)"
    echo -e "${الأخضر}[3]${الاستعادة} فحص ثغرات SQL (Sqlmap)"
    echo -e "${الأخضر}[4]${الاستعادة} تخمين كلمات المرور (Hydra)"
    echo -e "${الأخضر}[5]${الاستعادة} فحص اتصال Proxychains"
    echo -e "${الأخضر}[6]${الاستعادة} تحديث وتثبيت الأدوات"
    echo -e "${الأحمر}[7]${الاستعادة} خروج"
    echo
    echo -n -e "${الأزرق}اختر رقم العملية: ${الاستعادة}"
    read choice
    
    case $choice in
        1) nmap_scan ;;
        2) subfinder_scan ;;
        3) sqlmap_scan ;;
        4) hydra_attack ;;
        5) check_proxy ;;
        6) update_system ;;
        7) exit 0 ;;
        *) echo -e "${الأحمر}خيار خاطئ!${الاستعادة}"; sleep 1; main_menu ;;
    esac
}

# الوظائف التفاعلية
function nmap_scan() { banner; echo -n "أدخل الهدف: "; read target; nmap -A $target; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function subfinder_scan() { banner; echo -n "أدخل النطاق: "; read domain; subfinder -d $domain; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function sqlmap_scan() { banner; echo -n "أدخل الرابط المصاب: "; read url; sqlmap -u "$url" --dbs --batch; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function hydra_attack() { banner; echo -n "الهدف: "; read target; echo -n "الخدمة: "; read service; hydra -l admin -P /usr/share/wordlists/rockyou.txt $target $service; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function check_proxy() { banner; proxychains curl ifconfig.me; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }
function update_system() { sudo apt update && sudo apt install -y nmap hydra sqlmap subfinder; echo -e "\nاضغط Enter للعودة..."; read; main_menu; }

main_menu
