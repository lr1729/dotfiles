#!/bin/bash

if [ "$1" ]
then
	destPath=$1
else
	destPath="$HOME"
fi

echo "${destPath}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sn "${DIR}/dotfiles/.zsh" "${destPath}/.zsh"
ln -sn "${DIR}/dotfiles/.zshrc" "${destPath}/.zshrc"
ln -sn "${DIR}/dotfiles/.vimrc" "${destPath}/.vimrc"
ln -sn "${DIR}/dotfiles/.xbindkeysrc" "${destPath}/.xbindkeysrc"
ln -sn "${DIR}/dotfiles/.vim" "${destPath}/.vim"
ln -sn "${DIR}/dotfiles/nvim/" "${destPath}/.config/nvim"
ln -sn "${DIR}/dotfiles/.vimrc" "${destPath}/.config/nvim/init.vim"
ln -sn "${DIR}/dotfiles/zathura" "${destPath}/.config/zathura"
