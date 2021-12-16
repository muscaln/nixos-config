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
    shell = "${pkgs.zsh}/bin/zsh";
    window.opacity = 0.7;
    font.size = 10.0;
  };

  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.theme = "robbyrussell";
  programs.zsh.oh-my-zsh.plugins = [ "git" ];

}
