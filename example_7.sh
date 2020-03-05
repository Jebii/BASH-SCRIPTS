#!/bin/bash

#Script to Add / Remove interger from tags in a  xml file


file_name=filelocation
regex='^[0-9]+$'
tag_content=$(grep -E "tag_name" $file_name | grep -oP '>\K(\d.*\d)')  


validate() {

	if ! [[  $add_input =~ $regex || $remove_input =~ $regex ]]; 
	then
		echo "Not an Integer. Please enter the correct Numbers." >&2;
		exit 0
	elif grep -E "tag_name" $file_name | grep -oP '>\K(\d.*\d)' | grep -wq "$add_input" ; 
	then
		echo "Number Already Exists. Please enter New ID." >&2;
		exit 0
	fi
}

validate2(){

	if ! (grep -E "tag_name" $file_name | grep -oP '>\K(\d.*\d)' | grep -wq "$remove_input") ; 
	then
		echo "Number Does Not Exist. Please Confirm ID." >&2;
		exit 0
	fi
}



add_number(){

	echo "Enter the New Number..."

	read -rp 'New Number : ' add_input

	if [[ -n "$add_input" ]]; then
	validate
	printf "\n"
	printf "%sYou have entered Number: \033[1m $add_input \033[0m \n"

	read  -r -p "Confirm [Y/N] : " answer
	case "$answer" in
		[yY])
	 		printf "\n"
			printf "Adding new Number to tag... \n"  
			grep -E "tag_name" $file_name | grep -oP '>\K(\d.*\d)'  #display numbers in tag
			sed -ie "s/$tag_content/$tag_content\,$add_input/g" $file_name
			printf "\n"
			grep -E "tag_name" $file_name | grep -oP '>\K(\d.*\d)'  #display numbers after adding
			;;
		*)
			exit 0
			;;
	esac	

	fi
}


remove_input(){

	echo "Enter the Number to be Removed..."
	read -rp 'Enter Number : ' remove_input
	
	if [[ -n "$remove_input" ]]; then
	validate
	validate2
	printf "\n"
	printf "%sRemove Number \033[1m $remove_input \033[0m from the tag..\n"
	
	read  -r -p "Confirm [Y/N] : " answer
	case "$answer" in
		[yY])
	 		printf "\n" 
			printf "Removing Number from ... \n"

			if [[ $(grep ",$remove_input</entry>" $file_name | wc -c) -ne 0  ]]; then   #if number is at the begininng of tag
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    printf "\n"
                    sed -ie "s@,$remove_input</entry>@</entry>@g" $file_name
                    printf "Removed Number from file_name file. \n"
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    exit 0

            elif [[ $(grep ",$remove_input," $file_name | wc -c) -ne 0  ]]; then    #if number is in the middle
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    printf "\n"
                    sed -ie "s/,$remove_input,/,/g" $file_name
                    printf "Removed Number from file_name file. \n"
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    exit 0

            elif [[ $(grep "<entry key=\"tag_content\">$remove_input," $file_name | wc -c) -ne 0  ]]; then  #if number is at end of tag
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    printf "\n"
                    sed -ie "s@<entry key=\"tag_content\">$remove_input,@<entry key=\"tag_content\">@g" $file_name
                    printf "Removed Number from file_name file. \n"
                    grep -E "tag_content" $file_name | grep -oP '>\K(\d.*\d)'
                    exit 0
			fi
			;;
		*)

			exit 0
			;;
	esac	

	fi

}



case "$1" in
                        add-input)
						add_input
                        ;;

			            remove-input)
						remove_input
                        ;;
                        *)
                        echo "Usage: [ sudo sh example_7.sh add-input |remove-input  ]"

esac
exit 0

