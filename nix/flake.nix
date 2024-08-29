{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      standalone = {
        petercho = {
          username = "petercho";
          homeDirectory = "/Users/petercho";
          system = "aarch64-darwin";
          email = "peter.cho@discordapp.com";
        };

        "peter.cho" = {
          username = "peter.cho";
          homeDirectory = "/Users/peter.cho";
          system = "aarch64-darwin";
          email = "peter.cho@discordapp.com";
        };

        pcho = {
          username = "pcho";
          homeDirectory = "/home/pcho";
          system = "x86_64-linux";
          email = "peter.cho@discordapp.com";
        };

        discord = {
          username = "discord";
          homeDirectory = "/home/discord";
          system = "x86_64-linux";
          email = "peter.cho@discordapp.com";
        };
      };

      mkHomeConfig = name: user:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${user.system};
          modules = [
            (import ./home.nix { inherit (user) username homeDirectory email; })
          ];
        };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#petercho-mba
      darwinConfigurations."petercho-mba" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.petercho = import ./home.nix {
              username = "petercho";
              homeDirectory = "/Users/petercho";
              email = "pcho51990@gmail.com";
              nixDarwin = true;
            };
          }
        ];
      };

      darwinPackages = self.darwinConfigurations."petercho-mba".pkgs;

      homeConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames standalone)
        (name: mkHomeConfig name (standalone.${name}));
    };
}
