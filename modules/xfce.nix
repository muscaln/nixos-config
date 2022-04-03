{ pkgs, config, lib, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/8o/wallhaven-8ok7vk.jpg";
    sha256 = "sha256-sfMyfE6eo5QiTDJR0ETl7u9x4Gv0PWaiXV48fSrDac0=";
  };
in {
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      theme.package = pkgs.gnome-themes-extra;
      theme.name = "Adwaita-dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "Papirus-Dark";
      extraConfig = ''
        font-name=Open Sans Regular 10
        background=${wallpaper}
        position=140,start 50%,center
        xft-antialias=true
        xft-hintstyle=hintslight
        clock-format=%H:%M
        indicators=~spacer;~clock;~spacer;separator;~session;~a11y;~power;
      '';
    };  
  };
  
  environment.systemPackages = with pkgs; [
    lightlocker
    libsForQt5.qtstyleplugins
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
  ];

  environment.variables = {
    QT_STYLE_OVERRIDE = "gtk2";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };
}
