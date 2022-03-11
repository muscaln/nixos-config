{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    android-tools
    gh
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
    rustc
    cargo
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
      ]);
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
      shellAliases = {
        nshell = "LANG=c nix-shell -p"; # Otherwise it tries to export RANLİB=ranlib
      };
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
    };
  };
}
