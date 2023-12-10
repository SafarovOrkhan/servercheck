#!/bin/bash
source /opt/serverCheck/functions.sh

apppath=/opt/serverCheck
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

if [[ $1 == "--newtemp="* ]]
then 
    checkEmpty "$selectedTemplate"
    createTemplateFile "$selectedTemplate"
elif [[ $1 == "--temp="* ]]
then 
    checkEmpty "$selectedTemplate"
    templatePath=$(templateCheck "$templatesFolder" "$selectedTemplate")
    echo "$templatePath"
elif [[ $1 == "--showtemp" ]]; then
    Save-Delete-Show-Template "NULL" "show"
else
    ArgumentPrint "wrongArgument"
    exit 1
fi
#----------------------------------------------------------



#source ./configvar





 

