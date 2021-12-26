{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  
  outputs = inputs@{ self, home-manager, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        username = "musfay";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      
        devshell = pkgs.mkShell {
          buildInputs = [ scripts ];
        };

        mkComputer = configurationNix: extraModules: homeModules: nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit system inputs pkgs; };
          modules = [
            configurationNix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.musfay = {
                programs.home-manager.enable = true;
              } // { imports = [ ./home ] ++ homeModules; };
            }
          ] ++ extraModules;
        };
      in

      {
        nixosConfigurations.g5070 = mkComputer
          ./configuration.nix
          [
            ./modules/xfce.nix
            ./modules/services.nix
            ./modules/hardware-configuration.nix
            ./modules/packages.nix
          ]
          [
          ./home/git.nix
          ];
        
        devShell = devshell;
      })
}
