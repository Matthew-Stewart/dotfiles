#!/usr/bin/env bash


if [[ ! -d "$HOME/dotfiles" ]]; then
   echo "$HOME/dotfiles directory not found. quitting"
   exit 1
fi

# symlink files from dotfiles to user's home folder
for file in .{aliases,bash_profile,exports,functions,gitconfig,gitignore_global,path,vimrc}; do
   if [[ -e "$HOME/$file" ]]; then
      echo "found old ${file}, backing up to ${file}.backup"
      mv "$HOME/$file" "$HOME/${file}.backup"
   fi
   ln -s "$HOME/dotfiles/$file" "$HOME/$file"
done;

# attempt to copy folder contents if it already exists
for file in .{bash,vim}; do
   if [[ -d "$HOME/$file" ]]; then
      echo "found old ${file}, merging with new ${file}"
      cp -rp "$HOME/dotfiles/$file/." "$HOME/$file/"
   elif [[ -e "$HOME/$file" ]]; then
      echo "found old ${file}, backing up to ${file}.backup"
      mv "$HOME/$file" "$HOME/${file}.backup"
      ln -s "$HOME/dotfiles/$file" "$HOME/$file"
   else
      ln -s "$HOME/dotfiles/$file" "$HOME/$file"
   fi
done;


# vim complains if these directories don't exist
mkdir "$HOME/.vim/swaps"
mkdir "$HOME/.vim/backups"
mkdir "$HOME/.vim/undo"

# install Vundle and Vundle plugins in .vimrc
read -r -p "Install Vundle and Vundle Plugins for vim (y/n)? " yn
if echo "$yn" | grep -iq "^y"; then
   skip=false

   # install vundle
   git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
   vim +PluginInstall +qall

   # manual steps:

   # build vimproc
   cd "$HOME/.vim/bundle/vimproc.vim"
   make

   # install ycm
   cd "$HOME/.vim/bundle/YouCompleteMe"
   if ! hash apt 2>/dev/null; then
      sudo apt install build-essential cmake python3-dev -y
   else
      echo "Apt not found. Skipping YCM install."
      echo "Follow directions at https://github.com/Valloric/YouCompleteMe#installation"
      skip=true
   fi

   if [ "$skip" != true ]; then
      "$HOME"/.vim/bundle/YouCompleteMe/install.py --clang-completer
   fi
fi

# install Powerline status bar for vim
read -r -p "Install Powerline for vim (y/n)? " yn
if echo "$yn" | grep -iq "^y"; then
   skip=false

   if ! hash pip 2>/dev/null; then
      if ! hash brew 2>/dev/null; then
         echo "Homebrew not found. Skipping Powerline install."
         skip=true
      else
         # install pip
         brew install python
      fi
   fi

   if [ "$skip" != true ]; then
      pip install powerline-status
   fi
fi
