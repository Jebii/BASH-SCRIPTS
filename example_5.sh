#!/bin/bash

#Script to enable or disable and check conditions set on a file

config=filelocation


disable(){
 
	if (grep -E "disable = true" $config ); 
	then
		printf "\033[1m  is Already Disabled. \033[0m \n"

	else
		echo "Disabling..."
		printf "\n"

		sed -ie 's@disable = false@disable = true@g' $config

		echo "DONE."
		grep -E "disable = true" $config 
	fi
}

enable(){

	 if (grep -E "disable = false" $config );
	then
		printf "\033[1m  is Already Enabled. \033[0m \n"

	else
		echo "Enabling..."
		printf "\n"

		sed -ie 's@disable = true@disable = false@g' $config
		
		echo "DONE."
		grep -E "disable = false" $config 
	fi
}

status(){

		echo "Checking Status..."
		printf "\n"

	if (grep -E "disableSelfBundles = false" $config );
	then
		printf "\033[1m is Enabled. \033[0m \n"

	else (grep -E "disable = true" $config ;

		printf "\033[1m is Disabled. \033[0m \n"

	fi
}

case "$1" in
                enable)
                enable
                ;;

				disable)
                disable
                ;;

				status)
                status
                ;;

            *)
                echo "Usage: {
                       Example => sudo example_5.sh enable

                       enable | disable | status 
                        
                     }"
esac
exit 0