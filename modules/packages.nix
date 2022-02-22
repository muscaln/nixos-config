{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "curses";

  environment.systemPackages = with pkgs; [
    chromium                   arduino
    firefox                    discord
    tdesktop                   libreoffice-fresh
    qpdfview                   system-config-printer
    vlc                        emacs
    wget                       curl
    nmap                       evince
    pavucontrol                gparted
    polymc
    
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    matcha-gtk-theme
    adapta-gtk-theme
    orchis-theme
    papirus-icon-theme

    (kodi.passthru.withPackages (kodiPkgs: [kodiPkgs.pvr-iptvsimple]))
  ];
}
