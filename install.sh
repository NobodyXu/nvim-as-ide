#!/bin/sh

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim

# Backup previous init.vim
config_file=~/.config/nvim/init.vim

if [ -e $config_file ]; then
    mv $config_file ${config_file}.bk.`date -u | sed 's/ /_/g'`
fi

ln -s `pwd`/init.vim $config_file

nvim -c ":PlugInstall"
