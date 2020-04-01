# Use neovim for vim if present.
command -v nvim >/dev/null && export EDITOR='nvim' \
    && alias v=$EDITOR vim="nvim" vimdiff="nvim -d"

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR="nvr -cc split --remote +'set bufhidden=wipe' --remote-send \<F5\>\<F5\>"
    alias v="$EDITOR"
else
    export EDITOR='nvim'
fi

if [ ! -d "$HOME/.zinit" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi


zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit light softmoth/zsh-vim-mode
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait as"program" pick"bin/git-dsf" lucid
zinit load zdharma/zsh-diff-so-fancy

# On OSX, you might need to install coreutils from homebrew and use the
# g-prefix – gsed, gdircolors
zinit ice atclone"local PFX=${${(M)OSTYPE:#*darwin*}:+g}
            git reset --hard; \${PFX}sed -i \
            '/DIR/c\DIR                   38;5;63;1' LS_COLORS; \
            \${PFX}dircolors -b LS_COLORS > c.zsh" \
            atpull'%atclone' pick"c.zsh" nocompile'!' \
            atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit load trapd00r/LS_COLORS
if [ "$OSTYPE"  != linux-gnu ]; then # Is this the MacOS system
    alias ls="gls -hNFp --color --group-directories-first"
else
    alias ls="ls -hNFp --color --group-directories-first"
fi

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice wait lucid
zinit load hlissner/zsh-autopair

zinit ice wait lucid
zinit snippet OMZ::lib/directories.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/history.zsh

# zinit ice wait lucid
# zinit load rupa/z

# zinit ice wait lucid
# zinit load changyuheng/fz

zinit ice wait lucid
zinit load zsh-users/zsh-history-substring-search

zinit ice wait lucid
zinit load MichaelAquilina/zsh-you-should-use

zinit ice wait blockf atpull'zplugin creinstall -q .' lucid
zinit light zsh-users/zsh-completions

zinit ice wait atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma/fast-syntax-highlighting

zinit ice wait atload"_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTO_SUGGEST_USE_ASYNC=true


# 10ms for key sequences
KEYTIMEOUT=1

# eval $(thefuck --alias)

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

