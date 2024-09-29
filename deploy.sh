#!/bin/bash

check_default_shell() {
	if [ -z "${SHELL##*zsh*}" ] ;then
			echo "Default shell is zsh."
	else
		echo -n "Default shell is not zsh. Do you want to chsh -s \$(which zsh)? (y/n)"
		old_stty_cfg=$(stty -g)
		stty raw -echo
		answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
		stty "$old_stty_cfg" && echo
		if echo "$answer" | grep -iq "^y" ;then
			chsh -s "$(which zsh)"
		else
			echo "Warning: Your configuration won't work properly. If you exec zsh, it'll exec tmux which will exec your default shell which isn't zsh."
		fi
	fi
}

echo "1. install HomeBrew package manager."
echo "2. install various other software."
echo "3. Make default shell to be zsh."
echo "Let's get started? (y/n)"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty "$old_stty_cfg"
if echo "$answer" | grep -iq "^y" ;then
	echo
else
	echo "Quitting, nothing was changed."
	exit 0
fi

###### HOMEBREW ############
echo "Installed homebrew if not already."
if ! [ -x "brew" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
###########################


brew install starship
brew install bat
brew install eza
brew install git-delta
brew tap tgotwig/linux-dust & brew install dust
brew install duf
brew install ripgrep
brew install thefuck
brew install fd
brew tap cantino/mcfly & brew install mcfly
brew install zoxide
brew install neovim
brew install lazygit
brew install lf
brew install btop
brew install direnv
brew install amethyst
brew install stats

check_default_shell


echo
echo -n "Would you like to backup your current dotfiles? (y/n) "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
	mv ~/.zshrc ~/.zshrc.old
	mv ~/.tmux.conf ~/.tmux.conf.old
	mv ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py.old
else
	echo -e "\nNot backing up old dotfiles."
fi

mkdir ~/.ipython/profile_default/ -p && ln -s ~/.config/ipython_config.py ~/.ipython/profile_default/ipython_config.py
printf "source '$HOME/.config/zsh/zshrc.zsh'" >> "$HOME"/.zshrc

echo
echo "Please log out and log back in for default shell to be initialized."
