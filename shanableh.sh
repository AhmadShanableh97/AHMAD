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

# 1. القائمة الفرعية الخاصة بـ Tor (Tor Sub-menu)
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
        
        term_width=$(tput cols 2>/dev/null || echo 80)
        prompt="[:اختر رقم العملية من قائمة التور] "
        padding=$(( (term_width - ${#prompt}) / 2 ))
        if [ $padding -lt 0 ]; then padding=0; fi
        printf "%${padding}s${GOLD}%s${NC}" "" "$prompt"
        read tor_choice
        
        case $tor_choice in
            1)
                if confirm_execution "تحميل حزمة Tor" "تقوم هذه العملية بتحديث مستودعات النظام وتنزيل خدمات Tor مع أداة proxychains4 المسؤولة عن تمرير كافة اتصالات برامجك وتشفيرها عبر نفق شبكة البصلة مجهولة الهوية لتأمين بيئة عملك."; then
                    echo ""
                    print_center "[+] جاري تحميل وتثبيت حزمة Tor والـ proxychains..." "$GOLD"
                    sudo apt update && sudo apt install -y tor proxychains4
                    print_center "[+] تم التثبيت بنجاح! اضغط إنتر للمتابعة..." "$GREEN"
                    read
                fi
                ;;
            2)
                if confirm_execution "تفعيل وضع التخفي (Start Tor)" "تقوم بتشغيل خدمة Tor في خلفية نظام كالي لينكس وبدء بناء الدوائر المشفرة والمحطات الوهمية لتغيير الـ IP الخاص بجهازك وحظر تعقب موقعك الجغرافي الحقيقي."; then
                    echo ""
                    print_center "[+] جاري تشغيل وتفعيل وضع التخفي..." "$GOLD"
                    if ! command -v tor &> /dev/null; then
                        print_center "[!] حزمة Tor غير مثبتة. اختر [1] أولاً للتحميل." "$RED"
                    else
                        sudo systemctl start tor
                        print_center "[+] تم التفعيل المجهول بنجاح! اضغط إنتر للمتابعة..." "$GREEN"
                    fi
                    read
                fi
                ;;
            3)
                if confirm_execution "إيقاف وضع التخفي (Stop Tor)" "تقوم بإغلاق وفصل خدمة Tor من خلفية النظام، وبالتالي فك تشفير النفق وإعادة جهازك إلى الاتصال المباشر الطبيعي بشبكة الإنترنت المحلية برقم الـ IP الأصلي الخاص بك."; then
                    echo ""
                    print_center "[+] جاري إيقاف وضع التخفي والعودة للوضع الطبيعي..." "$GOLD"
                    sudo systemctl stop tor
                    print_center "[+] عاد اتصالك طبيعي ومباشر! اضغط إنتر للمتابعة..." "$GREEN"
                    read
                fi
                ;;
            4)
                if confirm_execution "فحص الـ IP والموقع الجغرافي" "تقوم الأداة بفحص ذكي للاتصال؛ في حال كان نفق التخفي مفعل، سيتم إجبار أداة curl على جلب الـ IP الوهمي الجديد (مثل ألمانيا أو أمريكا)، وإن كان مغلقاً ستظهر الـ IP والموقع الحقيقي لشبكتك الحالية بمدينة الزرقاء."; then
                    echo ""
                    print_center "[+] جاري فحص عنوان الـ IP الخارجي والموقع الجغرافي..." "$GOLD"
                    echo ""
                    if systemctl is-active --quiet tor; then
                        echo -e "${BLUE}الـ IP الحالي والموقع (نفق التخفي يعمل بنجاح):${NC}"
                        curl --socks5-hostname 127.0.0.1:9050 -s https://ipinfo.io/json | grep -E '"ip"|"country"|"region"|"city"'
                    else
                        echo -e "${BLUE}الـ IP الحالي والموقع (الاتصال الطبيعي المباشر):${NC}"
                        curl -s https://ipinfo.io/json | grep -E '"ip"|"country"|"region"|"city"'
                    fi
                    echo ""
                    print_center "اضغط إنتر للمتابعة..." "$GOLD"
                    read
                fi
                ;;
            5)
                break
                ;;
            *)
                print_center "[!] خيار غير صحيح!" "$RED"
                sleep 1
                ;;
        esac
    done
}

