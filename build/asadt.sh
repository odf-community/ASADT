#!/bin/bash

# Assistive Search And Discovery Tool
# Mark 2 | CODENAME ALPHA | Release ID git118
# Script Maintained & Developed by ODFSEC

# Special Thanks To These GitHub Users:
# @Fidian & @Albfan For Code Collabs!

# This Script Is Licensed Under GNU-GPL v3
# Completely Free To Use, Modify & Redistribute!
# No Redistribution For Financial or Civil Gain.

# For Safety & Security Reasons, This Script's Functions
# Will Sometimes Have Comments Explaining What Exactly The Function
# Does. If Something Seems Incorrect, Or Even Unsafe, Please Let Us Know
# @ https://github.com/odf-community/ASADT/discussions


# Args
arg1="$1"
arg2="$2"
palace="/usr/bin/asadt/asadt.sh"

checkuid () {

    if [ "$UID" -eq "0" ]; then

        su_uid="true"

    else

        echo ""
        echo "[ ERROR ] MainProg File $0 Requires Sudo Privledges!"
        echo "[ INFO ] Displaying Policy-Kit (polkit) Stub For Authentication!"
        
        sleep 1
        
        echo ""
        echo "[ WARNING ] It is suggested that you execute using sudo command!"
        echo "[ WARNING ] Executing with 'pkexec' may disable the use of GUI promts!"
        echo ""

        sleep 3
        
        pkexec $palace $arg1 $arg2

        exit

    fi

}

tmphandle () {

    if [ -d "/tmp/asadt" ]; then

        localtemp="/tmp/asadt"

    else

        echo ""
        echo "[ TEMP HANDLER ] Temp Directory Missing! Something Deleted It???"
        echo "[ TEMP HANDLER ] Creating Temporary Directory"
        echo ""

        mkdir /tmp/asadt

    fi

}

