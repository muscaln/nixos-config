{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium                   element-desktop
    firefox                    discord
    tdesktop                   libreoffice-fresh
    evince                     system-config-printer
    vlc                        emacs
    wget                       curl
    nmap                      
  
    (kodi.passthru.withPackages (kodiPkgs: [kodiPkgs.pvr-iptvsimple]))
  ];
}
