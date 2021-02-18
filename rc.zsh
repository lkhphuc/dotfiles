if [ ! -d "$HOME/.zsh-snap" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git $HOME/.zsh-snap/zsh-snap
fi
source $HOME/.zsh-snap/zsh-snap/znap.zsh

znap prompt sindresorhus/pure
znap prompt softmoth/zsh-vim-mode
  VIM_MODE_NO_DEFAULT_BINDINGS=true
  KEYTIMEOUT=1
  MODE_CURSOR_VIINS="blinking bar"
  MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
  MODE_CURSOR_VICMD=" block"
  MODE_CURSOR_SEARCH="#ff00ff steady underline"
  MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
  MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
  MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
  MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
  MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
  MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'

znap source zpm-zsh/colors
znap source zpm-zsh/ls
znap source ohmyzsh/ohmyzsh lib/{history}
znap source hlissner/zsh-autopair
znap source MichaelAquilina/zsh-you-should-use
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-autosuggestions
  export ZSH_AUTO_SUGGEST_USE_ASYNC=true
znap source zsh-users/zsh-completions
znap source rupa/z
# znap source marlonrichert/zsh-autocomplete

znap clone trapd00r/LS_COLORS
command -v gdircolors >/dev/null 2>&1 && { alias dircolors=gdircolors }
znap eval LS_COLORS 'dircolors -b ~[LS_COLORS]/LS_COLORS'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
znap eval direnv 'direnv hook zsh'
znap eval fuck 'thefuck --alias'

# Use neovim for vim if present.
EDITOR='nvim'
alias v="$EDITOR" vim="nvim" vimdiff="nvim -d" lg="lazygit"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"

export PAGER="bat --color=always --paging=never"
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"
