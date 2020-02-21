# Use neovim for vim if present.
command -v nvim >/dev/null && export EDITOR='nvim' \
    && alias v=$EDITOR vim="nvim" vimdiff="nvim -d"

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR="nvr -cc split --remote +'set bufhidden=wipe' --remote-send \<F5\>\<F5\>"
    alias v="$EDITOR"
else
    export EDITOR='nvim'
fi

if [ ! -d "$HOME/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

# zplugin self-update
### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# Spaceship Prompt
zplugin light denysdovhan/spaceship-prompt
    SPACESHIP_PROMPT_ORDER=(
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
      vi_mode       # Vi-mode indicator
      exit_code     # Exit code section
      exec_time     # Execution time
      git           # Git section (git_branch + git_status)
      battery       # Battery level and status
      time          # Time stamps section
      )
    export SPACESHIP_VI_MODE_INSERT=''
    export SPACESHIP_VI_MODE_NORMAL='<<'
    export SPACESHIP_PROMPT_ADD_NEWLINE=false
    export SPACESHIP_PROMPT_PREFIXES_SHOW=false
    export SPACESHIP_EXIT_CODE_SHOW=true
    export SPACESHIP_TIME_SHOW=true

zplugin light softmoth/zsh-vim-mode
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin ice wait as"program" pick"bin/git-dsf" lucid
zplugin load zdharma/zsh-diff-so-fancy

# On OSX, you might need to install coreutils from homebrew and use the
# g-prefix – gsed, gdircolors
zplugin ice \
    atclone"local PFX=${${(M)OSTYPE:#*darwin*}:+g}
            git reset --hard; \${PFX}sed -i \
            '/DIR/c\DIR                   38;5;63;1' LS_COLORS; \
            \${PFX}dircolors -b LS_COLORS > c.zsh" \
            atpull'%atclone' pick"c.zsh" nocompile'!' \
            atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zplugin load trapd00r/LS_COLORS
if [ "$OSTYPE"  != linux-gnu ]; then # Is this the MacOS system
    alias ls="gls -hNFp --color --group-directories-first"
else
    alias ls="ls -hNFp --color --group-directories-first"
fi

zplugin ice wait lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin ice wait lucid
zplugin load hlissner/zsh-autopair

zplugin ice wait lucid
zplugin snippet OMZ::lib/directories.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/history.zsh

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
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}
vf() { fzf | xargs -r -I % $EDITOR % ;}


# Fuzzy search pdfs in Zotero
pdf () {
    local open
    open=open   # on OSX, "open" opens a pdf in preview
    fd ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | gtr " " "|"); 
            echo -e {1}"\n"{2} | ggrep -E "^|$v" -i --color=always;
        ' \
    | gcut -z -f 1 -d $'\t' | gtr -d '\n' | gxargs -r --null $open > /dev/null 2> /dev/null
}

