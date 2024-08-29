# dotfiles

## Install nix

Darwin:
`$ sh <(curl -L https://nixos.org/nix/install)`

Linux:
`sh <(curl -L https://nixos.org/nix/install) --daemon`

## Install home manager

`nix run home-manager/release-24.05 -- init --switch`

## Rebuild home manager

`home-manager switch`

## Install nix-darwin

`nix run nix-darwin -- switch --flake ~/dotfiles/nix`

## Rebuild nix-darwin
`darwin-rebuild switch --flake ~/dotfiles/nix`
