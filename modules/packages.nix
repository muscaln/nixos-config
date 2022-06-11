{ pkgs, lib, config,... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  services.system-config-printer.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  qt5.platformTheme = "gtk";

  environment.systemPackages = with pkgs; [
    chromium
    arduino
    fritzing
    discord
    tdesktop
    obs-studio
    meld
    openboard
    libreoffice-fresh
    qpdfview
    vlc
    mangohud
    system-config-printer
    pavucontrol
    gparted
    polymc
    handbrake

    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas

    matcha-gtk-theme
    pop-gtk-theme
    papirus-icon-theme 
    (kodi.passthru.withPackages (a: [a.pvr-iptvsimple]))
  ];

}
