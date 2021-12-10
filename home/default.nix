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
}
