#!/usr/bin/env bash

set -x

cd "$HOME"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

cargo_install_if_missing() {
  command_exists "$1" || cargo install "$2"
}

clone_if_missing() {
  [[ -d "$1" ]] || git clone "$2" "$1"
}

symlink() {
  [[ $(readlink -f "$2") == "$1" ]] || ln -sf "$1" "$2"
}

mkdir -p "$HOME/local/bin"

if [[ $(uname) == "Darwin" ]]; then
  command_exists brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  arch -arm64 brew install \
    bat \
    dust \
    eza \
    fd \
    fzf \
    gh \
    git-delta \
    neovim \
    ripgrep \
    tmux \
    zoxide \
    < /dev/null

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

  [[ -f "$(brew --prefix)"/opt/fzf/install ]] && "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
else
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install -y \
    git \
    neovim \
    tmux

  if command_exists cargo; then
    cargo_install_if_missing bat bat
    cargo_install_if_missing dust du-dust
    cargo_install_if_missing eza eza
    cargo_install_if_missing fd fd-find
    cargo_install_if_missing rg ripgrep
    cargo_install_if_missing zoxide zoxide
    cargo_install_if_missing delta git-delta
  fi

  rm -rf "$HOME/.fzf" && git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" && "$HOME/.fzf/install" --key-bindings --completion --no-update-rc

  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
    sudo apt update &&
    sudo apt install gh -y
fi

[[ -f "$HOME/.vim/autoload/plug.vim" ]] || curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[[ -d "$HOME/.oh-my-zsh" ]] || RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

OMZ_CUSTOM="$HOME/.oh-my-zsh/custom"
clone_if_missing "$OMZ_CUSTOM/plugins/zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
clone_if_missing "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
clone_if_missing "$OMZ_CUSTOM/themes/powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"

mkdir -p "$HOME/.vim/undo"
mkdir -p "$HOME/.config/gh"
mkdir -p "$HOME/.config/bat/themes"
mkdir -p "$HOME/.config/vim"
mkdir -p "$HOME/.config/kitty"

clone_if_missing "$HOME/.config/vim/tokyonight.nvim" "https://github.com/folke/tokyonight.nvim"

DOTFILES="$HOME/dotfiles"
symlink "$DOTFILES/zshrc" "$HOME/.zshrc"
symlink "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
symlink "$DOTFILES/vimrc" "$HOME/.vimrc"
symlink "$DOTFILES/nvim" "$HOME/.config/nvim"
symlink "$DOTFILES/gh/config.yml" "$HOME/.config/gh/config.yml"
symlink "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"
symlink "$DOTFILES/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

cp "$DOTFILES/bat/themes/tokyonight_moon.tmTheme" "$HOME/.config/bat/themes"
cp "$DOTFILES/kitty/tokyonight_moon.conf" "$HOME/.config/kitty"
command_exists bat && bat cache --build

if [[ $(uname) == "Darwin" ]]; then
  mkdir -p "$HOME/Library/KeyBindings"
  symlink "$DOTFILES/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
fi
