{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Mustafa Çalışkan";
    userEmail = "musfay@protonmail.com";
  };

  programs.gh.enable = true;
  programs.gh.enableGitCredentialHelper = true;
}
