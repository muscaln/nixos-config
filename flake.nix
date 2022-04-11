{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
      let
        username = "musfay";
        mkSystemConfig = device: system: extraModules: homeModules: nixpkgsPatches: let
          nixpkgsArgs = {
            inherit system;
            config.allowUnfree = true;
          };
          
          patchedPkgs = (import nixpkgs nixpkgsArgs).applyPatches { name = "nixpkgs-patched"; src = nixpkgs; patches = nixpkgsPatches; };
          pkgs = if nixpkgsPatches == [] then import nixpkgs nixpkgsArgs
                                         else import patchedPkgs nixpkgsArgs;

          scripts = pkgs.callPackage ./scripts { inherit device self; };

          in nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit system inputs pkgs; };
            modules = [
              (./hosts/. + "/${device}.nix")

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = {
                  programs.home-manager.enable = true;
                } // { home.packages = [ scripts ]; }
                  // { imports = [ ./home ] ++ homeModules; };
              }
            ] ++ extraModules;
          };
      in

      /*
        mkSystemConfig "HOST" "PLATFORM" [ MODULES ] [ HOME-MANAGER MODULES ] [ NIXPKGS PATCHES ]
      */
      {
        nixosConfigurations."g5070" = mkSystemConfig "g5070" "x86_64-linux"
          [
            ./modules/plasma.nix
            ./modules/services.nix
            ./modules/packages.nix
          ]
          [
            ./home/git.nix
          ]
          [
            (builtins.fetchurl {
              url = "https://github.com/NixOS/nixpkgs/commit/7f8c513362f84e1763b386f005e6c1f59f3f0679.patch";
              sha256 = "0cxyx05vq6c0c1ghqa2wkhn0cwji0z187zd3kvb9yr7yafpd1k81";
            })
          ];    
      };
}
