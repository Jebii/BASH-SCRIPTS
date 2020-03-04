#!/bin/bash

#Script to Run DB Queries


#Enforce running script as root/sudo
if [ `id -u` -ne 0 ]; then
    echo "You need to run this as root/sudo"
    exit 1
fi

#DB Credentials & Query
USER=""
PASSWRD=""
HOST=""
DB=""


regex='^[0-9]+$'


function_name(){

	printf "Running Query... \n"
	mysql -D$DB -p$PASSWRD -h$HOST -u$USER -e "insert query here" && 
	printf "\n"
	printf "Done.."
	printf "\n"
				
}


case "$1" in
                        function_name)
						function_name
                        ;;

*)
                        echo "Usage: [ sudo sh example_6.sh function_name ]"

esac
exit 0
