{
  description = "System flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  
  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
      let
        system = "x86_64-linux";
        username = "musfay";
        device = "g5070";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        
        updateHardwareConfig = pkgs.writeScriptBin "updateHardwareConfig" ''
          if [ [$(${pkgs.git}/bin/git diff --stat) != "" ]]; then
            echo "Tree is dirty. Aborting."
          else
            export root=/
            [ -d "/mnt/boot" ] && export root=/mnt
            ${pkgs.nixos-install-tools}/bin/nixos-generate-config \
              --dir ./modules/ --root $root
            rm modules/configuration.nix
            git add modules/hardware-configuration.nix
            git commit -m "updateHardwareConfig: changes"
          fi
        '';

        rebuildSystem = pkgs.writeScriptBin "rebuildSystem" ''
          echo 'Rebuilding config "${device}" ...'
          sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake .#${device}
        '';

        bumpFlake = pkgs.writeScriptBin "bumpFlake" ''
          if [ "$(${pkgs.git}/bin/git diff --stat)" != "" ]; then
            echo "Tree is dirty. Aborting."
          else
            ${pkgs.nixUnstable}/bin/nix flake update
            git add flake.lock
            git commit -m "bumpFlake: update flake.lock"
          fi
        '';
        
        devshell = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            updateHardwareConfig
            rebuildSystem
            bumpFlake
          ];
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
        nixosConfigurations."${device}" = mkComputer
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
        
        devShell.${system} = devshell;
      };
}
