{ pkgs, lib, config,... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "curses";
  services.flatpak.enable = true;
  services.system-config-printer.enable = lib.mkIf config.services.xserver.desktopManager.xfce.enable true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = lib.mkIf
    config.services.xserver.desktopManager.xfce.enable ([ pkgs.xdg-desktop-portal-gtk ]);

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
    pavucontrol
    gparted
    polymc
    handbrake

    matcha-gtk-theme
    pop-gtk-theme
    papirus-icon-theme 
    (kodi.passthru.withPackages (a: [a.pvr-iptvsimple]))
  ];
}
