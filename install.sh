#!/bin/bash

set -x

cd $HOME

if [[ $(uname) == "Darwin" ]]; then
	if ! which brew; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew install \
		ripgrep \
		fzf \
		fd \
		tmux \
		gnupg \
		httpie \
		mtr \
		tree \
		bat

    brew install --HEAD neovim
else
	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install -y \
		tmux \
		neovim \
		httpie \
		python3-venv \
		mtr \
		tree

	function dpkg_release() {
		if ! which $1; then
			curl -LO $2
			sudo dpkg -i $3*
			rm $3*
		fi
	}

	dpkg_release rg https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb ripgrep_13
	dpkg_release fd https://github.com/sharkdp/fd/releases/download/v8.4.0/fd_8.4.0_amd64.deb fd_8
	dpkg_release bat https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-musl_0.21.0_amd64.deb bat-musl

	if ! which fzf; then
		git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
		$HOME/.fzf/install --all
	fi

	if [[ ! -f $HOME/local/bin/tmux ]]; then
		curl -LO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
		curl -LO https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz
		curl -LO https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz

		tar -zxf libevent-*.tar.gz
		tar -zxf ncurses-*.tar.gz
		tar -zxf tmux-*.tar.gz

		cd $HOME/libevent-*/
		./configure --prefix=$HOME/local --enable-shared
		make && make install

		cd $HOME/ncurses-*/
		./configure --prefix=$HOME/local --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$HOME/local/lib/pkgconfig
		make && make install

		cd $HOME/tmux-*/
		PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig ./configure --prefix=$HOME/local
		make && make install

		cd $HOME
		rm -r libevent-* ncurses-* tmux-*

	fi

	[[ ! -e /usr/lib/libevent_core-2.1.so.7 ]] && sudo cp local/lib/libevent_core-2.1.so.7 /usr/lib/
	[[ ! -e /usr/lib/libtinfo.so.6 ]] && sudo cp local/lib/libtinfo.so.6 /usr/lib/
	if [[ ! -e $HOME/.iterm2_shell_integration.zsh ]]; then
		curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
	fi
fi

if [[ ! -e $HOME/.vim/autoload/plug.vim ]]; then
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ ! -e $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

if [[ ! -e $HOME/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

OMZ_CUSTOM=$HOME/.oh-my-zsh/custom
if [[ ! -e $OMZ_CUSTOM/plugins/zsh-autosuggestions ]]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $OMZ_CUSTOM/plugins/zsh-autosuggestions
fi

if [[ ! -e $OMZ_CUSTOM/themes/powerlevel10k ]]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $OMZ_CUSTOM/themes/powerlevel10k
fi

function symlink() {
	if [[ ! $(readlink -f "$2") == "$1" ]]; then
		ln -sf "$1" "$2"
	fi
}

DOTFILES=$HOME/dotfiles

symlink "$DOTFILES/zshrc" "$HOME/.zshrc"
symlink "$DOTFILES/zshenv" "$HOME/.zshenv"
symlink "$DOTFILES/karabiner" "$HOME/.config/karabiner"
symlink "$DOTFILES/yabai" "$HOME/.config/yabai"
symlink "$DOTFILES/nvim" "$HOME/.config/nvim"
symlink "$DOTFILES/vimrc" "$HOME/.vimrc"
symlink "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
symlink "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
symlink "$DOTFILES/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
symlink "$DOTFILES/gitconfig" "$HOME/.gitconfig"
symlink "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"

if [[ ! -d $HOME/bin ]]; then
	mkdir -p $HOME/bin
fi

symlink "$DOTFILES/gls" "$HOME/bin/gls"

if [[ $USER == "peter.cho" ]]; then
	symlink $DOTFILES/ssh/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
fi

if [[ $USER == "pcho" ]]; then
	git config --global user.email "pcho51990@gmail.com"
fi
