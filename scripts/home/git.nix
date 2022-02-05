{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Mustafa Çalışkan";
    userEmail = "muscaln@protonmail.com";
    signing.key = "65A4189BDDE655E0";
    signing.signByDefault = true;
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    settings.editor = "vim";
  };

  programs.gpg.enable = true;
}
