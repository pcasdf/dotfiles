[[ ! -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] || source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  brew
  docker
  docker-compose
  fd
  fzf
  gcloud
  gh
  git
  gitfast
  node
  npm
  ripgrep
  terraform
  yarn
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
)

[[ ! -f "$ZSH/oh-my-zsh.sh" ]] || source "$ZSH/oh-my-zsh.sh"
[[ ! -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] || source "$HOME/.nix-profile/etc/profile.d/nix.sh"
[[ ! -f "$HOME/.fzf.zsh" ]] || source "$HOME/.fzf.zsh"
[[ ! -e "$HOME/.cargo/env" ]] || source "$HOME/.cargo/env"
[[ ! -f "$HOME"/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:/usr/local/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export BAT_THEME="tokyonight_moon"

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --layout=reverse \
  --ansi \
  --border=rounded \
  --prompt='❯ ' \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
export FZF_CTRL_R_OPTS=""

alias rr="rg --no-heading"
alias gg="git -P grep -n"
alias gs="git status -s"
alias gfop="git fetch origin 'refs/heads/pcho*:refs/remotes/origin/pcho*'"
alias cl="printf '\033[2J\033[3J\033[1;1H'"
alias ls="eza --icons"

setopt no_hist_verify

_nvim() {
  nvim
}

zle -N _nvim

bindkey '^v' _nvim
bindkey "^u" backward-kill-line
bindkey "^]r" fzf-history-widget
bindkey "^[^M" autosuggest-execute
