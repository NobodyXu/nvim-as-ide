#!/bin/sh

curl -fLo ~/.local/share/nvim/site/autoload/plugvim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
ln -s `pwd`/init.vim ~/.config/nvim/init.vim
