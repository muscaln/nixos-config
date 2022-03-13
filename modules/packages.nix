{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "curses";
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [
    chromium
    arduino
    fritzing
    firefox
    discord
    tdesktop
    obs-studio
    meld
    openboard
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
