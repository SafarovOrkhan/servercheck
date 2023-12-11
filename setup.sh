#!/bin/bash

cat banner

echo "  WELCOME TO SERVERCHECK INSTALLATION SETUP"
echo ""
if [ "$EUID" -ne 0 ]; then
    echo "Error: Installation setup must run as \"root\" user"
    exit 1
fi

echo -n "Do you want to continue ? (Y[y] / N[n]) : "
read user_input

continue=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')

if [[ $continue == yes || $continue == y ]];then
    echo "---------------------------------"
    echo "Proceeding ..."
elif [[ $continue == no || $continue == n ]];then
    echo "Exiting the installation setup ..."
    echo "Bye !"
    exit 1
else
    echo "Error : Wrong answer"
    echo "Exiting the installation setup ..."
    echo "Bye !"
    exit 1
fi

echo -n "Please provide path to install Application : "
read user_input2 
apppath=$user_input2

if [[ -d $apppath ]];then
    echo -n "Installation path will be $apppath/servercheck . Are you sure ? (Y[y] / N[n]) : "
    read user_input4
    answer1=$(echo "$user_input4" | tr '[:upper:]' '[:lower:]')

    if [[ $answer1 == yes || $answer1 == y ]];then
        echo "Installing ..."
        echo "Application path : $apppath/servercheck"
        current_path=$(pwd)
        mv $current_path $apppath
    elif [[ $answer1 == no || $answer1 == n ]];then
        echo "Exiting the installation setup ..."
        echo "Bye !"
        exit 1
    else
        echo "Error : Wrong answer"
        echo "Exiting the installation setup ..."
        echo "Bye !"
        exit 1
    fi
else 
    echo -n "that folder is not exist. Want to create (Y[y] / N[n]) : " 
    read user_input3
    createdir=$(echo "$user_input3" | tr '[:upper:]' '[:lower:]')

    if [[ $createdir == yes || $createdir == y ]];then
        echo "Creating folder"
        mkdir -p $apppath/servercheck

        echo -n "Installation path will be $apppath/servercheck . Are you sure ? (Y[y] / N[n]) : "
        read answer
        user_input5=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        if [[ $user_input5 == yes || $user_input5 == y ]];then
            echo "Installing ..."
            echo "Application path : $apppath/servercheck"
            current_path=$(pwd)
            mv $current_path $apppath
        elif [[ $user_input5 == no || $user_input5 == n ]];then
            echo "Exiting the installation setup ..."
            echo "Bye !"
            exit 1
        else
            echo "Error : Wrong answer"
            echo "Exiting the installation setup ..."
            echo "Bye !"
            exit 1
        fi

    elif [[ $createdir == no || $createdir == n ]];then
        echo "Exiting the installation setup ..."
        echo "Bye !"
        exit 1
    else
        echo "Error : Wrong answer"
        echo "Exiting the installation setup ..."
        echo "Bye !"
        exit 1
    fi
fi

echo "#servercheck aliases" > /etc/profile.d/servercheck.sh
echo "alias sch='$apppath/servercheck/executer.sh'" >> /etc/profile.d/servercheck.sh
source /etc/profile.d/servercheck.sh
new_apppath=$apppath/servercheck

sed -i "s|^apppath=.*$|apppath=$new_apppath|" $apppath/servercheck/defaultConfig.conf

echo "Installation complete!"
echo ""
echo " WARNING -- > type \"cd\" to exit current folder because this folder will vanish < --"
echo ""
echo "run -> sch --help    to get used to Application"
echo "" 