#!/bin/bash

# Set the directory path
directory="./compositor"
dockerfile_out="./work/Dockerfile"
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
echo "bs_files: ${bs_files[@]}"
echo "sym_files: ${sym_files[@]}"
echo "chrg_files: ${chrg_files[@]}"

composit() {
    file=$1
    dockerfile_out=$2
    echo "Processing file: $file"
    echo "# $file" >> $dockerfile_out
    while IFS= read -r line; do
        echo $line
        echo "$line" >> $dockerfile_out
    done < "$file"
    echo "##############################" 
    echo "##############################" >> "$dockerfile_out"
}

if [ -e "$dockerfile_out" ]; then
    mv "$dockerfile_out" "$dockerfile_out-old"
fi

if [ ${#bs_files[@]} -eq 1 ]; then
    composit $bs_files $dockerfile_out
else
    echo "Base file must be only one."
fi

for sym_file in "${sym_files[@]}"; do
    composit $sym_file $dockerfile_out
done

if [ ${#chrg_files[@]} -eq 1 ]; then
    composit $chrg_files $dockerfile_out
else
    echo " Charge file must be only one."
fi

echo $dockerfile_out