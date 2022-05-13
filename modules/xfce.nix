{ pkgs, config, lib, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x8/wallhaven-x8ye3z.jpg";
    sha256 = "0b89cgbkadbs1by07jmq0f22sc0vlsdicbil9zi26mvmn5v6dk3r";
  };
in {
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      theme.package = pkgs.matcha-gtk-theme;
      theme.name = "Adwaita-dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "Matcha-dark-azul";
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

  environment.variables.QT_QPA_PLATFORMTHEME = "gtk2";
}
