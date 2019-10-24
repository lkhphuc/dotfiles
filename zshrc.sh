# Automatically install ZPlug
if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi


# COMMENT OUT FOR FASTER STARTUP
# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
# 	printf "Install? [y/N]: "
# 	if read -q; then
# 		echo; zplug install
# 	fi
# fi
zplug load # Source plugins and add commands to $PATH
export ZSH_AUTO_SUGGEST_USE_ASYNC=true
# Spaceship Prompt
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  jobs          # Background jobs indicator
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  line_sep      # Line break
  char          # Prompt character
  )
export SPACESHIP_RPROMPT_ORDER=(
  exit_code     # Exit code section
  exec_time     # Execution time
  git           # Git section (git_branch + git_status)
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  )
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_PROMPT_SEPARATE_LINE=false
export SPACESHIP_PROMPT_PREFIXES_SHOW=true
export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_TIME_SHOW=true
spaceship_vi_mode_enable

function chpwd() {
    emulate -L zsh
    ls
}

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'

# ZPLUG
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'plugins/tmux', from:oh-my-zsh
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "zdharma/fast-syntax-highlighting", defer:1
zplug "zsh-users/zsh-autosuggestions", defer:2
# zplug "rupa/z", use:z.sh, defer:2
# zplug "changyuheng/fz", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-completions", defer:3
# zplug "plugins/osx", from:oh-my-zsh, defer:3
zplug "MichaelAquilina/zsh-you-should-use", defer:3



# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
# Source plugins and add commands to $PATH
zplug load
