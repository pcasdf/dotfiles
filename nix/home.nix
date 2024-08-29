{ username, homeDirectory, email, nixDarwin ? false }:

{ config, pkgs, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.file.".config/nvim".source = ../config/nvim;
  home.file.".p10k.zsh".source = ../config/p10k.zsh;
  home.packages = with pkgs; [ zsh-powerlevel10k ];
  home.sessionVariables.EDITOR = "nvim";

  programs.atuin = {
    enable = true;

    settings.inline_height = 24;
  };

  programs.bat = {
    enable = true;

    config.theme = "tokyonight_moon";

    themes = {
      tokyonight_moon = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "b0e7c7382a7e8f6456f2a95655983993ffda745e";
          sha256 = "sha256-Fxakkz4+BTbvDLjRggZUVVhVEbg1b/MuuIC1rGrCwVA=";
        };

        file = "extras/sublime/tokyonight_moon.tmTheme";
      };
    };
  };

  programs.eza.enable = true;
  programs.fd.enable = true;

  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--highlight-line"
      "--layout=reverse"
      "--ansi"
      "--border=rounded"
      "--prompt='❯ '"
      "--color=bg+:#2d3f76"
      "--color=bg:#1e2030"
      "--color=border:#589ed7"
      "--color=fg:#c8d3f5"
      "--color=gutter:#1e2030"
      "--color=header:#ff966c"
      "--color=hl+:#65bcff"
      "--color=hl:#65bcff"
      "--color=info:#545c7e"
      "--color=marker:#ff007c"
      "--color=pointer:#ff007c"
      "--color=prompt:#65bcff"
      "--color=query:#c8d3f5:regular"
      "--color=scrollbar:#589ed7"
      "--color=separator:#ff966c"
      "--color=spinner:#ff007c"
    ];
  };

  programs.gh = {
    enable = true;

    settings = {
      editor = "nvim";
      pager = "less -F";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };

  programs.git = {
    enable = true;

    userName = "Peter Cho";
    userEmail = email;

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.default = "current";
      pull.ff = "only";
      merge.conflictstyle = "diff3";
      merge.ff = "only";
      fetch.prune = true;
    };

    delta = {
      enable = true;

      options = {
        navigate = true;
        syntax-theme = "tokyonight_moon";
        minus-style = "syntax #3a273a";
        minus-non-emph-style = "syntax #3a273a";
        minus-emph-style = "syntax #6b2e43";
        minus-empty-line-marker-style = "syntax #3a273a";
        line-numbers-minus-style = "#e26a75";
        plus-style = "syntax #273849";
        plus-non-emph-style = "syntax #273849";
        plus-emph-style = "syntax #305f6f";
        plus-empty-line-marker-style = "#b8db87";
        line-numbers-zero-style = "#3b4261";
        blame-palette = "#24283b #1f2335 #292e42";
      };
    };
  };

  programs.neovim.enable = true;
  programs.ripgrep.enable = true;

  programs.vim = {
    enable = true;

    extraConfig = ''
      syntax on
      set autoindent
      set cmdheight=1
      set expandtab
      set foldlevel=99
      set foldmethod=indent
      set grepformat=%f:%l:%c:%m
      set grepprg=rg\ --vimgrep
      set hidden
      set hlsearch
      set incsearch
      set ignorecase
      set laststatus=2
      set nowrap
      set shiftwidth=4
      set showcmd
      set smartcase
      set smartindent
      set softtabstop=4
      set tabstop=4
    '';
  };

  programs.yazi = {
    enable = true;

    keymap = {
      manager.prepend_keymap = [{
        on = "<C-t>";
        run = ''shell "$SHELL" --block --confirm'';
        desc = "Open shell here";
      }];
    };
  };

  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;

      plugins = [ "fzf" "gh" "git" "gitfast" "zoxide" ];
    };

    initExtra = ''
      source ~/.p10k.zsh
      ITERM_SHELL_INTEGRATION_INSTALLED=Yes

      dg() {
          rg --json "$@" | delta
      }

      dgp() {
          rg --json "$@" | delta --pager cat
      }

      _nvim() {
        nvim
      }

      zle -N _nvim

      bindkey '^v' _nvim
      bindkey "^u" backward-kill-line
      bindkey "^ " autosuggest-execute
    '';

    initExtraFirst = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]] || source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] || source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    '';

    shellAliases = {
      rr = "rg --no-heading";
      gg = "git -P grep -n";
      gs = "git status -s";
      gfop = "git fetch origin 'refs/heads/pcho*:refs/remotes/origin/pcho*'";
      gstv = "git status -v | delta";
      cl = "printf '\\033[2J\\033[3J\\033[1;1H'";
      ls = "eza";
      l = "eza -la";
    };
  };
} // (if nixDarwin then
  { }
else {
  nix = {
    package = pkgs.nix;

    settings = { "extra-experimental-features" = [ "nix-command" "flakes" ]; };
  };
})

