{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium                   element-desktop
    firefox                    discord
    tdesktop                   libreoffice-fresh
    evince                     system-config-printer
    vlc                        emacs
    wget                       curl
    nmap                       openboard
    alacritty                  pavucontrol
    arduino

    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    matcha-gtk-theme
    papirus-icon-theme

    (kodi.passthru.withPackages (kodiPkgs: [kodiPkgs.pvr-iptvsimple]))
  ];
}