integritychk () {

    whichhave="0"
    whichdonthave="0"
    intpass="0"

    dep_zenity=$(which zenity)
    dep_expr=$(which expr)
    dep_sudo=$(which sudo)
    dep_nmap=$(which nmap)
    dep_nikto=$(which nikto)
    dep_wpscan=$(which wpscan)
    dep_dnsmap=$(which dnsmap)
    dep_dmitry=$(which dmitry)
    dep_assetfinder=$(which assetfinder)
    dep_msfpc=$(which msfpc)
    dep_sqlmap=$(which sqlmap)
    dep_thcssldos=$(which thc-ssl-dos)

    if [ -f "/tmp/asadt/.aptchk" ]; then

        . "/tmp/asadt/.aptchk"

    else

        skiptemp="false"

    fi

    file_src_chk () {

        if [ -f "/usr/bin/asadt/lib/bin/bash-ini-parser" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/bin/ansi" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/bin/zenity" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/visual_prog/displayboxhandler.service" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/ini/main.ini" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/ini/modules.ini" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/mainprog.func" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/modules/brutetool.module" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/modules/exemkr.module" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ -f "/usr/bin/asadt/lib/mainprog/modules/scantool.module" ]; then

            intpass=$(expr "$intpass" + 1)

        fi

        if [ "$intpass" = "10" ]; then

            intpass="true"

        else

            intfail=$(expr 10 - "$intpass")

            echo ""
            echo "[ WARNING ] Integrity Check Failed!"
            echo "[ WARNING ] /usr/bin/asadt Is Missing $intfail Required Files To Launch"
            echo "[ INFO ] To Fix This Issue, Please Rebuild The Program!"
            echo ""
            echo "[ DEBUG ] function 'integritychk/file_src_chk' responded the following data"
            echo "[ DEBUG ] 'intpass' = $intpass"
            echo "[ DEBUG ] 'intfail' = $intfail"

            echo ""

            echo "This Integrity Check Function is unskipple and must be fixed prior to launch."
            echo "Press enter to exit"
            read nulkey

            exit

        fi

    }

    apt_src_chk () {

        if [ "$dep_zenity" = "/usr/bin/zenity" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_expr" = "/usr/bin/expr" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_sudo" = "/usr/bin/sudo" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_nmap" = "/usr/bin/nmap" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_nikto" = "/usr/bin/nikto" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_dnsmap" = "/usr/bin/dnsmap" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_dmitry" = "/usr/bin/dmitry" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_assetfinder" = "/usr/bin/assetfinder" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_msfpc" = "/usr/bin/msfpc" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_sqlmap" = "/usr/bin/sqlmap" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_thcssldos" = "/usr/bin/thc-ssl-dos" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$dep_wpscan" = "/usr/bin/wpscan" ]; then

            whichhave=$(expr "$whichhave" + 1)

        else

            whichdonthave=$(expr "$whichdonthave" + 1)

        fi

        if [ "$whichdonthave" = "0" ]; then

            aptsrcpass="true"

        else

            echo ""
            echo "[ WARNING ] Integrity Check Failed!"
            echo "[ WARNING ] /usr/bin/asadt Is Missing $whichdonthave Dependencies!"
            echo "[ INFO ] To Fix This Issue, Please Execute The Following Command:"
            echo "[ INFO ] sudo $0 --getdep"
            echo ""
            echo "[ DEBUG ] function 'integritychk/apt-src-chk' responded the following data"
            echo "[ DEBUG ] 'whichhave' = $whichhave"
            echo "[ DEBUG ] 'whichdonthave' = $whichdonthave"

            echo ""

            echo "This Could Potentially Be A False Positive"
            echo "To Skip The Integrity Check, Please Press [ENTER], Otherwise, Exit The Script"
            echo ""
            echo -n "Continue? "

            read nulkey

            if [ -f "/tmp/asadt/.aptchk" ]; then

                rm "/tmp/asadt/.aptchk"

                echo "apt_src_chk_skip=true" > "/tmp/asadt/.aptchk"

            else

                echo "apt_src_chk_skip=true" > "/tmp/asadt/.aptchk"

            fi

            echo ""
            echo "[ WARNING ] MISSING PROG DEPENDENCIES! SOME THINGS MIGHT NOT WORK PROPERLY!"
            echo "[ WARNING ] PLEASE ENSURE YOU HAVE ALL AVAILABLE TOOLS INSTALLED!"
            echo ""
            echo "[ WARNING ] YOU HAVE CHOSEN TO DISABLE THE APT_SRC_CHK FUNCTION!"
            echo "[ WARNING ] YOU WILL NO LONGER SEE THESE MESSAGES FOR THE CURRENT SESSION!"
            echo ""
            echo "[ INFO ] THE SCREEN WILL CLEAR AND THE MAIN PROGRAM WILL LAUNCH IN 15 SECONDS!"

            sleep 15

            clear

        fi

    }

    if [ "$apt_src_chk_skip" = "true" ]; then

        nulkey=""

    else

        apt_src_chk

    fi

    file_src_chk

}

localvar () {

    # Config Parser
    . "/usr/bin/asadt/lib/bin/bash-ini-parser"

    # ANSI Color Codes
    . "/usr/bin/asadt/lib/bin/ansi"

    # Zenity Display Prompts [GUI]
    . "/usr/bin/asadt/lib/bin/zenity"
    . "/usr/bin/asadt/lib/visual_prog/displayboxhandler.service"

    # Code As VAR
    errormsg="ansi --bold --red-intense"
    infomsg="ansi --bold --blue-intense"
    warningmsg="ansi --bold --yellow-intense"
    successmsg="ansi --bold --green-intense"

    # Get Main Config
    cfg_parser "/usr/bin/asadt/lib/mainprog/ini/main.ini"
    cfg_parser "/usr/bin/asadt/lib/mainprog/ini/modules.ini"
    cfg_parser "/usr/bin/asadt/lib/mainprog/ini/global.ini"
    cfg_parser "/usr/bin/asadt/lib/mainprog/ini/dependencies.ini"
    cfg_section_versioninfo
    cfg_section_maincfg
    cfg_section_globalsettings
    cfg_section_modinfo
    cfg_section_dependencies_required
    cfg_section_dependencies_extra

    # Get Main Program Function Dictionary
    . "/usr/bin/asadt/lib/mainprog/mainprog.func"

    # Get Toolkit Modules
    . "/usr/bin/asadt/lib/mainprog/modules/brutetool.module"
    . "/usr/bin/asadt/lib/mainprog/modules/exemkr.module"
    . "/usr/bin/asadt/lib/mainprog/modules/scantool.module"
    . "/usr/bin/asadt/lib/mainprog/modules/sysutil.module"

    # Legal Disclaimer
    if [ -z "$legalagree" ]; then

        displayboxhandler legal

    fi

}

mainout () {

    if [ -z "$default_output_location" ]; then

        if [ -z "$output_main" ]; then

            displayboxhandler missingdir
            
            echo ""
            $warningmsg "[ WARNING ] Output Directory Was Not Defined!"
            echo ""
            $warningmsg -n "Please Enter A Output Directory To Continue: "

            read output_main

            if [ -z "$output_main" ]; then

                echo ""
                $errormsg "[ ERROR ] No Input Detected!"

                exit

            fi

        fi

        if [ -d "$output_main" ]; then

            echo ""
            $infomsg "[ INFO ] Set Output Directory!"
            cd "$output_main"

        else

            echo ""
            $warningmsg "[ WARNING ] '$output_main' Doesn't Exist..."
            $infomsg -n "[ INFO ] Press [ENTER] to Create the Directory or "'"CTRL+C"'" to cancel"

            read nulkey

            mkdir -p "$output_main"

            cd "$output_main"

        fi

    else

        output_main="$default_output_location"

        echo ""
        $infomsg "[ INFO ] Using Default Output Directory @ $output_main"

        if [ -d "$output_main" ]; then

            cd "$output_main"

        else

            mkdir -p "$output_main"

            cd "$output_main"

        fi

    fi

}

readarg () {

    if [ "$arg1" = "--quickarg" ]; then

        mainmenu_full

        exit

    elif [ "$arg1" = "-v" ]; then

        dispversion

        exit

    elif [ "$arg1" = "-h" ]; then

        disphelp

        exit

    elif [ "$arg1" = "-hh" ]; then

        disphelp_full

        exit

    elif [ "$arg1" = "--getdep" ]; then

        getdep

        exit

    elif [[ "$arg1" = "--cnfedit" && -z "$arg2" ]]; then

        cnfedit toolcfg

        exit

    elif [[ "$arg1" = "--cnfedit" && "$arg2" = "global" ]]; then

        cnfedit globalcfg

        exit

    elif [[ "$arg1" = "--cnfedit" && ! -z "$arg2" ]]; then

        cfgfn="$arg2"

        cnfedit arbit

        exit

    elif [ "$arg1" = "--update" ]; then

        update

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "nmap" ]]; then

        displayboxhandler nmap
        mainout
        modhandler_scantool nmap

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "assetfinder" ]]; then

        displayboxhandler assetfinder
        mainout
        modhandler_scantool assetfinder

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "dmitry" ]]; then

        displayboxhandler dmitry
        mainout
        modhandler_scantool dmitry

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "dnsmap" ]]; then

        displayboxhandler dnsmap
        mainout
        modhandler_scantool dnsmap

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "nikto" ]]; then

        displayboxhandler nikto
        mainout
        modhandler_scantool nikto

        exit

    elif [[ "$arg1" = "--scantool" && "$arg2" = "wpscan" ]]; then

        displayboxhandler wpscan
        mainout
        modhandler_scantool wpscan

        exit

    elif [ "$arg1" = "--exemkr" ]; then

        displayboxhandler msfpc
        mainout
        modhandler_exemkr msfpc

        exit

    elif [[ "$arg1" = "--brutetool" && "$arg2" = "sqlmap" ]]; then

        displayboxhandler sqlmap
        mainout
        modhandler_brutetool sqlmap

        exit

    elif [[ "$arg1" = "--brutetool" && "$arg2" = "thcssldos" ]]; then

        displayboxhandler thcssldos
        mainout
        modhandler_brutetool thcssldos

        exit

    elif [[ "$arg1" = "--sysutil" && "$arg2" = "transfersh" ]]; then

        modhandler_sysutil transfersh

        exit

    else

        if [[ "$arg1" = "--scantool" && -z "$arg2" ]]; then

            echo ""
            $errormsg "[ ERROR ] Invalid Command Syntax!..."
            $infomsg "[ INFO ] Missing Variable '--scantool' {tool_name}"
            $infomsg "[ INFO ] Need Help? Execute $0 -h"
            echo ""

            exit

        elif [[ "$arg1" = "--brutetool" && -z "$arg2" ]]; then

            echo ""
            $errormsg "[ ERROR ] Invalid Command Syntax!..."
            $infomsg "[ INFO ] Missing Variable '--brutetool' {tool_name}"
            $infomsg "[ INFO ] Need Help? Execute $0 -h"
            echo ""

            exit

        elif [[ "$arg1" = "--systutil" && -z "$arg2" ]]; then

            echo ""
            $errormsg "[ ERROR ] Invalid Command Syntax!..."
            $infomsg "[ INFO ] Missing Variable '--sysutil' {tool_name}"
            $infomsg "[ INFO ] Need Help? Execute $0 -h"
            echo ""

            exit

        else

            echo ""
            $errormsg "[ ERROR ] Uknown Command: $0 $arg1 $arg2"
            $infomsg "[ INFO ] Looks Like You Might Need Help..."
            $warningmsg "[ WARNING ] Executing QuickArg Menu!"
            echo ""

            mainmenu_full

        fi

    fi

} 

