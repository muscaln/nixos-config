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
      credential."https://github.com".helper = ghHelper;
      credential."https://gist.github.com".helper = ghHelper;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs.gpg.enable = true;
}
