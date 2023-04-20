#!/bin/bash

# Assistive Search And Discovery Bash Prog-FW Build Script
# Script Version 5.0.3

# GNU-GPL-v3
# Please Read 'LICENSE' to view this program's license!

bin="$PWD/build"
binlock="$PWD"
quickinstall="false"

workspace="/tmp/asadt"
localworkspace="/usr/bin/asadt"

buildscript () {

    checkuid () {

        if [ "$UID" -eq "0" ]; then

            if [ "$SUDO_USER" = "root" ]; then

                echo ""
                echo "[ WARNING ] SUDO_USER = "'"root"'""
                echo ""

                sleep 3

            fi

            su_uid="true"
            idsave="$SUDO_USER"

        else

            echo ""
            echo "[ ERROR ] $0 Requires Sudo Privledges!"
            echo "[ INFO ] Try executing: sudo $0"
            echo ""

            exit

        fi

    }

    integritychk () {

        wgetcapture () {

            cd "$workspace"

            if [ "$(which wget)" = "/usr/bin/wget" ]; then 

                echo "[ WGET ] https://github.com/odf-community/ASADT/raw/main/github/build.mini.zip"
                echo "[ WGET ] https://raw.githubusercontent.com/odf-community/ASADT/main/build.ini"
                echo ""
                echo ""

                wget -P "/tmp/asadt/" "https://raw.githubusercontent.com/odf-community/ASADT/main/build.ini"
                wget -P "/tmp/asadt/" "https://github.com/odf-community/ASADT/raw/main/github/build.mini.zip"

            else

                echo "[ WGET ] WARNING! WGET BINARY PACKAGE MIGHT BE MISSING!"
                echo "[ WGET ] ATTEMPTING CAPTURE ANYWAYS!"
                echo ""
                echo "[ WGET ] https://github.com/odf-community/ASADT/raw/main/github/build.mini.zip"
                echo "[ WGET ] https://raw.githubusercontent.com/odf-community/ASADT/main/build.ini"
                echo ""
                echo ""

                wget -P "/tmp/asadt/" "https://raw.githubusercontent.com/odf-community/ASADT/main/build.ini"
                wget -P "/tmp/asadt/" "https://github.com/odf-community/ASADT/raw/main/github/build.mini.zip"

            fi

            if [ -f "$workspace/build.mini.zip" ]; then

                echo ""
                echo ""
                echo "[ wgetcapture.func ] file "'"build.mini.zip"'" exists!"
                echo "[ wgetcapture.func ] Attempting To Unpack Build Files Using "'"UnZip"'""
                echo ""

                if [ "$(which unzip)" = "/usr/bin/unzip" ]; then

                    echo ""
                    unzip build.mini.zip -d $workspace
                    echo ""

                else

                    echo "[ UNZIP ] WARNING! THE UNZIP BINARY PACKAGE MIGHT BE MISSING!"
                    echo "[ UNZIP ] ATTEMPTING UNZIP ANYWAYS!"

                    echo ""
                    unzip build.mini.zip -d $workspace
                    echo ""

                fi

                if [ -d "$workspace/build" ]; then

                    echo "[ UNZIP ] UNZIP SUCESSFULL!"

                else

                    echo "[ UNZIP ] UNZIP FAILED!"
                    echo "[ UNZIP ] PLEASE INSTALL UNZIP!"

                    exit

                fi
                
                echo "[ wgetcapture.func ] Resetting Variable "'"bin"'""

                bin="$workspace/build"

                echo ""
                echo "[ wgetcapture.func ] DONE!"

                sleep 10 && clear

            else

                echo ""
                echo "[ wgetcapture.func ] FILE ERROR! Missing Build Files....!"
                echo "[ wgetcapture.func ] PLEASE MANUALLY INSTALL THIS PROGRAM!"
                echo ""

                exit

            fi

        }

        if [ ! -d "$workspace" ]; then

            mkdir -p "$workspace"

        else

            rm -r "$workspace"

            mkdir -p "$workspace"

        fi

        if [ ! -d "$bin" ]; then

            echo "[ integritychk.func ] Missing Directory: $bin"
            echo "[ integritychk.func ] Missing Build Manifest"
            echo "[ integritychk.func ] Assuming "'"quickinstall=true"'""
            echo ""

            quickinstall=true

            wgetcapture

        fi

    }

    localvar () {

        updatefile="$localworkspace/lib/mainprog/ini/main.ini"
        binip="$bin/lib/bin/bash-ini-parser"

        if [ -f "$binip" ]; then

            . "$binip"

            echo ""
            echo "[ UPDATE ] Checking For Local Updates..."

            cfg_parser "build.ini"
            cfg_section_buildinfo

            if [ -f "$updatefile" ]; then

                noinst="false"
                update="false"

                cfg_parser "$updatefile"
                cfg_section_versioninfo
                
                if [ "$currentversion" = "$buildv" ]; then

                    echo "[ UPDATE ] Reported Status Code [NOUPDATE]"
                    echo "[ UPDATE ] Currently Installed Version Matches Package Version"
                    echo ""
                    echo "[ HELP ] Want A Fresh Install? Execute: sudo rm -r $localworkspace"
                    echo "[ HELP ] Then Launch The Build Script Again"
                    echo ""

                    exit

                else

                    echo "[ UPDATE ] Reported Status Code [UPDATEACTUAL]"
                    echo "[ UPDATE ] A Update Has Been Discovered And Will Be Applied With This Script"

                    update="true"

                fi


            else

                echo "[ UPDATE ] Reported Status Code [NOINST]"
                echo "[ UPDATE ] Program Has Not Been Previously Installed!"
                echo ""

                noinst="true"

            fi

        else

            echo "[ ERROR ] Failed To Load Program Extention '$binip'"

            exit

        fi

    }

    buildmsg () {

        echo ""
        echo ""
        echo "Welcome $idsave!"
        echo ""
        echo "Package Information"
        echo "------------------------"
        echo "Build Script Version: $builder_version"
        echo "ASADT Package Version: $buildv"
        echo "ASADT Release Version: $buildv_long"

        if [ "$noinst" = "false" ]; then

            echo ""
            echo "Currently Installed Version"
            echo "--------------------------------"
            echo "Installed Version: $currentversion"
            echo "Installed Release Version: $currentreleaseversion"
            echo ""

        else

            echo ""

        fi

        if [ "$update" = "true" ]; then

            echo "Would You Like To Update ASADT?"
            echo "This Will Update Your Currently Installed Version ($currentversion)!"
            echo ""
            echo -n "Update $currentversion-->$buildv? [Y/N] "

            read -r buildaskyn

            echo ""

        else

            echo "Would You Like To Install ASADT?"
            echo "This Will Install ASADT @ $install_location!"
            echo ""
            echo -n "Install? [Y/N] "

            read -r buildaskyn

            echo ""

        fi

    }

    buildtask () {

        buildprocess () {

            if [ -d "$localworkspace" ]; then

                rm -r "$localworkspace"

                mkdir -p "$localworkspace"

            else

                mkdir -p "$localworkspace"

            fi

            echo "[ buildprocess.func ] TASK1 --> DONE!"

            cd "$bin"

            echo "[ buildprocess.func ] TASK2 --> DONE!"

            cp -r lib config asadt.sh "$install_location"

            echo "[ buildprocess.func ] TASK3 --> DONE!"

            chmod +x "$install_location"/asadt.sh

            echo "[ buildprocess.func ] TASK4 --> DONE!"

        }

        checkinput () {

            inputid="$buildaskyn"

            if [ "$inputid" = "y" ]; then

                buildprocess

            elif [ "$inputid" = "Y" ]; then

                buildprocess

            elif [ "$inputid" = "n" ]; then

                echo "Operation Canceled At Users Request!"
                echo ""

                exit

            elif [ "$inputid" = "N" ]; then

                echo "Operation Canceled At Users Request!"
                echo ""

                exit

            else

                echo "Press Enter To Confirm Yes!"
                echo "Press [CTRL]+[C] To Exit!"

                read nulkey

                buildprocess

            fi

        }

        checkinput $buildaskyn

    }

    configrewind () {

        configrewindcontrolid="$1"

        cfg_save () {

            if [ "$noinst" = "false" ]; then

                if [ -d "$localworkspace/config" ]; then

                    if [ -f "$localworkspace/lib/mainprog/ini/modules.ini" ]; then

                        if [ "$currentversion" = "v1.1.2" ]; then

                            statuscode_configrewind="USERUPDATE112"
                        
                        else

                            cp -r "$localworkspace"/config "$workspace"
                            mv "$localworkspace/lib/mainprog/ini/modules.ini" "$workspace/current_modules.ini"

                        fi

                    else

                        statuscode_configrewind="NOMODINI"

                    fi

                else

                    statuscode_configrewind="NOCFGDIR"

                fi

            else

                statuscode_configrewind="NOINST"

            fi

        }

        cfg_rewind () {

            bringback () {

                rm -r "$localworkspace/config"

                cp -r "$workspace/config" "$localworkspace/config"

                if [ ! -d "$localworkspace/config/sysutil" ]; then

                    cp -r "$bin/config/sysutil" "$localworkspace/config/sysutil"

                fi

            }

            versionparse_current () {

                cfg_parser "$workspace/current_modules.ini"
                cfg_section_configrewind

                current_sqlmap="$sqlmap_ini_version"
                current_thcssldos="$thcssldos_ini_version"
                current_msfpc="$msfpc_ini_version"
                current_assetfinder="$assetfinder_ini_version"
                current_dmitry="$dmitry_ini_version"
                current_dnsmap="$dnsmap_ini_version"
                current_nikto="$nikto_ini_version"
                current_nmap="$nmap_ini_version"
                current_wpscan="$wpscan_ini_version"
                current_transfersh="$transfersh_ini_version"

            }

            versionparse_build () {

                cfg_parser "$bin/lib/mainprog/ini/modules.ini"
                cfg_section_configrewind
                cfg_section_modinfo

                build_sqlmap="$sqlmap_ini_version"
                build_thcssldos="$thcssldos_ini_version"
                build_msfpc="$msfpc_ini_version"
                build_assetfinder="$assetfinder_ini_version"
                build_dmitry="$dmitry_ini_version"
                build_dnsmap="$dnsmap_ini_version"
                build_nikto="$nikto_ini_version"
                build_nmap="$nmap_ini_version"
                build_wpscan="$wpscan_ini_version"
                build_transfersh="$transfersh_ini_version"

            }

            versionparse_vid () {

                if [ "$current_sqlmap" = "$build_sqlmap" ]; then

                    sqlmap_vid="currentversion"

                else

                    sqlmap_vid="needsupdate"

                fi

                if [ "$current_thcssldos" = "$build_thcssldos" ]; then

                    thcssldos_vid="currentversion"

                else

                    thcssldos_vid="needsupdate"

                fi

                if [ "$current_msfpc" = "$build_msfpc" ]; then

                    msfpc_vid="currentversion"

                else

                    msfpc_vid="needsupdate"

                fi

                if [ "$current_assetfinder" = "$build_assetfinder" ]; then

                    assetfinder_vid="currentversion"

                else

                    assetfinder_vid="needsupdate"

                fi

                if [ "$current_dmitry" = "$build_dmitry" ]; then

                    dmitry_vid="currentversion"

                else

                    dmitry_vid="needsupdate"

                fi

                if [ "$current_dnsmap" = "$build_dnsmap" ]; then

                    dnsmap_vid="currentversion"

                else

                    dnsmap_vid="needsupdate"

                fi

                if [ "$current_nikto" = "$build_nikto" ]; then

                    nikto_vid="currentversion"

                else

                    nikto_vid="needsupdate"

                fi

                if [ "$current_nmap" = "$build_nmap" ]; then

                    nmap_vid="currentversion"

                else

                    nmap_vid="needsupdate"

                fi

                if [ "$current_wpscan" = "$build_wpscan" ]; then

                    wpscan_vid="currentversion"

                else

                    wpscan_vid="needsupdate"

                fi

                if [ "$current_transfersh" = "$build_transfersh" ]; then

                    transfersh_vid="currentversion"

                else

                    transfersh_vid="needsupdate"

                fi

            }

            update_prev () {

                echo ""
                echo "Configuration File Updates!"
                echo "The Following Configuration Files Will Be Reset To Their"
                echo "Defaults To Accommodate For Feature & Option Changes."
                echo "To Protect From Bugs & Errors, Please Allow The Following Function"
                echo "To Complete Entirely."
                echo ""
                echo "SQLMAP: $sqlmap_vid"
                echo "THCSSLDOS: $thcssldos_vid"
                echo "MSFPC: $msfpc_vid"
                echo "ASSETFINDER: $assetfinder_vid"
                echo "DMITRY: $dmitry_vid"
                echo "DNSMAP: $dnsmap_vid"
                echo "NIKTO: $nikto_vid"
                echo "NMAP: $nmap_vid"
                echo "WPSCAN: $wpscan_vid"
                echo "TRANSFERSH: $transfersh_vid"
                echo ""
                echo ""'"needsupdate"'" Means That The File Will Be Updated"
                echo ""'"currentversion"'" Means That The File Is Currently Source Version"
                echo ""

                sleep 10

            }

            updatecfg () {

                if [ "$sqlmap_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/brutetool/sqlmap.ini

                    cp $bin/config/brutetool/sqlmap.ini $localworkspace/config/brutetool

                elif [ "$thcssldos_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/brutetool/thcssldos.ini

                    cp $bin/config/brutetool/thcssldos.ini $localworkspace/config/brutetool

                elif [ "$msfpc_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/exemkr/msfpc.ini

                    cp $bin/config/exemkr/msfpc.ini rm $localworkspace/config/exemkr

                elif [ "$assetfinder_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/assetfinder.ini

                    cp $bin/config/scantool/assetfinder.ini $localworkspace/config/scantool

                elif [ "$dmitry_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/dmitry.ini 

                    cp $bin/config/scantool/dmitry.ini $localworkspace/config/scantool

                elif [ "$dnsmap_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/dnsmap.ini

                    cp $bin/config/scantool/dnsmap.ini $localworkspace/config/scantool

                elif [ "$nikto_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/nikto.ini

                    cp $bin/config/scantool/nikto.ini $localworkspace/config/scantool

                elif [ "$nmap_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/nmap.ini

                    cp $bin/config/scantool/nmap.ini $localworkspace/config/scantool

                elif [ "$wpscan_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/scantool/wpscan.ini

                    cp $bin/config/scantool/wpscan.ini $localworkspace/config/scantool

                elif [ "$transfersh_vid" = "needsupdate" ]; then

                    rm $localworkspace/config/sysutil/transfersh.ini

                    cp $bin/config/sysutil/transfersh.ini $localworkspace/config/sysutil

                else

                    echo ""
                    echo "No Configuration Updates Found!"

                fi

            }

            if [ "$statuscode_configrewind" = "USERUPDATE112" ]; then

                echo ""
                echo "[ configrewind.func ] Config Save Disabled! Status Code [USERUPDATE112]"
                echo "[ configrewind.func ] Config Rewind Disabled! Status Code [USERUPDATE112]"

            elif [ "$statuscode_configrewind" = "NOMODINI" ]; then

                echo ""
                echo "[ configrewind.func ] Config Save Disabled! Status Code [NOMODINI]"
                echo "[ configrewind.func ] Config Rewind Disabled! Status Code [NOMODINI]"

            elif [ "$statuscode_configrewind" = "NOCFGDIR" ]; then

                echo ""
                echo "[ configrewind.func ] Config Save Disabled! Status Code [NOCFGDIR]"
                echo "[ configrewind.func ] Config Rewind Disabled! Status Code [NOCFGDIR]"

            elif [ "$statuscode_configrewind" = "NOINST" ]; then

                echo ""
                echo "[ configrewind.func ] Config Save Disabled! Status Code [NOINST]"
                echo "[ configrewind.func ] Config Rewind Disabled! Status Code [NOINST]"

            else

                versionparse_current
                versionparse_build
                versionparse_vid
                update_prev
                bringback
                updatecfg

            fi

        }

        if [ "$configrewindcontrolid" = "save" ]; then

            cfg_save

        fi

        if [ "$configrewindcontrolid" = "rewind" ]; then

            cfg_rewind

        fi

    }

}

buildscript_control () {

    checkuid
    integritychk
    localvar
    buildmsg
    configrewind save
    buildtask
    configrewind rewind

    echo ""
    echo "BUILD COMPLETE!"
    echo ""
    echo "To Use This Script, Please Execute:"
    echo "sudo /usr/bin/asadt/asadt.sh --quickarg"
    echo ""

}

buildscript
buildscript_control

exit 999