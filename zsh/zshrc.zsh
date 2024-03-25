if [ ! -d "$HOME/.zsh" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git $HOME/.zsh/zsh-snap
fi
source $HOME/.zsh/zsh-snap/znap.zsh

# znap eval starship "starship init zsh --print-full-init"
# znap prompt
znap source romkatv/powerlevel10k
# znap source jeffreytse/zsh-vi-mode
# function zvm_after_init() {
znap source junegunn/fzf shell/{completion,key-bindings}.zsh
  export FZF_DEFAULT_OPTS="--layout=reverse"
  # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
znap source Aloxaf/fzf-tab
znap source Freed-Wu/fzf-tab-source
  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  # set list-colors to enable filename colorizing
  zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
  # preview directory's content with eza when completing cd
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
  # switch group using `,` and `.`
  zstyle ':fzf-tab:*' switch-group ',' '.'

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
[[ -x "$(command -v conda)" ]] && znap eval conda "conda shell.zsh hook"
[[ -x "$(command -v pipx)" ]] && znap eval pipx "register-python-argcomplete pipx"
[[ -x "$(command -v pip)" ]] && znap eval pip 'eval "$(pip completion --zsh)"'
[[ -x "$(command -v poetry)" ]] && znap fpath _poetry 'poetry completions zsh'

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
znap source zsh-users/zsh-autosuggestions  # On same line
znap source zpm-zsh/ls # Use eza for ls
znap source zpm-zsh/autoenv
znap source hlissner/zsh-autopair
znap source MichaelAquilina/zsh-you-should-use
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-completions

# znap eval direnv  "direnv hook zsh"
znap eval zoxide "zoxide init zsh"
znap fpath _fuck "$(thefuck --alias)"
znap source not-poma/lazyshell  # GPT
source $HOME/.config/lf/utils.sh

export EDITOR="nvim"
[[ -v NVIM ]] && EDITOR="nvr -l"
[ -x "$(command -v floaterm)" ] && EDITOR="floaterm"
alias v="$EDITOR" vimdiff="$EDITOR -d"
alias g="git" lg="lazygit"

export BAT_THEME=OneHalfDark
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSOPEN="|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"

export PATH=$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$PATH
export SAVEHIST=2000
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=2000

which sccache > /dev/null && export RUST_WRAPPER=sccache
GO="$HOME/go/bin" && [ -d $GO ] && export PATH="$GO:$PATH"
HASKELL="$HOME/.ghcup/bin" && [ -d $HASKELL ] && export PATH="$HASKELL:$PATH"
export JUPYTER_CONFIG_PATH="~/.config/jupyter/:$JUPYTER_CONFIG_PATH"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line



# Don't let > silently overwrite files. To overwrite, use >! instead.
setopt NO_CLOBBER

# Treat comments pasted into the command line as comments, not code.
setopt INTERACTIVE_COMMENTS

# Don't treat non-executable files in your $path as commands. This makes sure
# they don't show up as command completions. Settinig this option can impact
# performance on older systems, but should not be a problem on modern ones.
setopt HASH_EXECUTABLES_ONLY

# Enable ** and *** as shortcuts for **/* and ***/*, respectively.
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Recursive-Globbing
setopt GLOB_STAR_SHORT

# Sort numbers numerically, not lexicographically.
setopt NUMERIC_GLOB_SORT

precmd() {
  echo -ne "\033]0; $(pwd | sed 's/.*\///')\007"
}

# vim:ft=bash