# 2. القائمة الفرعية الخاصة بـ Wireshark (Wireshark Sub-menu)
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
        
        term_width=$(tput cols 2>/dev/null || echo 80)
        prompt="[:اختر رقم العملية من قائمة واير شارك] "
        padding=$(( (term_width - ${#prompt}) / 2 ))
        if [ $padding -lt 0 ]; then padding=0; fi
        printf "%${padding}s${GOLD}%s${NC}" "" "$prompt"
        read ws_choice
        
        case $ws_choice in
            1)
                if confirm_execution "تثبيت Wireshark" "تنزيل وتثبيت أداة Wireshark العملاقة والمخصصة لعمليات التلصص وتحليل بروتوكولات حزم البيانات (Packet Analysis & Sniffing) العابرة داخل الشبكة السلكية واللاسلكية للتحقيق في البيانات."; then
                    echo ""
                    print_center "[+] جاري تحميل وتثبيت أداة Wireshark..." "$GOLD"
                    sudo apt update && sudo apt install -y wireshark
                    print_center "[+] تم التثبيت بنجاح! اضغط إنتر للمتابعة..." "$GREEN"
                    read
                fi
                ;;
            2)
                if confirm_execution "تشغيل Wireshark" "تشغيل واجهة البرنامج الرسومية (GUI) بصلاحيات الـ root الكاملة لتمكين الأداة من رصد وقراءة كروت الشبكة بالكامل (مثل wlan0 أو eth0). سيتم فتحها في الخلفية ليبقى الترمينال مستقراً وجاهزاً للعمل."; then
                    echo ""
                    print_center "[+] جاري تشغيل واجهة Wireshark في الخلفية..." "$GOLD"
                    sudo wireshark > /dev/null 2>&1 &
                    print_center "[+] تم التشغيل بنجاح! اضغط إنتر للمتابعة..." "$GREEN"
                    read
                fi
                ;;
            3)
                if confirm_execution "إغلاق Wireshark" "تقوم الأداة برصد العمليات البرمجية الجارية للبرنامج وقتلها فوراً من الجذور وعمل (Kill Process)، مما يضمن إغلاق البرنامج بالكامل وتحرير ذاكرة النظام المستهلكة."; then
                    echo ""
                    print_center "[+] جاري إغلاق كافة عمليات برنامج Wireshark..." "$GOLD"
                    sudo pkill wireshark
                    print_center "[+] تم إنهاء وإغلاق البرنامج بالكامل! اضغط إنتر للمتابعة..." "$GREEN"
                    read
                fi
                ;;
            4)
                break
                ;;
            *)
                print_center "[!] خيار غير صحيح!" "$RED"
                sleep 1
                ;;
        esac
    done
}

