#!/bin/bash
# Assistive Search And Discovery Tool Mark II v107-2 Builder Application
# Licensed Under GNU GENERAL PUBLIC LICENSE
# Script Developed & Maintained By The
# Onetrak Digital Forensics Corporation


builder_version="3.1.0"
buildv="v1.0.8"
buildv_long="MARK II BETA | v 1.0.8"

function checkroot {

    if [ "$USER" = "root" ]; then

        echo "proginit> user=$SUDO_USER"

    else

        echo "proginit> please run "'"sudo ./builder.sh"'" "

        exit

    fi

}

function getrolling {

    if [ -f "/etc/os-release" ]; then

        source "/etc/os-release"

        if [ "$VERSION_CODENAME" = "kali-rolling" ]; then

            echo "os_v_codename> "'"kali-rolling"'" detected!"
            echo ""

        else

            echo "os_v_codename> "'"kali-rolling"'" was not detected in "'"/etc/os-release"'"!"
            echo ""
            echo "os_v_codename> It looks like kali-rolling wasnt detected!"
            echo "               If you currently are not running Kali-OS, please"
            echo "               ensure all of the necessary apt-sources are installed"
            echo "               either via kali's .deb repo or via the open internet."
            echo ""
            echo "dispmsg> This message will dissmiss in 30 seconds!"
            echo ""

            sleep 30

        fi

    fi

}

function buildscript {

    echo ""
    echo "ASADT Release-$buildv Build Script"
    echo "Version to be Built: [$buildv_long]"
    echo "Builder Script Version: [$builder_version]"
    echo ""
    echo ""

    echo "[NO SPACES OR SPECIAL CHARS.]"
    echo -n "Enter Install Location: "
    read custominstloc

    if [ -z "$custominstloc" ]; then

        echo "No Input Provided!"

        exit 3

    fi

    if [ -d "$custominstloc" ]; then

        echo "OK"

    else

        echo "Looks like this directory doesnt exist!"
        echo -n "Would you like to create it? [y/n] "
        read mkdiryn

        if [ "$mkdiryn" = "y" ]; then

            sudo mkdir -p "$custominstloc"

        else

            echo "Function Canceled!"

            exit 3

        fi

    fi

    if [ -d "$PWD/build" ]; then

        cd build

        sudo cp -r config mainprog modules asadt.sh "$custominstloc"

        cd $custominstloc

        sudo chmod +x asadt.sh

        echo "usrreg> GENERATING ROOT KEY!"

        if [ -f "/root/.asadt" ]; then

            rm /root/.asadt

            sleep 2

        fi

        echo "appversion='$buildv'" > /root/.asadt
        echo "appversion_long='$buildv_long'" >> /root/.asadt
        echo "approot='$custominstloc'" >> /root/.asadt
        echo "progroot='$custominstloc/mainprog'" >> /root/.asadt
        echo "cnfroot='$custominstloc/config'" >> /root/.asadt
        echo "modroot='$custominstloc/modules'" >> /root/.asadt

    else

        echo "BUILD ERROR: CANNOT FIND '/build/" in "'"$PWD"'"
        echo "Please ensure The working directory houses ASADT's build data!"

        exit 2

    fi

}

function checkapt {

    echo ""
    echo "checkapt> using 'which' to detect apt sources."
    echo "          if any sources respond "'"Not Found"'","
    echo "          then run: apt-get install "'"missing-pkg"'" -y"
    echo ""

    which which
    which zenity
    which git
    which cat
    which sudo
    wchich nano
    which nmap
    which nikto
    which dnsmap
    which dmitry
    which assetfinder
    which msfpc
    which sqlmap
    which thc-ssl-dos
    echo ""

}

function updateoriginshell {

    if [ -f "/root/.asadt" ]; then

        echo "It seems that ASADT is already installed on this system"
        echo -n "Would you like to update? [y/n] "
        read originupdateq

        if [ -z "$originupdateq" ]; then

            echo "No Input Provided, Dropping Build"

            exit 3

        fi


        if [ "$originupdateq" = "y" ]; then

            echo ""

            if [ -d "$PWD/build" ]; then

                source /root/.asadt

                echo "Updating ASADT '$appversion' --> '$buildv'"
                echo "Do not close this terminal during update."

                sudo rm /root/.asadt

                sudo rm -r "$approot"

                mkdir "$approot"

                cd build

                sudo cp -r config mainprog modules asadt.sh "$approot"

                cd "$approot"

                sudo chmod +x asadt.sh

                echo "appversion='$buildv'" > /root/.asadt
                echo "appversion_long='$buildv_long'" >> /root/.asadt
                echo "approot='$approot'" >> /root/.asadt
                echo "progroot='$approot/mainprog'" >> /root/.asadt
                echo "cnfroot='$approot/config'" >> /root/.asadt
                echo "modroot='$approot/modules'" >> /root/.asadt

                echo "UPDATE COMPLETE!"
                echo "CHECK FOR SCRIPT ERRORS BEFORE CLOSING THIS TERMINAL PROMT"

                exit 1

            else

                echo "BUILD ERROR: CANNOT FIND '/build/" in "'"$PWD"'"
                echo "Please ensure The working directory houses ASADT's build data!"

                exit 2

            fi

        else

            echo "UPDATE CANCELED"
            echo "TO FRESH INSTALL ASADT PLEASE REMOVE THE FILE LOCATED @ '/root/.asadt'"

            exit 3

        fi

    else

        echo "NO UPDATE REQUIRED!"
        echo "NO EXISTING USERREG FILE FOUND!"

    fi

}

builder () {

    checkroot
    getrolling
    updateoriginshell
    buildscript
    checkapt

    echo "Install Complete! To execute ASADT's shell, execute:"
    echo "'sudo $custominstloc/asadt.sh -h' for more help info!"

    exit 1

}

builder
