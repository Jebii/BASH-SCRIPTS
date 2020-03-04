#!/bin/bash

#Script to add new number in array, take user integer input, validate as integer , confirm input, add to array in a file

#assign file location to variable
file_name=(file location)

#validate input as integer
regex='^[0-9]+$'

#look for array in filename and display before and after equals sign
array_content=$(grep -E "array_name =" $file_name | grep -Eo ".{0,43}=.{0,7}")


#Funcation : validate if input is integer and 12 characters long or already exists in array or in the entire file
validate(){

    if ! [[ $input =~ $regex &&  ${#input} -eq 12 ]]; 
    then
        echo "Incorrect Input. Please enter the correct Numbers" >&2;
        exit 0
    elif grep -E "array_name =" $file_name | grep -wq "$input" ; 
    then
        echo "Number Already Exists. Please enter New Number." >&2;
        exit 0
    elif grep -wq "$input" $file_name; then
        echo "Number Already Exists in File. Please Confirm & enter New Number." >&2;
        exit 0
    fi
}



echo "Enter New Number..."
read -rp 'Enter Number : ' Input   	#input is assigned as variable
validate 							#validate funcation called

printf "%sYou have entered the number - \033[1m $input \033[0m \n "
read -rp "Confirm [Y/N]:" answer
    case "$answer" in
    [yY])
        printf "\n"
        printf "Adding new Number ... \n"  
        grep -E "array_name =" $file_name | grep -Eo ".{0,43}=.{0,51}"    #display array before the edit
        printf "\n"
        sed -ie "s/$array_content/$array_content\ $input,/g" $file_name     #add new number input to beginning of array
	    grep -E "array_name =" $file_name | grep -Eo ".{0,43}=.{0,52}"		#display array after adding new number
        ;;
    *)
        exit 0
        ;;
    esac 
