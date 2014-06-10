#!/bin/bash
dir=~/dotfiles
files="bashrc vimrc bash_aliases ghc vimperatorrc vimrc tmux.conf"

cd ~
for file in $files; do
	echo "creating symlink to $file in home dir"
	ln -s $dir/$file .$file 
done


