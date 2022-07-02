{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
      let
        username = "muscaln";
        mkSystemConfig = device: system: extraModules: nixpkgsPatches: let
          nixpkgsArgs = {
            inherit system;
            config.allowUnfree = true;
          };
          
          patchedPkgs = nixpkgs.legacyPackages.${system}.applyPatches { name = "nixpkgs-patched"; src = nixpkgs; patches = nixpkgsPatches; };
          pkgs = if nixpkgsPatches == [] then import nixpkgs nixpkgsArgs
                                         else import patchedPkgs nixpkgsArgs;

          scripts = pkgs.callPackage ./scripts { inherit device self; };

          in nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit system pkgs; };
            modules = [
              (./hosts/. + "/${device}.nix")

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = {
                  programs.home-manager.enable = true;
                } // { home.packages = [ scripts ]; }
                  // { imports = [ ./home ]; };
              }
            ] ++ extraModules;
          };
      in

      /*
        mkSystemConfig "HOST" "PLATFORM" [ MODULES ] [ NIXPKGS PATCHES ]
      */
      {
        nixosConfigurations."g5070" = mkSystemConfig "g5070" "x86_64-linux"
          [
            ./modules/bluetooth.nix
            ./modules/pipewire.nix
            ./modules/plasma.nix
            ./modules/lightdm.nix
            ./modules/services.nix
            ./modules/packages.nix
          ]
          [ ];    
      };
}
