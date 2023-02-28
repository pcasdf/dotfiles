
. "$HOME/.cargo/env"

export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_COMMAND='fd --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export PATH="$PATH:$HOME/bin:$HOME/discord/.local/bin"
export BAT_THEME="TwoDark"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
--color=fg:#abb2bf,bg:-1,hl:#e5c07b
--color=fg+:#abb2bf,bg+:#393f4a,hl+:#e5c07b
--color=info:#98c379,prompt:#98c379,pointer:#e5c07b
--color=marker:#e5c07b,spinner:#e5c07b,header:#e5c07b'


if [[ -e $HOME/.deno ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
