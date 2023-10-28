if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  fancy-ctrl-z
  fd
  gh
  git
  gitfast
  ripgrep
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
)

PROMPT=$'%F{cyan}%~%f %F{yellow}$(git_current_branch)%f\n$ '

export EDITOR="nvim"
export VISUAL="nvim"
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export COLORTERM="truecolor"
export BAT_THEME="TokyoNight"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --no-ignore --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="
  --cycle
  --layout=default
  --preview='if [[ -f {1} ]]; then bat --color=always --style=numbers --line-range=:500 {}; else exa --tree {}; fi'
  --bind='ctrl-e:become(nvim {+} < /dev/tty > /dev/tty)'
  --bind='ctrl-r:reload(echo {+} | tr \" \" \"\n\")+clear-query+first'
  --bind='ctrl-t:toggle-preview'
  --bind='ctrl-o:toggle-all'
  --bind='ctrl-f:page-down'
  --bind='ctrl-b:page-up'
  --bind='ctrl-d:preview-page-down'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-h:change-prompt(F> )+reload(fd --type file --hidden --no-ignore --exclude .git --exclude node_modules)'
  --bind='ctrl-l:change-prompt(D> )+reload(fd --type directory --hidden --no-ignore --exclude .git --exclude node_modules)'
  --color='fg:#c0caf5,fg+:#c0caf5'
  --color='bg:-1,bg+:#2e3c64'
  --color='hl:#2ac3de,hl+:#2ac3de'
  --color='info:#7aa2f7,prompt:#7dcfff'
  --color='pointer:#2ac3de,spinner:#9ece6a'
  --color='marker:#9ece6a,header:#9ece6a'
"
export FZF_CTRL_T_OPTS=""
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window=hidden
"
export FZF_ALT_C_OPTS=""

_fzf_compgen_path() {
  fd --hidden --no-ignore --follow --exclude ".git" --exclude "node_modules" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --no-ignore --follow --exclude ".git" --exclude "node_modules" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --preview 'exa --tree {}' "$@" ;;
    *) fzf --preview 'if [[ -f {1} ]]; then bat --color=always --style=numbers --line-range=:500 {}; else exa --tree {}; fi' "$@" ;;
  esac
}

if [[ -e "$HOME/.deno" ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$PATH:$DENO_INSTALL/bin"
fi

if command -v github-copilot-cli >/dev/null 2>&1; then
  eval "$(github-copilot-cli alias -- "$0")"
fi

[[ -f "$ZSH/oh-my-zsh.sh" ]] && . "$ZSH/oh-my-zsh.sh"
[[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
[[ -f "$HOME/.fzf.zsh" ]] && . "$HOME/.fzf.zsh"
[[ -e "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

_nvim() {
  nvim
}

zle -N _nvim

bindkey '^V' _nvim
bindkey '^U' backward-kill-line
bindkey '^ ' autosuggest-execute
bindkey '^[[13;5u' autosuggest-execute
bindkey '^G' vi-cmd-mode

alias cat='bat --style=plain'
alias ls='exa'
alias l='exa -al'
