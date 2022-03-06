{ pkgs, config, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  
  environment.systemPackages = with pkgs; [
    lightlocker
    libsForQt5.qtstyleplugins
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    matcha-gtk-theme
    papirus-icon-theme
  ];

  environment.variables = {
    QT_STYLE_OVERRIDE = "gtk2";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };
}
