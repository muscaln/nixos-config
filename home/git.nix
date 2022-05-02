{ pkgs, ... }:

let
  ghHelper = "!${pkgs.gh}/bin/gh auth git-credential";
in {
  programs.git = {
    enable = true;
    userName = "Mustafa Çalışkan";
    userEmail = "muscaln@protonmail.com";
    signing.key = "53E17A18229A0391";
    signing.signByDefault = true;
    extraConfig = {
      safe.directory = "/home/musfay/nixos-config";
      credential."https://github.com".helper = ghHelper;
      credential."https://gist.github.com".helper = ghHelper;
    };
  };

  programs.gpg.enable = true;
}
