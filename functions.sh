#!/bin/bash

# --------------------------------------------------------------------------------
# Function: helpPage
#
# Description:
#   Displays the help page content stored in the variable $apppath/helpPage.

helpPage () {
    cat $apppath/helpPage
}

# --------------------------------------------------------------------------------
# Function: ArgumentPrint
# Description:
#   Checks if an argument is provided. If not, it displays an error message and
#   shows the help page.
#
# Parameters:
#   $1 - Boolean indicating if an argument is provided (no or moreThanOne).

ArgumentPrint () {
	if [[ $1 == "noArgument" ]]
	then	
        echo "Error: Please enter at least 1 option!"
        helpPage
	elif [[ $1 == "moreThanOne" ]]
	then
		echo "Error: Please provide exactly 1 option!"
		helpPage
	elif [[ $1 == wrongArgument ]]
	then
		echo "Error: Please provide option correctly !"
		helpPage
	fi
}

# --------------------------------------------------------------------------------
# Function: checkEmpty
# Description: Checks if a variable is empty. If empty, it prints an error message
#              and exits the script with an error status.
# Parameters:
#   - variable: The variable to be checked for emptiness.

checkEmpty() {
    variable=$1

    # Check if the specified variable is empty
    if [[ -z "$variable" ]]; then
        # Print an error message and exit the script with an error status
        echo "Error: Option does not have a value!"
        exit 1
    fi
}


# --------------------------------------------------------------------------------
# Function: createTemplateFile
# Description: Creates a template file and saves it in the specified directory.
#              If the directory doesn't exist, it creates the necessary folder
#              structure. If the file already exists, it prints an error message
#              and exits the script.
# Parameters:
#   - templateName: The name of the template file to be created.

createTemplateFile() {
    templateName=$1
    directory_path=$(dirname $templateName)

    # Check if the specified directory is the templates folder
    if [[ $directory_path == $templatesFolder ]]
	then
        # Check if the template file already exists
        if [[ -e $templateName ]]; then
            echo "Error: File already exists."
            exit 1
        else
            # Create the template file, copy content from exampleTemplate, and save to template list
            echo "Template file created: $templateName"
            cp $apppath/exampleTemplate $templateName 
            Save-Delete-Show-Template "$templateName" "save"
        fi
    # Check if the specified directory is the current directory
    elif [[ $directory_path == "." ]]
	then
        # Check if the template file already exists
        if [[ -e $templatesFolder/$templateName ]]
		then
            echo "Error: File already exists."
            exit 1
        else
            # Create the template file, copy content from exampleTemplate, and save to template list
            echo "Template file created: $templatesFolder/$templateName"
            cp $apppath/exampleTemplate $templatesFolder/$templateName
            Save-Delete-Show-Template "$templatesFolder/$templateName" "save"
        fi
    # Check if the template file already exists in any other directory
    elif [[ -e $templateName ]] 
	then
        echo "Error: File already exists."
        exit 1
    else
        # Check if the specified directory exists
        if [[ -d $directory_path ]] 
		then 
            # Create the template file, copy content from exampleTemplate, and save to template list
            echo "Template file created: $templateName"
            cp $apppath/exampleTemplate $templateName
            Save-Delete-Show-Template "$templateName" "save"
        else
            # Create the necessary folder structure, create the template file, copy content from exampleTemplate, and save to template list
            echo "Creating folder tree $directory_path"
            mkdir -p $directory_path
            echo "Template file created: $templateName"
            cp $apppath/exampleTemplate $templateName
            Save-Delete-Show-Template "$templateName" "save"
        fi
    fi
}


# --------------------------------------------------------------------------------
# Function: Save-Delete-Show-Template
# Description: Manages templates by saving, deleting, or showing their status in the template list file.
# Parameters:
#   - template: The name of the template to be saved, deleted, or shown.
#   - input: Specifies the action to perform - "delete", "save", or "show".

Save-Delete-Show-Template() {
    template=$1
    input=$2

   
    # Check if the input is to save the template
    if [[ $input == "save" ]]; then
        # Append the template name to the template list file
        echo "$template" >> $apppath/templateList
    # Check if the input is to show the templates
    elif [[ $input == "show" ]]; then
        touch $apppath/temporary
        # Iterate through the template list, filter existing templates, and update the list
        for i in $(cat $apppath/templateList); do
            if [[ -e $i ]]; then
                echo "$i" >> $apppath/temporary
            else
                continue
            fi
        done
        mv $apppath/temporary $apppath/templateList

        if [[ -s $apppath/templateList ]];then
            # Print the updated template list with line numbers
            cat -n $apppath/templateList
        else
            echo "Not any Template files found."
            echo "You can create one with --newtemp=< Template name >"
        fi
    fi
}

# --------------------------------------------------------------------------------
# Function: editingMenu
# Description: Opens the specified template file for editing using the specified editor.
# Parameters:
#   - templateNumber: The line number corresponding to the template in the template list.
#   - editor: The editor command to be used for editing the file.
#   - list: The path to the template list file.

editingMenu() {
    templateNumber=$1
    editor=$2

    # Check if the template number is a valid positive intege r
    if ! [[ "$templateNumber" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid line number."
        exit 1
    fi

    list=$apppath/templateList
    listLineNumber=$(wc $list -l | awk '{print $1}')
    integer_templateNumber=$((templateNumber))
    integer_listLineNumber=$((listLineNumber))


    if [[ $integer_templateNumber -le $integer_listLineNumber ]];then
        # Extract the file path from the specified line number
        file=$(sed -n "${templateNumber}p" "$list")
        # Check if the file path is not empty
        if [ -n "$file" ]; then
            # Open the file for editing using the specified editor
            $editor "$file"
        else
            echo "Error: Line number not found or invalid."
        fi
    else
        echo "Error: Line number not found or invalid."
    fi
}

# --------------------------------------------------------------------------------
# Function to check and set the template path
templateCheck() {
    # Get the application path and selected template from arguments
    templatesFolder=$1
    selectedTemplate=$2
	echo $templatesFolder
    # Check if the template file exists in the specified path
    if [[ -e $templatesFolder/$selectedTemplate ]]; then
        # If it exists, set the templatePath variable and echo it
        templatePath=$templatesFolder/$selectedTemplate
        echo "$templatePath"
    # Check if the template file exists in the current directory
    elif [[ -e $selectedTemplate ]]; then
        # If it exists, set the templatePath variable and echo it
        templatePath=$selectedTemplate
        echo "$templatePath"
    else
        # If the template file doesn't exist, print an error message and exit
        echo "Could not able to find the template file: $selectedTemplate"
        echo "Exiting..."
        exit 1
    fi
}
# --------------------------------------------------------------------------------

