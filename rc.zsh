if [ ! -d "$HOME/.zsh-snap" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git $HOME/.zsh-snap/zsh-snap
fi
source $HOME/.zsh-snap/zsh-snap/znap.zsh

znap source romkatv/powerlevel10k
znap source jeffreytse/zsh-vi-mode

znap source zpm-zsh/colors
znap source zpm-zsh/ls
znap source ohmyzsh/ohmyzsh plugins/git
znap source hlissner/zsh-autopair
znap source MichaelAquilina/zsh-you-should-use
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-autosuggestions  # On same line
  export ZSH_AUTO_SUGGEST_USE_ASYNC=true
znap source zsh-users/zsh-completions
znap source agkozak/zsh-z
znap source Tarrasch/zsh-autoenv 
# znap source marlonrichert/zsh-autocomplete

znap eval junegunn/fzf 'command -v fzf >/dev/null 2>&1 || {./install --bin} >/dev/null'
znap source junegunn/fzf shell/{completion.zsh,key-bindings.zsh}
path=(~[junegunn/fzf]/bin $path .)

znap eval trapd00r/LS_COLORS 'command -v gdircolors >/dev/null 2>&1 && { gdircolors -b LS_COLORS} || { dircolors -b LS_COLORS}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
znap eval fuck 'thefuck --alias'
znap eval pip 'pip completion --zsh'
znap eval brew-shellenv 'command -v brew >/dev/null 2>&1 && { brew shellenv }'
znap eval kitty 'kitty + complete setup zsh'

source ~/dotfiles/diricons
command -v floaterm >/dev/null 2>&1 && EDITOR="floaterm" || EDITOR="nvim"
alias v="$EDITOR" vim="nvim" vimdiff="nvim -d" lg="lazygit"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"

export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
