{ pkgs , ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      rainbow
      vim-nix
      vim-go
      emmet-vim
      vim-javascript-syntax
      rust-vim
      jedi-vim
      nerdtree
      lightline-vim
      vim-surround
      editorconfig-nvim
    ];

    withPython3 = true;

    extraConfig = ''
      set encoding=utf-8
      set fileencoding=utf-8
      set fileencodings=utf-8
      set ttyfast
      set fileformats=unix,dos,mac
      syntax on
      set ruler
      set number
      set mouse=a
      set mousemodel=popup
    '';
  };
}
