{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    android-tools
    qdl
    libva-utils
    usbutils
    pciutils
    glxinfo
    any-nix-shell
    (bootiso.overrideAttrs (oldAttrs: rec {
      patches = [ ./bootiso-syslinux.patch ];
    }))
    nix-prefetch-git
    nixpkgs-review
    gdb
    screen
    neofetch
    python3
    ghc
    nodejs
    go
    fishPlugins.pure
  ]; 

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = (with pkgs.vscode-extensions; [
        bbenoist.nix
        arrterian.nix-env-selector
        ms-python.python
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "vscode-language-pack-tr";
        publisher = "MS-CEINTL";
        version = pkgs.vscodium.version;
        sha256 = "sha256-gh6CJ+56fijEVryLWp2b8OjkF6T6whT334VXXK3+G6M=";
      }]);
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        rainbow
        vim-nix
        nerdtree
        lightline-vim
        vim-surround
        editorconfig-nvim
      ];
    };

    alacritty = {
      enable = true;
      settings = {
        shell = "${pkgs.fish}/bin/fish";
        window.opacity = 0.8;
        font.size = 10.5;
        font.normal.family = "Source Code Pro";
        font.normal.style = "Regular";
      };
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fetchFromGitHub {
            owner = "jhillyerd";
            repo = "plugin-git";
            rev = "44a1eb5856cea43e4c01318120c1d4e1823d1e34";
            sha256 = "sha256-A+cw0Rco/3jaFPzijKmHZVNAmFR+p3y/7ig13WYP84Y=";
          }; 
        }
      ];
      shellInit = ''
        any-nix-shell fish --info-right | source
      '';
    };
  };
}
