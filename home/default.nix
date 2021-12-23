{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    android-tools
    qdl
    (bootiso.overrideAttrs (oldAttrs: rec {
      patches = [ ./bootiso-syslinux.patch ];
    }))
    gdb
    screen
    python3
    ghc
    nodejs
    go
  ]; 

  programs = {
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

    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.theme = "robbyrussell";
      oh-my-zsh.plugins = [ "git" ];
    };
  };
}
