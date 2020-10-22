# Use neovim for vim if present.
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR="floaterm"
elif type "nvim" > /dev/null; then
    export EDITOR="nvim"
fi

alias v="$EDITOR" vim="nvim" vimdiff="nvim -d"

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
zinit load hlissner/zsh-autopair

zinit ice wait lucid
zinit snippet OMZ::lib/directories.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/history.zsh

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

zinit ice svn as"program" pick'it2copy'
zinit snippet https://github.com/gnachman/iterm2-website/trunk/source/utilities

# eval $(thefuck --alias)

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"

export KEYTIMEOUT=1

export PAGER="bat --color=always"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#
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

