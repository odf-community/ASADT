#!/bin/bash

# Assistive Search And Discovery Tool Mark II v109 Builder Application
# Licensed Under GNU GENERAL PUBLIC LICENSE
# Script Developed & Maintained By The
# Onetrak Digital Forensics Corporation

buildvar () {

    clear

    builder_version="4.0.0"
    buildv="v1.0.9"
    buildv_long="MARK II BETA | v. 1.0.9"
    bin="$PWD/build"

}

checkroot () {

    if [ "$UID" = "0" ]; then

        echo "proginit> usracct=$SUDO_USER"

    else

        echo "proginit> Please Execute "'"sudo ./builder.sh"'" "

        exit

    fi

}

checkurf () {

    if [ -f "/root/.asadt" ]; then

        source "/root/.asadt"

        build_update

    else

        build_main

    fi

}

build_main () {

    build_main_installprompt () {

        echo "Assistive Search And Discovery Tool"
        echo "Current Build Version: $buildv_long"
        echo "Builder Script Version: $builder_version"
        echo ""
        echo -n "Enter Install Directory: "

        read custominstloc

        if [ -z "$custominstloc" ]; then

            echo ""
            echo "NO INPUT PROVIDED"

            exit

        fi

        if [ -d "$custominstloc" ]; then

            echo ""
            echo "OK"

        else

            echo ""
            echo "Looks Like $custominstloc Doesn't Exist..."
            echo -n "Would You Like To Make This Directory? [Y/n] "

            read mkdiryn

            if [ -z "$mkdiryn" ]; then

                echo ""
                echo "Making Directory"
                
                mkdir -p "$custominstloc"

            elif [ "$mkdiryn" = "y" ]; then

                echo ""
                echo "Making Directory"
                
                mkdir -p "$custominstloc"

            else

                echo ""
                echo "Cancelling Operation!..."

                exit

            fi

        fi

    }

    build_main_buildprocess () {

        if [ -d "$bin" ]; then

            cd "$bin"

            cp -r config mainprog modules asadt.sh "$custominstloc"

            cd "$custominstloc"

            sudo chmod +x asadt.sh

            echo "appversion='$buildv'" > /root/.asadt
            echo "appversion_long='$buildv_long'" >> /root/.asadt
            echo "approot='$custominstloc'" >> /root/.asadt
            echo "progroot='$custominstloc/mainprog'" >> /root/.asadt
            echo "cnfroot='$custominstloc/config'" >> /root/.asadt
            echo "modroot='$custominstloc/modules'" >> /root/.asadt

            echo ""
            echo "INSTALL COMPLETE!"
            echo "Check For Install Errors Above Prior To Closing This Terminal"
            echo "To Launch The Script, Please Execute 'sudo $approot/./asadt.sh'"

            exit

        else

            echo "BUILD ERROR: CANNOT FIND '/$bin/" in "'"$PWD"'"
            echo "Please Ensure The working directory houses ASADT's build data!"

            exit

        fi

    }

    build_main_installprompt
    build_main_buildprocess

    exit

}

build_update () {

    build_update_installprompt () {

        echo "Looks Like ASADT Has Already Been Installed On This System!"
        echo "Would You Like To Update From $appversion -> $buildv Using This Script?"
        echo ""
        echo -n "Update to $buildv? [Y/n] "

        read updateaskyn

        if [ -z "$updateaskyn" ]; then

            build_update_buildprocess

        
        elif [ "$updateaskyn" = "y" ]; then

            build_update_buildprocess

        else

            echo ""
            echo "Cancelling Operation!..."

            exit

        fi

    }

    build_update_buildprocess () {

        if [ -d "$bin" ]; then

            cd "$bin"

            sudo rm -r "$approot"
            sudo rm "/root/.asadt"

            sudo mkdir -p "$approot"

            cp -r config mainprog modules asadt.sh "$approot"

            cd "$approot"

            sudo chmod +x asadt.sh

            echo "appversion='$buildv'" > /root/.asadt
            echo "appversion_long='$buildv_long'" >> /root/.asadt
            echo "approot='$approot'" >> /root/.asadt
            echo "progroot='$approot/mainprog'" >> /root/.asadt
            echo "cnfroot='$approot/config'" >> /root/.asadt
            echo "modroot='$approot/modules'" >> /root/.asadt

            echo ""
            echo "UPDATE COMPLETE!"
            echo "Check For Update Errors Above Prior To Closing This Terminal"
            echo "To Launch The Script, Please Execute 'sudo $approot/./asadt.sh'"

            exit

        else

            echo "BUILD ERROR: CANNOT FIND '/$bin/" in "'"$PWD"'"
            echo "Please Ensure The working directory houses ASADT's build data!"

            exit

        fi

    }

    build_update_installprompt
    build_update_buildprocess

    exit

}

## MAIN BUILD STACK

buildvar # Adds build variables into memory
checkroot # Checks for root privledges
checkurf # Checks for existing user registry file for update
