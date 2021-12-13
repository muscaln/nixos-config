{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    rustc
    cargo
    llvmPackages_latest.clang
    android-tools
    qdl
    nodejs
    bootiso
    gdb
    bootiso
    python3
    ghc
  ]; 

  programs.neovim = {
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

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = 0.7;
    font.size = 10.0;
  };
}
