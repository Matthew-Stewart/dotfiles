#!/bin/bash

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
