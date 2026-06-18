#!/bin/bash

# --- حماية التعديل: لا يفتح إلا بكلمة السر 351997 ---
if [ "$1" == "--edit" ]; then
    read -sp "أدخل كلمة سر المطور لتعديل الكود: " pass
    echo ""
    if [ "$pass" != "351997" ]; then
        echo -e "\n[!] خطأ: غير مصرح لك بتعديل هذا المشروع."
        exit 1
    fi
    mousepad "$0"
    exit 0
fi
# ---------------------------------------------------

# تعريف لوحة الألوان المتقدمة لكل خيار
RED='\033[1;31m'
GOLD='\033[1;33m'
BLUE='\033[1;36m'
GREEN='\033[1;32m'
PURPLE='\033[1;35m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
NC='\033[0m' # إعادة اللون للطبيعي

# دالة التوسيط التلقائي المتقدمة لحساب أبعاد الشاشة
print_center() {
    local text="$1"
    local color="$2"
    local term_width=$(tput cols 2>/dev/null || echo 80)
    local clean_text=$(echo -e "$text" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    local text_len=${#clean_text}
    local padding=$(( (term_width - text_len) / 2 ))
    if [ $padding -lt 0 ]; then padding=0; fi
    printf "%${padding}s" ""
    echo -e "${color}${text}${NC}"
}

# دالة طباعة اللوجو العوي المشترك لكل الشاشات
print_logo() {
    print_center "=========================================================================================" "$GOLD"
    print_center " █████╗ ██╗         ███████╗██╗  ██╗ █████╗ ███╗   ██╗ █████╗ ██████╗ ██╗     ███████╗██╗  ██╗" "$RED"
    print_center "██╔══██╗██║         ██╔════╝██║  ██║██╔══██╗████╗  ██║██╔══██╗██╔══██╗██║     ██╔════╝██║  ██║" "$RED"
    print_center "███████║██║         ███████╗███████║███████║██╔██╗ ██║███████║██████╔╝██║     █████╗  ███████║" "$RED"
    print_center "██╔══██║██║         ╚════██║██╔══██║██╔══██║██║╚██╗██║██╔══██║██╔══██║██║     ██╔══╝  ██╔══██║" "$RED"
    print_center "██║  ██║███████╗    ███████║██║  ██║██║  ██║██║ ╚████║██║  ██║██████╔╝███████╗███████╗██║  ██║" "$RED"
    print_center "╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝" "$RED"
    print_center "=========================================================================================" "$GOLD"
}

# دالة لتأكيد تشغيل الأداة أو التراجع عنها مع عرض الشرح
confirm_execution() {
    local title="$1"
    local description="$2"
    clear
    print_logo
    print_center "--- [ شرح الأداة والعملية الحالية ] ---" "$GOLD"
    echo -e "\n"
    echo -e "${GOLD}الأداة/العملية:${NC} ${BLUE}${title}${NC}"
    echo -e "${GOLD}الوصف والشرح البرمجي:${NC}"
    echo -e "${CYAN}${description}${NC}"
    echo -e "\n"
    print_center "[1] تأكيد والبدء في تشغيل الأداة الآن " "$GREEN"
    print_center "[2] إلغاء العملية والعودة للخلف فوراً " "$RED"
    echo -e "\n"
    
    term_width=$(tput cols 2>/dev/null || echo 80)
    local prompt="[:هل تريد الاستمرار؟] "
    local padding=$(( (term_width - ${#prompt}) / 2 ))
    printf "%${padding}s${GOLD}%s${NC}" "" "$prompt"
    read conf
    if [ "$conf" == "1" ]; then
        return 0 # نعم استمر
    else
        return 1 # الغاء
    fi
}

# دالة القائمة الفرعية الخاصة بـ Lynis
lynis_submenu() {
    while true; do
        clear
        print_logo
        print_center "LYNIS SECURITY AUDIT SUB-MENU" "$GOLD"
        echo -e "\n"
        
        # شرح الأداة (باستخدام echo مباشرة لتجنب أخطاء الدوال)
        echo -e "${CYAN}Lynis هي أداة تدقيق أمني لفحص الثغرات وإعدادات النظام.${NC}"
        echo -e "${CYAN}تقوم بفحص النواة والخدمات وصلاحيات الملفات لتقوية النظام.${NC}"
        echo -e "${CYAN}تحليل المكونات الحساسة: تقوم الأداة بفحص إعدادات النواة (Kernel)، الخدمات التي تعمل في الخلفية، وصلاحيات الوصول للملفات (Permissions) للتأكد من أنها مضبوطة بشكل صحيح.${NC}"
        echo -e "${CYAN}تقديم تقارير التقوية (Hardening): لا تكتفي الأداة بكشف الأخطاء فقط، بل تقدم تقريراً مفصلاً يتضمن نصائح عملية حول كيفية تقوية حماية النظام وسد الثغرات المكتشفة.${NC}"
        echo -e "${CYAN}الأداة التعليمية: تُعد وسيلة ممتازة للمهتمين بالأمن السيبراني، حيث تساعدهم على التفكير بعقلية الخبراء الأمنيين لاكتشاف نقاط الضعف قبل استغلالها من قبل المهاجمين.${NC}"
        echo -e "\n"
        
        # خيارات القائمة
        echo -e "${CYAN}[1] تحديث النظام وتثبيت Lynis${NC}"
        echo -e "${BLUE}[2] تحميل أحدث نسخة من GitHub${NC}"
        echo -e "${GREEN}[3] تشغيل فحص التدقيق الأمني${NC}"
        echo -e "${RED}[4] العودة للقائمة الرئيسية${NC}"
        echo -e "\n"
        
        read -p "[:اختر رقم العملية:] " lynis_choice
        
        case $lynis_choice in
            1) sudo apt update && sudo apt install -y lynis ;;
            2) mkdir -p ~/tools && cd ~/tools && git clone https://github.com/CISOfy/lynis ;;
            3) if [ -d "$HOME/tools/lynis" ]; then sudo $HOME/tools/lynis/lynis audit system; else sudo lynis audit system; fi ;;
            4) break ;;
            *) echo -e "${RED}خيار غير صحيح${NC}" ; sleep 1 ;;
        esac
    done
}


# 1. القائمة الفرعية الخاصة بـ Tor
tor_submenu() {
    while true; do
        clear
        print_logo
        print_center "                       TOR ANONYMITY AND NETWORKING SUB-MENU                             " "$GOLD"
        print_center "=========================================================================================" "$GOLD"
        echo -e "\n\n"
        print_center "[1] تحميل وتنزيل حزمة التور والاعتماديات (Install Tor)      " "$CYAN"
        echo ""
        print_center "[2] تفعيل وضع التخفي التام وتغيير الـ IP عشوائياً (Start Tor) " "$GREEN"
        echo ""
        print_center "[3] إيقاف وضع التخفي والعودة إلى الاتصال الطبيعي (Stop Tor) " "$ORANGE"
        echo ""
        print_center "[4] التأكد من تغيير الـ IP وفحص موقعك الجغرافي الحالي       " "$BLUE"
        echo ""
        print_center "[5] العودة إلى القائمة الرئيسية للمشروع                      " "$RED"
        echo -e "\n\n"
        read tor_choice
        case $tor_choice in
            1) sudo apt update && sudo apt install -y tor proxychains4 ;;
            2) sudo systemctl start tor ;;
            3) sudo systemctl stop tor ;;
            4) curl -s https://ipinfo.io/json | grep -E '"ip"|"country"|"region"|"city"' ; read ;;
            5) break ;;
        esac
    done
}

