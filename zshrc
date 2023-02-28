# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ( -f ~/.p10k.zsh ) || ( -L ~/.p10k.zsh ) ]] && source ~/.p10k.zsh

plugins=(
  git
  gitfast
  z
  zsh-autosuggestions
)
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# iTerm2
ITERM2_SHELL_FILE=$HOME/.iterm2_shell_integration.zsh
[[ -f $ITERM2_SHELL_FILE ]] && source $ITERM2_SHELL_FILE

# Homebrew
[[ -s /opt/homebrew/opt/nvm/nvm.sh ]] && . /opt/homebrew/opt/nvm/nvm.sh
[[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] && . /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm

# FZF
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# Nix
[[ $- == *i* ]] && source $HOME/.nix-profile/share/fzf/completion.zsh 2> /dev/null
[[ -f $HOME/.nix-profile/share/fzf/key-bindings.zsh ]] && source $HOME/.nix-profile/share/fzf/key-bindings.zsh
[[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]] && source $HOME/.nix-profile/etc/profile.d/nix.sh

[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

bindkey -v

bindkey -M viins '^E' vi-end-of-line
bindkey -M viins '^Y' vi-put-after
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^D' delete-char
bindkey -M viins '^L' clear-screen
bindkey -M viins '^B' backward-char
bindkey -M viins '^F' forward-char
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history

bindkey -M vicmd '^E' vi-end-of-line
bindkey -M vicmd '^Y' vi-put-after
bindkey -M vicmd '^A' vi-beginning-of-line
bindkey -M viins '^U' backward-kill-line
bindkey -M vicmd '^K' kill-line
bindkey -M vicmd '^H' backward-delete-char
bindkey -M vicmd '^W' backward-kill-word
bindkey -M vicmd '^D' delete-char
bindkey -M vicmd '^L' clear-screen
bindkey -M vicmd '^B' backward-char
bindkey -M vicmd '^F' forward-char
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history

function open-nvim {
    nvim
}

zle -N open-nvim

bindkey -M viins '^V' open-nvim
