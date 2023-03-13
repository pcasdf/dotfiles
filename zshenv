
. "$HOME/.cargo/env"

export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_COMMAND='fd --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--reverse"
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export PATH="$PATH:$HOME/bin:$HOME/discord/.local/bin"
export BAT_THEME="TokyoNight"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#c0caf5,bg:-1,hl:#2ac3de
--color=fg+:#c0caf5,bg+:#2e3c64,hl+:#2ac3de
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#2ac3de
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'


if [[ -e $HOME/.deno ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
