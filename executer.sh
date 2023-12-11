#!/bin/bash
source /opt/servercheck/defaultConfig.conf
source /opt/servercheck/functions.sh

editor=vim
apppath=/opt/servercheck
templatesFolder=$apppath/templates

#----------------------------------------------------------
# argument passing is : --temp=<template file path / relative or absolute>
# argument passing is : --newtemp=<template file path / relative or absolute>
# template variable set
selectedTemplate=$(echo "$1" | cut -d "=" -f2)

#----------------------------------------------------------
# Check if there are no arguments
if [[ $# -eq 0 ]] 
then
    ArgumentPrint "noArgument"
    exit 1
elif [[ $# -ne 1 ]]
then
    ArgumentPrint "moreThanOne"
    exit 1
fi

#----------------------------------------------------------
# Check if the script is invoked with the option to create a new template
if [[ $1 == "--newtmp="* ]]; then 

    # CREATE A NEW TEMPLATE 
    checkEmpty "$selectedTemplate"
    createTemplateFile "$selectedTemplate"

# Check if the script is invoked with the option to display the path of an existing template
elif [[ $1 == "--tmp="* ]]; then 

    # PROGRAM START
    checkEmpty "$selectedTemplate"
    templatePath=$(templateCheck "$templatesFolder" "$selectedTemplate")
    echo "$templatePath"

# Check if the script is invoked with the option to show all templates
elif [[ $1 == "--showtmp" ]]; then

    # SHOW TEMPLATES 
    Save-Delete-Show-Template "NULL" "show"

# Check if the script is invoked with the option to edit a template file
elif [[ $1 == "--edittmp="* ]]; then

    # EDIT TEMPLATE FILES
    checkEmpty "$selectedTemplate"
    editingMenu "$selectedTemplate" "$editor"

# Check version
elif [[ $1 == "-v" || $1 == "-V" || $1 == "--version" ]]; then
    
    # VERSION
    version

# Handle the case where none of the expected options are provided
else
    ArgumentPrint "wrongArgument"
    exit 1
fi

#----------------------------------------------------------



#source ./configvar





 

