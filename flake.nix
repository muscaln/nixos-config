{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  
  outputs = inputs@{ self, home-manager, nixpkgs,  ... }:
    let
      system = "x86_64-linux";
      username = "milhan";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
     mkComputer = configurationNix: extraModules: homeModules: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit system inputs pkgs ; };
        modules = [
          configurationNix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.milhan = {
              programs.home-manager.enable = true;
            } // { imports = [ ./home ] ++ homeModules; };
          }
        ] ++ extraModules;
      };
    in

    {
      nixosConfigurations.aichpee = mkComputer
        ./configuration.nix
        [
          ./modules/desktop.nix
          ./modules/services.nix
          ./modules/packages.nix
        ]
        [ ];
    };
}
