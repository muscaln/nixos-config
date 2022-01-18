{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    android-tools
    qdl
    libva-utils
    usbutils
    pciutils
    glxinfo
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
        shell = "${pkgs.zsh}/bin/zsh";
        window.opacity = 0.7;
        font.size = 10.0;
      };
    };

    fish = {
      enable = true;
    };
  };
}
