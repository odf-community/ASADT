#!/bin/bash

# Assistive Search And Discovery Tool MARK II BETA
# Script Version 1.0.7-2

# This Script Is Developed & Maintained By The
# Onetrak Digital Forensics Corportaion

# PROGVAR
cmdvar1="$1"
cmdvar2="$2"
userreg="/root/.asadt"

# INTPROG FUNCTIONS
function userstatus {

    if [ "$UID" = "0" ]; then

        current_su="true"

    else

        echo "$0 Requires Sudo Privledges"
        exit

    fi

}

function getuserreg {

    if [ -f "$userreg" ]; then

        source $userreg

        #MAIN PROGRAM DATA LIB
        source $progroot/func/configeditor.func
        source $progroot/func/disphelp.func
        source $progroot/func/dispversion.func
        source $progroot/func/update.func
        source $progroot/ui/legalwarn.ui
        source $cnfroot/scantool.config
        source $cnfroot/brutetool.config
        source $cnfroot/exemkr.config

        # LEGALITY NOTICE
        warndiag_legal

        # SCANTOOL LIB
        mod_scantool

        # BRUTETOOL LIB
        mod_brutetool

        # EXEMKR LIB
        mod_exemkr

    else

        echo "FATAL PROGRAM ERROR!"
        echo ""
        echo "MISSING USER REGISTRY FILE @ /root/.asadt"
        echo "ENSURE YOU HAVE PROPERLY INSTALLED THE PROGRAM!"

    fi

}

function mainout {

    if [ -d "$output_main" ]; then

        echo "OK"
        cd "$output_main"

    else

        echo "Looks like '$output_main' Doesn't Exist..."
        echo -n "Press [ENTER] to create the directory or "'"CTRL+C"'" to cancel"
        read nulkey
        mkdir -p "$output_main"
        cd "$output_main"

    fi


}

function passvar_cmd {

    if [ "$cmdvar1" = "-v" ]; then

        dispversion

        exit

    fi

    if [ "$cmdvar1" = "-h" ]; then

        disphelp

        exit

    fi

    if [ "$cmdvar1" = "-hh" ]; then

        disphelp_full

        exit

    fi

    if [ "$cmdvar1" = "-cnfedit" ]; then

        configeditor
        configeditor_checkfn
        configeditor_nanosetup

        exit

    fi

    if [ "$cmdvar1" = "--updatecheck" ]; then

        chkupdate

        exit

    fi

    if [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "assetfinder" ]]; then

        wizgui_assetfinder
        mainout
        scantool_assetfinder

        exit

    fi

    if [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "dmitry" ]]; then

        wizgui_dmitry
        mainout
        scantool_dmitry

        exit

    fi

    if [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "dnsmap" ]]; then

        wizgui_dnsmap
        mainout
        scantool_dnsmap

        exit

    fi

    if [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "nikto" ]]; then

        wizgui_nikto
        mainout
        scantool_niktoscan

        exit

    fi

    if [[ "$cmdvar1" = "--scantool" && "$cmdvar2" = "nmap" ]]; then

        wizgui_nmap
        mainout
        scantool_nmap

        exit

    fi

    if [[ "$cmdvar1" = "--brutetool" && "$cmdvar2" = "sqlmap" ]]; then

        sqlmap_checkskip
        wizgui_sqlmap
        mainout
        parsevar_sqlmap_py3
        prev_args
        sqlmap_exec

        exit

    fi

    if [[ "$cmdvar1" = "--brutetool" && "$cmdvar2" = "thcssldos" ]]; then

        wizgui_thcssldos
        brutetool_thcssldos
        
        exit

    fi

    if [ "$cmdvar1" = "--exemkr" ]; then

        wizgui_msfpc_custom
        mainout
        exemkr_msfpc

        exit

    fi


}

#MAINPROG STACK 1
mainprog () {

userstatus
getuserreg
passvar_cmd

}

mainprog

# SCANTOOL CLAUSE
if [[ "$cmdvar1" = "--scantool" && -z "$cmdvar2" ]]; then

    echo "Prog_Error: Missing argument "'"modulename"'" after '--scantool'"
    echo "Prog_HelpMsg: Need more help? Run $0 -h or -hh"
    exit

fi

# UKNOWN CLAUSE
echo "Prog_Error: Unknown Command... $0 $1 $2"
echo "Prog_HelpMsg: Need more help? Run $0 -h or -hh"
exit
