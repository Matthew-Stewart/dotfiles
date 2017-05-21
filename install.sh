#!/bin/bash

# vim complains if these directories don't exist
mkdir $HOME/dotfiles/.vim/swaps
mkdir $HOME/dotfiles/.vim/backups
mkdir $HOME/dotfiles/.vim/undo

# install vundle
# comment out this line (and vundle section of vimrc) if unneeded
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/dotfiles/.vim/bundle/Vundle.vim

# install powerline
# assumes 'brew install python' has been run
# again, comment out as needed
pip install powerline-status

for file in .{aliases,bash_profile,exports,functions,gitconfig,gitignore_global,path,vimrc}; do
   if [[ -e $HOME/$file ]]; then
      echo "found old ${file}, backing up to ${file}.backup"
      mv $HOME/$file $HOME/${file}.backup
   fi
   ln -s $HOME/dotfiles/$file $HOME/$file
done;

# attempt to copy folder contents if it already exists
for file in .{bash,vim}; do
   if [[ -d $HOME/$file ]]; then
      echo "found old ${file}, merging with new ${file}"
      cp -rp $HOME/dotfiles/$file/. $HOME/$file/
   elif [[ -e $HOME/$file ]]; then
      echo "found old ${file}, backing up to ${file}.backup"
      mv $HOME/$file $HOME/${file}.backup
      ln -s $HOME/dotfiles/$file $HOME/$file
   else
      ln -s $HOME/dotfiles/$file $HOME/$file
   fi
done;
