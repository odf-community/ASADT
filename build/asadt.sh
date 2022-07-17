#!/bin/bash

# Assistive Search And Discovery Tool MARK II BETA
# Script Version 1.0.9

# This Script Is Developed & Maintained By The
# Onetrak Digital Forensics Corportaion

cmdvar1="$1"
cmdvar2="$2"

mainprog () {

    checkuid () {

        if [ "$UID" = "0" ]; then

            superuser="true"

        else

            echo "$0 Requires Sudo Privledges"

            exit

        fi

    }

    source_urf () {

        urf="/root/.asadt"

        if [ -f "$urf" ]; then

            source $urf
            source $progroot/config/mainprog.config

            mainprog_cnf

        else

            $errormessage "[ FATAL ERROR ]"
            $errormessage "User Registry File Does Not Exist!"
            $errormessage "Please Re-Install ASADT MKII BETA!"
            $errormessage "https://github.com/odf-community/ASADT"

            exit

        fi

    }

    legal_warning () {

        if [ "$legalagree" = "true" ]; then

            legalagree='true'

        else

            warndiag_legal

        fi

    }

    modulemount () {

        mod_scantool
        mod_brutetool
        mod_exemkr

        # ANSI MESSAGE COLOR CODES
        errormessage="ansi --bold --red-intense"
        infomessage="ansi --bold --blue"
        warningmessage="ansi --bold --yellow"

    }

    parse_cmd () {

        if [ "$cmdvar1" = "-v" ]; then

            dispversion

            exit

        elif [ "$cmdvar1" = "-h" ]; then

            disphelp

            exit

        elif [ "$cmdvar1" = "-hh" ]; then

            disphelp_full

            exit

        elif [ "$cmdvar1" = "-cnfedit" ]; then

            configeditor
            configeditor_verifyfn
            configeditor_launchnano

            exit

        elif [ "$cmdvar1" = "--updatecheck" ]; then

            chkupdate

            exit

        elif [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "assetfinder" ]]; then

            wizgui_assetfinder
            mainout
            scantool_assetfinder

            exit

        elif [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "dmitry" ]]; then

            wizgui_dmitry
            mainout
            scantool_dmitry

            exit

        elif [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "dnsmap" ]]; then

            wizgui_dnsmap
            mainout
            scantool_dnsmap

            exit

        elif [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "nikto" ]]; then

            wizgui_nikto
            mainout
            scantool_niktoscan

            exit

        elif [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "nmap" ]]; then

            wizgui_nmap
            mainout
            scantool_nmap

            exit

        elif [[ "$cmdvar1" = "--brutetool" && "$cmdvar2" = "sqlmap" ]]; then

            sqlmap_checkskip
            wizgui_sqlmap
            mainout
            parsevar_sqlmap_py3
            prev_args
            sqlmap_exec

            exit

        elif [[ "$cmdvar1" = "--brutetool" && "$cmdvar2" = "thcssldos" ]]; then

            wizgui_thcssldos
            brutetool_thcssldos
            
            exit

        elif [ "$cmdvar1" = "--exemkr" ]; then

            wizgui_msfpc_custom
            mainout
            exemkr_msfpc

            exit

        else

            exitclause

            exit

        fi

    }

    mainout () {

        if [ -d "$output_main" ]; then

            echo "OK"
            cd "$output_main"

        else

            $warningmessage "[ WARNING ] '$output_main' Doesn't Exist..."
            $infomessage -n "[ INFO ] Press [ENTER] to Create the Directory or "'"CTRL+C"'" to cancel"

            read nulkey
            
            mkdir -p "$output_main"

            cd "$output_main"

        fi

    }

    exitclause () {

        if [[ "$cmdvar1" = "--scantool" && -z "$cmdvar2" ]]; then

            $errormessage "[ ERROR ] Invalid Syntax... Missing Argument {tool_name}"
            $infomessage "[ INFO ] Need Help? Execute $0 -h"

            exit 999

        elif [[ "$cmdvar1" = "--brutetool" && -z "$cmdvar2" ]]; then
            
            $errormessage "[ ERROR ] Invalid Syntax... Missing Argument {tool_name}"
            $infomessage "[ INFO ] Need Help? Execute $0 -h"

            exit 999

        elif [ -z "$cmdvar1" ]; then

            $errormessage "[ ERROR ] Invalid Syntax... Missing Argument {module_name}"
            $infomessage "[ INFO ] Need Help? Execute $0 -h"

        else

            $errormessage "[ ERROR ] Invalid Command!... $0 $cmdvar1 $cmdvar2"
            $infomessage "[ INFO ] Need Help? Execute $0 -h"

            exit 999

        fi

    }
    
    checkuid # Checks For Root Permissions (Required For Some Tools)
    source_urf # Fetch The User Regitry File For Program Information
    legal_warning # Legal Disclaimer (1 Time Prompt Per Update)
    modulemount # Mount Program Modules (And ANSI 3rd Party Script)
    parse_cmd # Parse Inputted Command Arguments

}

mainprog # Main Program Stack
exit 999 # One Last Exit For Safety Reasons. Your Terminal Should Exit Before This.


