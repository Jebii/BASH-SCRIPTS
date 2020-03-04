#!/bin/bash

#Script to change Passwords on multilple files. 

files=$(pwd)/*

validate(){

	if ! (grep -qF "$crntpassword" $files); 
	then
		echo "Password Does NOT exist. Please Confirm Password." >&2;
		exit 0
	fi
}

read -rp 'Enter Current Password : ' crntpassword
printf "\n"

if [[ -n "$crntpassword" ]]; then
	validate
	echo "Current Password in files..."
	grep -F "$crntpassword" $files

	printf "\n"
	read -rp 'Enter New Password : ' newpassword
	printf "%sYou have entered new password : \033[1m $newpassword \033[0m \n"

	read  -r -p "Confirm New Password [Y/N] : " answer
		case "$answer" in
			[yY])
		 		printf "\n"
				printf "Replacing Current Password with New Password on files... \n" 

				sed -i 's@$crntpassword@$newpassword@g' $files

				grep -F "$newpassword" $files
				;;
			*)
				exit 0
				;;
		esac	

fi
