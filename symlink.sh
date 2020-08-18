#!/bin/bash

if [ "$1" ]
then
	destPath=$1
else
	destPath="$HOME"
fi

echo "${destPath}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s "${DIR}/dotfiles/.zsh" "${destPath}/.zsh"
ln -s "${DIR}/dotfiles/.zshrc" "${destPath}/.zshrc"
ln -s "${DIR}/dotfiles/.vimrc" "${destPath}/.vimrc"
ln -s "${DIR}/dotfiles/.xbindkeysrc" "${destPath}/.xbindkeysrc"
ln -s "${DIR}/dotfiles/.vim" "${destPath}/.vim"
ln -s "${DIR}/dotfiles/nvim/" "${destPath}/.config/"
