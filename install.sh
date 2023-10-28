#!/usr/bin/env bash

set -x

cd "$HOME"

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

cargo_install_if_missing() {
	if ! command_exists "$1"; then
		cargo install "$2"
	fi
}

clone_if_missing() {
    if [[ ! -e "$1" ]]; then
        git clone "$2" "$1"
    fi
}

symlink() {
	if [[ ! $(readlink -f "$2") == "$1" ]]; then
		ln -sf "$1" "$2"
	fi
}

mkdir -p "$HOME/local/bin"

if [[ $(uname) == "Darwin" ]]; then
	if ! command_exists brew; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew install \
		bat \
		dust \
		exa \
		fd \
		fzf \
		git-delta \
		gh \
		neovim \
		ripgrep \
		tmux \
		zoxide

	"$(brew --prefix)"/opt/fzf/install
else
	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install -y \
		git \
		neovim \
		tmux

	if command_exists cargo; then
		cargo_install_if_missing bat bat
		cargo_install_if_missing delta git-delta
		cargo_install_if_missing dust du-dust
		cargo_install_if_missing exa exa
		cargo_install_if_missing fd fd-find
		cargo_install_if_missing rg ripgrep
		cargo_install_if_missing zoxide zoxide
	fi

	if ! command_exists fzf; then
		git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
		"$HOME/.fzf/install" --all
	fi

	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
fi

if [[ ! -e "$HOME/.vim/autoload/plug.vim" ]]; then
	curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
	RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

OMZ_CUSTOM="$HOME/.oh-my-zsh/custom"

clone_if_missing "$HOME/.tmux/plugins/tpm" "https://github.com/tmux-plugins/tpm"
clone_if_missing "$OMZ_CUSTOM/themes/powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"
clone_if_missing "$OMZ_CUSTOM/plugins/zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
clone_if_missing "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"

DOTFILES="$HOME/dotfiles"

symlink "$DOTFILES/zshrc" "$HOME/.zshrc"
symlink "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
symlink "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"
symlink "$DOTFILES/vimrc" "$HOME/.vimrc"
symlink "$DOTFILES/nvim" "$HOME/.config/nvim"
