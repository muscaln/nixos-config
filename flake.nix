{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
      let
        system = "x86_64-linux";
        username = "musfay";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.packageOverrides = pkgs: {
            vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
          };
        };
        
        mkSystemConfig = device: configurationNix: extraModules: homeModules: let
          scripts = pkgs.callPackage ./scripts { inherit device self; };
          in nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit system inputs pkgs; };
            modules = [
              configurationNix

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

      {
        nixosConfigurations."g5070" = mkSystemConfig "g5070"
          ./configuration.nix
          [
            ./modules/plasma.nix
            ./modules/services.nix
            ./modules/hardware-configuration.nix
            ./modules/packages.nix
          ]
          [
            ./home/git.nix
          ];
      };
}
