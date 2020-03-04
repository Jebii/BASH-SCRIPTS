#!/bin/bash

#Script to Create backup files and move current backup files.


#Enforce running script as root/sudo
if [ `id -u` -ne 0 ]; then
    echo "You need to run this as root/sudo"
    exit 1
fi

time_now=$(date "+%Y.%m.%d")

echo "Choose Backup Option.."

read -rp 'a : Create Backup File , b : Move Current Backup files , c : remove files with [~] , d : remove files with [.phpe] => ' option

printf "\n"
printf "%sOption: \033[1m $option \033[0m "

while :
do
  case $option in
        a)
                echo "Creating New Backup file..."
                read -rp 'Enter Backup Directory Name (Application/Service name) :' dirname
                read -rp 'Enter File to Backup : ' filename
                printf "%sYou have entered the file - \033[1m $filename \033[0m for this service - \033[1m $dirname \033[0m \n"
                read -rp "Confirm [Y/N]:" answer
                        case "$answer" in
                        [yY])
                                printf "\n"
                                printf "Creating new backup file ... \n "
                                backup_file=$time_now-$filename
                                cp $filename $backup_file
                                mkdir location/$dirname   #add laction to backup 
                                cp $backup_file location/$dirname
                                echo "DONE.  Backup Directory and File is now created."
                                ;;
                        *)
                                exit 0
                                ;;
                        esac
                break
                ;;
        b)
                echo "Moving current backup files..."
                read -rp 'Enter Backup Directory Name (Application/Service name) : ' dirname
                echo "List of files..."
                ls | grep -i 20 		#files with the date years from 2000
                printf "\n"
                read -rp "Confirm [Y/N]:" answer
                        case "$answer" in
                        [yY])
                                printf "\n"
                                printf "Creating backup folder ... \n"
                                mkdir location/$dirname
                                printf "Moving files to backup folder ... \n"
                                files=$(ls | grep -i 20)
                                mv $files location/$dirname
                                printf "\n"
                                echo "DONE. Files moved to Backup Directory."
                                ;;
                        *)
                                exit 0
                                ;;
                        esac
                break
                ;;
        c)
                echo "Remove files with [~] in directory..."
                echo "List of files..."
                ls | grep "~"
                printf "\n"
                read -rp "Confirm [Y/N]:" answer
                        case "$answer" in
                        [yY])
                                printf "\n"
                                printf "Removing files ... \n"
                                rmfiles=$(ls | grep "~")
                                rm $rmfiles
                                printf "\n"
                                echo "DONE. Files with [~] removed from Directory."
                                ;;
                        *)
                                exit 0
                                ;;
                        esac
                break
                ;;
        d)
                echo "Remove files with [.phpe] in directory..."
                echo "List of files..."
                ls | grep ".phpe"
                printf "\n"
                read -rp "Confirm [Y/N]:" answer
                        case "$answer" in
                        [yY])
                                printf "\n"
                                printf "Removing files ... \n"
                                rmfiles=$(ls | grep ".phpe")
                                rm $rmfiles
                                printf "\n"
                                echo "DONE. Files with [.phpe] removed from Directory."
                                ;;
                        *)
                                exit 0
                                ;;
                        esac
                break
                ;;
        *)
                echo "Wrong Choice, Please choose required options."
                exit 0
                ;;
  esac
done
