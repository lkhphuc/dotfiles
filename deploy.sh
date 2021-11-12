prompt_install() {
	echo -n "$1 is not installed. Would you like to install it? (y/n) " >&2
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg && echo
	if echo "$answer" | grep -iq "^y" ;then
		if [ -x "$(command -v apt-get)" ]; then
			sudo add-apt-repository $2
			sudo apt update
			sudo apt install $1 -y

		elif [ -x "$(command -v brew)" ]; then
			brew install $1

		elif [ -x "$(command -v pacman)" ]; then
			sudo pacman -S $1

		else
			echo "Package manager not detected! Please install $1 on your own and run this deploy script again. Feel free to make a pull request at https://github.com/lkhphuc/dotfiles :)"
		fi
	fi
}

check_for_software() {
	echo "Checking to see if $1 is installed"
	if ! [ -x "$(command -v $1)" ]; then
		prompt_install $2
	else
		echo "$1 is installed."
	fi
	echo
}

check_default_shell() {
	if [ -z "${SHELL##*zsh*}" ] ;then
			echo "Default shell is zsh."
	else
		echo -n "Default shell is not zsh. Do you want to chsh -s \$(which zsh)? (y/n)"
		old_stty_cfg=$(stty -g)
		stty raw -echo
		answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
		stty $old_stty_cfg && echo
		if echo "$answer" | grep -iq "^y" ;then
			chsh -s $(which zsh)
		else
			echo "Warning: Your configuration won't work properly. If you exec zsh, it'll exec tmux which will exec your default shell which isn't zsh."
		fi
	fi
}

echo "We're going to do the following:"
echo "1. Check to make sure you have zsh, neovim, and tmux installed"
echo "2. We'll help you install them if you don't"
echo "3. We're going to check to see if your default shell is zsh"
echo "4. We'll try to change it if it's not"

echo "Let's get started? (y/n)"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
	echo
else
	echo "Quitting, nothing was changed."
	exit 0
fi


check_for_software zsh
# check_for_software tmux
check_for_software nvim neovim ppa:neovim-ppa/unstable
check_for_software lazygit lazygit ppa:lazygit-team/release
check_for_software rg ripgrep
check_for_software thefuck thefuck
check_for_software fd fd
check_for_software bat bat
check_for_software lf lf
check_for_software exa exa

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
	mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old
else
	echo -e "\nNot backing up old dotfiles."
fi

echo "Installing Lunarvim"
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)

printf "source '$HOME/.config/zsh/zshrc'" > $HOME/.zshrc

echo
echo "Please log out and log back in for default shell to be initialized."
