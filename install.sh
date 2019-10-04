#!/bin/sh

symlink() {
    curr_dir=`pwd`
    src=$1
    dst=$2
    
    if [ ${curr_dir}/${src} != `realpath $dst` ]; then
        if [ -e $dst ]; then
            mv $dst ${dst}.bk.`date -u | sed 's/ /_/g'`
        fi

        ln -s ${curr_dir}/${src} $dst
    fi
}

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim

symlink init.vim ~/.config/nvim/init.vim

nvim -c ":PlugInstall"
