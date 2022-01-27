{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Mustafa Çalışkan";
    userEmail = "muscaln@protonmail.com";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = true;
    editor = "vim";
  };

  programs.gpg.enable = true;
}
