#!/bin/bash

# Set the directory path
directory="./compositor"
sym_files=()
bs_files=()
chrg_files=()

# Function to categorize files
categorize_files() {
    for file in "$1"/*; do
        if [[ -d "$file" ]]; then
            # If it's a directory, recurse into it
            categorize_files "$file"
        elif [[ -f "$file" ]]; then
            # If it's a file, categorize based on extension
            case "$file" in
                *.sym) sym_files+=("$file");;
                *.bs)  bs_files+=("$file");;
                *.chrg) chrg_files+=("$file");;
            esac
        fi
    done
}

# Call the function with the specified directory
categorize_files "$directory"

# Print the lists
echo "sym_files: ${sym_files[@]}"
echo "bs_files: ${bs_files[@]}"
echo "chrg_files: ${chrg_files[@]}"
