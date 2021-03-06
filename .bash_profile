#!/usr/bin/env bash

# github.com/mathiasbynens/dotfiles/blob/master/.bash_profile

export PATH="$HOME/bin:$PATH";

for file in ~/.{path,bashrc,exports,aliases,functions,extra}; do
   [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;


shopt -s dotglob

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
   source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
   source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
   complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;


# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# fix opening new tab in osx terminal
osascript -e 'tell app "Terminal" to set number of rows of window 1 to 100'
