if [ ! -d "$HOME/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi
### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# Spaceship Prompt
zplugin light denysdovhan/spaceship-prompt
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
      # line_sep      # Line break
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
    export SPACESHIP_PROMPT_PREFIXES_SHOW=false
    export SPACESHIP_EXIT_CODE_SHOW=true
    export SPACESHIP_TIME_SHOW=true

zplugin ice wait lucid
zplugin light softmoth/zsh-vim-mode
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

zplugin ice wait lucid
zplugin snippet OMZ::plugins/tmux.plugins.zsh
zplugin ice wait lucid
zplugin snippet OMZ::lib/directories.zsh
zplugin ice wait lucid
zplugin snippet OMZ::lib/history.zsh
zplugin ice wait lucid
zplugin snippet OMZ::plugins/osx/osx.zsh
zplugin ice wait lucid
zplugin load rupa/z
zplugin ice wait lucid
zplugin load changyuheng/fz
zplugin ice wait lucid
zplugin load zsh-users/zsh-history-substring-search
zplugin ice wait lucid
zplugin load MichaelAquilina/zsh-you-should-use

zplugin ice wait blockf atpull'zplugin creinstall -q .' lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions
export ZSH_AUTO_SUGGEST_USE_ASYNC=true


# 10ms for key sequences
KEYTIMEOUT=1
eval $(thefuck --alias)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
source "$HOME/.aliasrc"