# القائمة الرئيسية للمشروع (Main Framework Menu)
while true; do
    clear
    print_logo
    print_center "                    ADVANCED CYBERSECURITY FRAMEWORK BY AHMAD SHANABLEH                    " "$GOLD"
    print_center "=========================================================================================" "$GOLD"
    echo -e "\n\n"

    print_center "[1] تثبيت وتحديث كافة أدوات النظام والاعتماديات الأساسية     " "$BLUE"
    echo ""
    print_center "[2] تشغيل وإدارة خيارات جدار الحماية (UFW Sub-menu)         " "$CYAN"
    echo ""
    print_center "[3] أدوات التخفي الكامل والتحكم بشبكة المجهولية (Tor Menu)   " "$GREEN"
    echo ""
    print_center "[4] أدوات تحليل وحقن شبكات الاتصال المتقدمة (Wireshark Menu) " "$PURPLE"
    echo ""
    print_center "[5] الهندسة الاجتماعية واصطياد الحسابات (Zphisher)         " "$ORANGE"
    echo ""
    print_center "[6] فحص ثغرات الويب الشامل وحقن البيانات (Nikto & Sqlmap)   " "$RED"
    echo ""
    print_center "[7] فحص الشبكات والمنافذ المتقدم (Nmap)                     " "$BLUE"
    echo ""
    print_center "[8] جمع النطاقات الفرعية للدومينات (Subfinder)             " "$CYAN"
    echo ""
    print_center "[9] ميثاق العمل والضوابط القانونية الصارمة                  " "$GOLD"
    echo ""
    print_center "[12] نظام التدقيق الأمني الشامل (Security Audit System)     " "$PURPLE"
    echo ""
    print_center "[10] خروج من الإطار السيبراني                               " "$RED"
    echo -e "\n\n"

    term_width=$(tput cols 2>/dev/null || echo 80)
    prompt="[:اختر رقم العملية] "
    padding=$(( (term_width - ${#prompt}) / 2 ))
    if [ $padding -lt 0 ]; then padding=0; fi
    printf "%${padding}s${GOLD}%s${NC}" "" "$prompt"
    read choice

    case $choice in
        1)
            if confirm_execution "تثبيت وتحديث أدوات النظام" "تقوم هذه العملية بتحديث مستودعات التوزيعة الرسمية وتثبيت كافة الأدوات والاعتماديات التي يحتاجها السكربت بالكامل ليعمل بسلاسة تامة وبدون أي نقص في الحزم البرمجية."; then
                echo ""
                sudo apt update && sudo apt install -y nikto nmap subfinder sqlmap php curl unzip wget ufw proxychains4
                echo "اضغط إنتر للمتابعة..."; read
            fi
            ;;
        2)
            while true; do
                clear
                print_logo
                print_center "=== قائمة جدار الحماية (UFW) ===" "$GOLD"
                echo -e "\n"
                print_center "[1] تثبيت جدار الحماية" "$BLUE"
                print_center "[2] تشغيل جدار الحماية" "$CYAN"
                print_center "[3] إيقاف جدار الحماية" "$ORANGE"
                print_center "[4] العودة للقائمة الرئيسية" "$RED"
                echo -e "\n"
                read -p "اختر عملية: " ufw_choice
                case $ufw_choice in
                    1) sudo apt install ufw -y ; read ;;
                    2) sudo ufw enable ; read ;;
                    3) sudo ufw disable ; read ;;
                    4) break ;;
                    *) echo "خيار غير صحيح" ;;
                esac
            done
            ;;
        3)
            tor_submenu ;;
        4)
            wireshark_submenu ;;
        5)
            if confirm_execution "الهندسة الاجتماعية وعمليات الاصطياد (Zphisher)" "أداة متقدمة مخصصة لاختبار اختراق الوعي الأمني للمستخدمين، تقوم بتوليد صفحات تسجيل دخول مزيفة ومطابقة تماماً لأكثر من 30 منصة عالمية لبيان وتوضيح كيفية سرقة واصطياد الحسابات وتفاديها."; then
                echo ""
                if [ ! -d "zphisher" ]; then git clone --depth=1 https://github.com/htr-tech/zphisher.git; fi
                cd zphisher && bash zphisher.sh
            fi
            ;;
        6)
            clear
            echo -e "${RED}"
            print_center "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" "$RED"
            print_center "⚠️  تحذير أمني صارم: الخيار يتطلب تصريح قانوني! انتبه لا تستعمل بدون تصريح ⚠️" "$RED"
            print_center "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" "$RED"
            echo -e "${NC}\n"
            print_center "[1] فحص خوادم الويب الشامل وعرض الثغرات المفتوحة (Nikto)" "$GOLD"
            print_center "[2] فحص واستغلال ثغرات حقن قواعد البيانات (Sqlmap)" "$ORANGE"
            print_center "[3] العودة إلى القائمة الرئيسية للمشروع" "$BLUE"
            echo -e "\n"
            read -p "[:اختر أداة الفحص المستهدفة:] " web_choice
            
            case $web_choice in
                1)
                    if confirm_execution "فحص ثغرات خوادم الويب (Nikto)" "ماسح ويب شامل يقوم بفحص خوادم ومواقع الويب للبحث عن الملفات والملحقات الخطيرة، البرمجيات القديمة غير المحدثة، والمشاكل الأمنية الناتجة عن سوء الإعدادات."; then
                        echo ""; printf "أدخل الرابط المستهدف: "; read web; nikto -h $web
                        echo "اضغط إنتر للمتابعة..."; read
                    fi
                    ;;
                2)
                    if confirm_execution "حقن ثغرات قواعد البيانات (Sqlmap)" "أداة آلية شديدة القوة مخصصة لاكتشاف واستغلال ثغرات حقن السيQual (SQL Injection) في المواقع، وقادرة على سحب جداول البيانات بالكامل واستخراج كلمات المرور."; then
                        echo ""; printf "أدخل الرابط المستهدف لفحص الـ SQL: "; read sql_t; sqlmap -u $sql_t --batch --banner
                        echo "اضغط إنتر للمتابعة..."; read
                    fi
                    ;;
                3)
                    ;;
                *)
                    echo "خيار غير صحيح" ; sleep 1
                    ;;
            esac
            ;;
        7)
            if confirm_execution "فحص المنافذ والشبكات (Nmap)" "الأداة الرائدة عالمياً لمسح وفحص الشبكات، تقوم برصد الأجهزة النشطة وتحديد المنافذ المفتوحة وجلب تفاصيل دقيقة عن إصدارات الخدمات وأنظمة التشغيل المستهدفة."; then
                echo ""; printf "أدخل الهدف (IP أو دومين): "; read nmap_t; sudo nmap -A $nmap_t
                echo "اضغط إنتر للمتابعة..."; read
            fi
            ;;
        8)
            if confirm_execution "جمع النطاقات الفرعية (Subfinder)" "أداة استخباراتية مخصصة لجمع المعلومات في مرحلة الاستطلاع الفعال، تقوم بالبحث وجلب كافة النطاقات الفرعية (Subdomains) Tابعة للدومين الرئيسي للمستهدف."; then
                echo ""; printf "أدخل الدومين المراد فحصه: "; read sub; subfinder -d $sub
                echo "اضغط إنتر للمتابعة..."; read
            fi
            ;;
        9)
            clear
            print_center "=== تنبيه قانوني وميثاق استخدام ===" "$RED"
            echo -e "\nهذا السكربت مخصص للأغراض التعليمية واختبار الاختراق الأخلاقي فقط."
            echo -e "يجب الحصول على تصريح قانوني مكتوب قبل فحص أي شبكة لا تملكها."
            echo -e "أنت المسؤول الوحيد عن أي استخدام غير قانوني أو هجوم غير مصرح به.\n"
            read -p "هل توافق على الشروط وتلتزم بالقوانين؟ [1] نعم [2] خروج: " leg
            [[ "$leg" != "1" ]] && exit 0
            ;;
        12)
            clear
            echo -e "${RED}"
            print_center "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" "$RED"
            print_center "⚠️  تحذير أمني صارم: يتطلب تصريح قانوني وكتابي قبل الفحص ⚠️" "$RED"
            print_center "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" "$RED"
            echo -e "${NC}\n"
            echo -e "${BLUE}[+] سجلات الدخول:${NC}"
            grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 3
            echo -e "\n${BLUE}[+] حالة جدار الحماية:${NC}"
            sudo ufw status
            echo -e "\n${BLUE}[+] المنافذ المفتوحة:${NC}"
            sudo netstat -tulpn | grep LISTEN
            echo -e "\n"
            read -p "اضغط إنتر للعودة..."
            ;;
        10)
            echo ""
            print_center "بالتوفيق يا أحمد الحارس السيبراني!" "$RED"
            exit 0 ;;
        *)
            echo ""
            print_center "[!] خيار غير صحيح!" "$RED"
            sleep 1 ;;
    esac
done
