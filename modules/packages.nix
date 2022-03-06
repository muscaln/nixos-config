{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "curses";

  environment.systemPackages = with pkgs; [
    chromium
    arduino
    fritzing
    firefox
    discord
    tdesktop
    libreoffice-fresh
    qpdfview
    system-config-printer
    vlc
    emacs
    pavucontrol
    gparted
    polymc
   
    (kodi.passthru.withPackages (kodiPkgs: [kodiPkgs.pvr-iptvsimple]))
  ];
}
