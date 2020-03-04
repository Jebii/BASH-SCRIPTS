#!/bin/bash

#script to check status in a file, enable or disable in a file

file_name=filelocation

#must run script as root
isRoot(){
        if [[ "$(id -u)" != "0" ]]; then
                echo "This script needs to be ran as sudo/root" 1>&2
                exit 1
        fi
}

case "$1" in
        status)
                if grep -w "DISABLED" $file_name; then
                        echo " is disabled"
                        exit 1
                else
                        echo " is Enabled"
                        exit 1
                fi
                ;;

        disable)
                if grep -w "ENABLED" $file_name; then
                        echo "Disabling..."
                        sed -i "s/ENBALED/DISABLED/g" $file_name   
                        echo "has been disabled!"
                        exit 1
                else
                        echo "is already disabled"
                        exit 1
                fi
                ;;

        enable)
                if grep -w "DISABLED" $file_name; then
                        echo "Enabling..."
                        sed -i "s/DISABLED/ENABLED/g" $file_name
                        echo "has been enabled!"
                        exit 1
                else
                        echo "Menu is already enabled"
                        exit 1
                fi
                ;;

                *)
                        echo "Usage: {
                            example_3.sh    enable | disable |status
                                        }"
                exit 1
                ;;
esac

exit 0
