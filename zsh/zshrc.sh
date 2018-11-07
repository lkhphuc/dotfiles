# Automatically install ZPlug
if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi


# Settings
export ZSH_TMUX_AUTOSTART=true
export VISUAL=nvim
export EDITOR="$VISUAL"
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_EXIT_CODE_SHOW=true
export ZSH_AUTO_SUGGEST_USE_ASYNC=true
zstyle ':completion:*' menu select
export KEYTIMEOUT=1


# Aliases
alias v="vim -p"
alias docker="sudo docker"
alias nv="nvim"
alias fzf="$HOME/.fzf/bin/fzf-tmux"
alias ls="ls -GFp"

function cs () {
	cd "$@" && ls
}

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZPLUG
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'plugins/tmux', from:oh-my-zsh
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/directories", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

zplug "zdharma/fast-syntax-highlighting", defer:1
zplug "zsh-users/zsh-completions", defer:1
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
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
