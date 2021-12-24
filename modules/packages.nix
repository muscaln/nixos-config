{ pkgs, ... }:

{
  programs.steam.enable = true;
  
  environment.systemPackages = with pkgs; [
    firefox                    discord
    tdesktop                   libreoffice-fresh
    evince                     system-config-printer
    vlc                        chromium
    wget                       curl
    arduino

    matcha-gtk-theme
    papirus-icon-theme

    (kodi.passthru.withPackages (kodiPkgs: [kodiPkgs.pvr-iptvsimple]))
  ];
}
