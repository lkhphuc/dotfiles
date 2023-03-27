if [ ! -d "$HOME/.zsh" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git $HOME/.zsh/zsh-snap
fi
source $HOME/.zsh/zsh-snap/znap.zsh

znap eval starship "starship init zsh --print-full-init"
znap prompt
# znap source romkatv/powerlevel10k
# znap source jeffreytse/zsh-vi-mode
# function zvm_after_init() {
znap source junegunn/fzf shell/{completion,key-bindings}.zsh
  export FZF_DEFAULT_OPTS="--layout=reverse"
  # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# }

# package managers
[[ -x "$(command -v brew)" ]] &&  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# terminal's shell-integration
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
[[ "$TERM_PROGRAM" == "WezTerm" ]] && export TERM=wezterm
znap eval wezterm 'curl -fsSL https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh'
znap fpath _wezterm "wezterm shell-completion --shell zsh"

# python
znap install conda-incubator/conda-zsh-completion
znap eval conda "conda shell.zsh hook"
znap eval pipx "register-python-argcomplete pipx"
znap eval pip 'eval "$(pip completion --zsh)"'
znap fpath _poetry 'poetry completions zsh'

znap source marlonrichert/zsh-autocomplete
  zstyle ':autocomplete:*' min-input 0
  zstyle ':autocomplete:*' insert-unambiguous yes
  zstyle ':autocomplete:*' widget-style menu-select
  zstyle ':autocomplete:*' fzf-completion yes
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
znap source zsh-users/zsh-autosuggestions  # On same line
znap source zpm-zsh/colors
znap source zpm-zsh/ls # Use exa for ls
znap source zpm-zsh/autoenv
znap source hlissner/zsh-autopair
znap source MichaelAquilina/zsh-you-should-use
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-completions

# znap eval direnv  "direnv hook zsh"
znap eval zoxide "zoxide init zsh"
znap fpath _fuck "$(thefuck --alias)"
znap install ogham/exa
znap source not-poma/lazyshell  # GPT

export EDITOR="nvim"
if [[ -v NVIM ]]; then EDITOR="nvr -l" fi
# command -v floaterm >/dev/null 2>&1 && EDITOR="floaterm"
alias v="$EDITOR" vimdiff="$EDITOR -d"
alias g="git" lg="lazygit"

export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export SAVEHIST=2000
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=2000

which sccache > /dev/null && export RUST_WRAPPER=sccache
GO="$HOME/go/bin" && [ -d $GO ] && export PATH="$GO:$PATH"
HASKELL="$HOME/.ghcup/bin" && [ -d $HASKELL ] && export PATH="$HASKELL:$PATH"
export JUPYTER_CONFIG_PATH="~/.config/jupyter/:$JUPYTER_CONFIG_PATH"

source $HOME/.config/lf/lficons.rc

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# vim:ft=bash
