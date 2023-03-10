
. "$HOME/.cargo/env"

export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_COMMAND='fd --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--reverse"
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export PATH="$PATH:$HOME/bin:$HOME/discord/.local/bin"
export BAT_THEME="Nord"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#c8d0e0,bg:-1,hl:#ebcb8b
--color=fg+:#c8d0e0,bg+:#3f4758,hl+:#ebcb8b
--color=info:#b988b0,prompt:#b988b0,pointer:#b988b0
--color=marker:#ebcb8b,spinner:#ebcb8b,header:#ebcb8b'


if [[ -e $HOME/.deno ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