mainprog () {

    checkuid
    tmphandle
    integritychk
    localvar
    readarg

}

mainprog
exit 999


# MainProg Function Details

# checkuid     | This Function Checks To Ensure The Current User ID (UID) Reflects 0 (root acct. required for some tools)
# tmphandle    | Detects For Existing Temporary Directory, And Creates One If Necessary.
# integritychk | Checks For Missing Files & Program Dependencies Before Setting Local Variables. (can be skipped)
# localvar     | Loads Local Script Variables & Program Extentions Into Memory For Use.
# readarg      | Reads & Parses Inputted Script Arguments For Use & Executes Local Functions.
# mainout      | Sets Local Output Directory For Executed Tools.
# --------------------------------------------------------
# $errormsg    | Colored Error Message (red intense)
# $warningmsg  | Colored Warning Message (yellow intense)
# $infomsg     | Colored Info Message (blue intense)
# $successmsg  | Colored Success Message (green intense)

# MainProg Function Dictionaries

# mainprog             | @ build/lib/mainprog/mainprog.func
# displayboxhandler    | @ build/lib/visual_prog/displayboxhandler.service
# modhandler_scantool  | @ build/lib/mainprog/modules/scantool.module
# modhandler_brutetool | @ build/lib/mainprog/modules/brutetool.module
# modhandler_exemkr    | @ build/lib/mainprog/modules/exemkr.module