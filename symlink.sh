#!/bin/bash

# Sets the destination path, user's home by default
if [ "$1" ]
then
  destPath=$1
else
  destPath="$HOME"
fi

# Exclude .config folder to be symliked seperately and ignore other files
exclude=(".config" ".git" ".gitignore" "symlink.sh" ".local")

# Match hidden files with globbing
shopt -s dotglob

# Shows where dotfiles are to be symliked to
echo Dotfiles installed to "${destPath}"

# The directory the folder is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

# Symlink files in home directory
for file in *; do
  excluded=false
  for (( index = 0; index < ${#exclude[@]}; index++ )); do
    if [[ ${file} = ${exclude[${index}]} ]]; then
      excluded=true
    fi
  done
  if [ ${excluded} = false ]; then
    ln -sfn ${DIR}/${file} ${destPath}/${file}
  fi
done

mkdir -p ${destPath}/.config # Create a .config folder if it doesn't already exist

# Symlink files in .config directory
for file in .config/*; do
  ln -sfn ${DIR}/${file} ${destPath}/${file}
done

# Special case for nvim
ln -sfn "${DIR}/.vimrc" "${destPath}/.config/nvim/init.vim"
