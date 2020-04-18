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

vim_plug="${HOME}/.local/share/nvim/site/autoload/plug.vim"

if [ ! -e ${vim_plug} ]; then
    curl -fLo ${vim_plug} --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

mkdir -p ~/.config/nvim

symlink init.vim ~/.config/nvim/init.vim

# Customize git
symlink gitmessage ~/.gitmessage
git config --global commit.template ~/.gitmessage

# Add script
symlink remote-sudoedit ~/.local/bin/remote-sudoedit

nvim -c ":PlugInstall"