# 2. القائمة الفرعية الخاصة بـ Wireshark
wireshark_submenu() {
    while true; do
        clear
        print_logo
        print_center "                     WIRESHARK PACKET ANALYSIS SUB-MENU                                  " "$GOLD"
        print_center "=========================================================================================" "$GOLD"
        echo -e "\n\n"
        print_center "[1] تثبيت أداة تحليل شبكات الاتصال (Install Wireshark)      " "$CYAN"
        echo ""
        print_center "[2] تشغيل واجهة Wireshark الرسومية لتحليل الحزم             " "$GREEN"
        echo ""
        print_center "[3] إيقاف وإغلاق كافة عمليات برنامج Wireshark              " "$ORANGE"
        echo ""
        print_center "[4] العودة إلى القائمة الرئيسية للمشروع                      " "$RED"
        echo -e "\n\n"
        read ws_choice
        case $ws_choice in
            1) sudo apt update && sudo apt install -y wireshark ;;
            2) sudo wireshark > /dev/null 2>&1 & ;;
            3) sudo pkill wireshark ;;
            4) break ;;
        esac
    done
}

# القائمة الرئيسية للمشروع
while true; do
    clear
    print_logo
    print_center "                    ADVANCED CYBERSECURITY FRAMEWORK BY AHMAD SHANABLEH                    " "$GOLD"
    print_center "=========================================================================================" "$GOLD"
    echo -e "\n\n"

    print_center "[1] تثبيت وتحديث كافة أدوات النظام والاعتماديات الأساسية     " "$BLUE"
    echo ""
    print_center "[2] نظام التدقيق الأمني الشامل (Lynis Audit Menu)           " "$PURPLE"
    echo ""
    print_center "[3] تشغيل وإدارة خيارات جدار الحماية (UFW Sub-menu)         " "$CYAN"
    echo ""
    print_center "[4] أدوات التخفي الكامل والتحكم بشبكة المجهولية (Tor Menu)   " "$GREEN"
    echo ""
    print_center "[5] أدوات تحليل وحقن شبكات الاتصال المتقدمة (Wireshark Menu) " "$PURPLE"
    echo ""
    print_center "[6] الهندسة الاجتماعية واصطياد الحسابات (Zphisher)         " "$ORANGE"
    echo ""
    print_center "[7] فحص ثغرات الويب الشامل وحقن البيانات (Nikto & Sqlmap)   " "$RED"
    echo ""
    print_center "[8] فحص الشبكات والمنافذ المتقدم (Nmap)                     " "$BLUE"
    echo ""
    print_center "[9] جمع النطاقات الفرعية للدومينات (Subfinder)             " "$CYAN"
    echo ""
    print_center "[10] ميثاق العمل والضوابط القانونية الصارمة                  " "$GOLD"
    echo ""
    print_center "[11] خروج من الإطار السيبراني                               " "$RED"
    echo -e "\n\n"

    read choice

    case $choice in
        1)
            if confirm_execution "تثبيت وتحديث أدوات النظام" "تحديث المستودعات وتثبيت الأدوات الأساسية."; then
                sudo apt update && sudo apt install -y nikto nmap subfinder sqlmap php curl unzip wget ufw proxychains4
                read
            fi ;;
        2) lynis_submenu ;;
        3)
            while true; do
                clear
                print_logo
                print_center "=== قائمة جدار الحماية (UFW) ===" "$GOLD"
                echo -e "\n"
                print_center "[1] تثبيت [2] تشغيل [3] إيقاف [4] عودة" "$BLUE"
                read -p "اختر: " ufw_choice
                case $ufw_choice in
                    1) sudo apt install ufw -y ;;
                    2) sudo ufw enable ;;
                    3) sudo ufw disable ;;
                    4) break ;;
                esac
            done ;;
        4) tor_submenu ;;
        5) wireshark_submenu ;;
        6)
            if [ ! -d "zphisher" ]; then git clone --depth=1 https://github.com/htr-tech/zphisher.git; fi
            cd zphisher && bash zphisher.sh ;;
        7)
            echo ""; printf "أدخل الرابط: "; read web; nikto -h $web ; read ;;
        8)
            echo ""; printf "أدخل الهدف: "; read nmap_t; sudo nmap -A $nmap_t ; read ;;
        9)
            echo ""; printf "أدخل الدومين: "; read sub; subfinder -d $sub ; read ;;
        10)
            echo "ميثاق العمل..."; read ;;
        11) exit 0 ;;
        *) echo "خيار غير صحيح" ; sleep 1 ;;
    esac
done
