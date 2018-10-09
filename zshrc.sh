# Automatically install ZPlug
if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi


# Settings
export ZSH_TMUX_AUTOSTART=true
export VISUAL=nvim
export EDITOR="$VISUAL"

# Aliases
alias v="vim -p"
alias docker="sudo docker"
alias nv="nvim"
alias fzf="$HOME/.fzf/bin/fzf-tmux"


# ZPLUG
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'plugins/tmux', from:oh-my-zsh
# Load theme file
zplug 'dracula/zsh', as:theme
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/directories", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/keybindings", from:oh-my-zsh
zplug "lib/misc", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions", defer:1
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/docker", from:oh-my-zsh, defer:2
zplug "plugins/osx", from:oh-my-zsh, defer:3


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
# Source plugins and add commands to $PATH
zplug load 
