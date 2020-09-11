#!/bin/bash

if [ "$1" ]
then
	destPath=$1
else
	destPath="$HOME"
fi

# Exclude .config folder to be symliked seperately and other files
exclude=( ".config" ".git" ".gitignore" "symlink.sh")

# Math hidden files with globbing
shopt -s dotglob 

# Where dotfiles are to be symliked to	
echo "${destPath}" 

# The directory the folder is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

# Symlink files in home directory
for file in *; do
    for (( index = 0; index < ${#exclude[@]}; index++ )); do
        if [[ ${file} != ${exclude[${index}]} ]]; then
            ln -sfn ${DIR}/${file} ${destPath}/${file}
        fi  
    done
done

mkdir -p ${destPath}/.config # Create a .config folder if it doesn't already exist

# Symlink files in .config directory
for file in .config/*; do
    for (( index = 0; index < ${#exclude[@]}; index++ )); do
        if [[ ${file} != ${exclude[${index}]} ]]; then
            ln -sfn ${DIR}/${file} ${destPath}/${file}
        fi  
    done
done

# Special case for nvim
ln -sfn "${DIR}/.vimrc" "${destPath}/.config/nvim/init.vim"
