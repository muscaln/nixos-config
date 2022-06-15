{ pkgs, config, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableScreensaver = false;
  };
 
  environment.systemPackages = with pkgs; [
    lightlocker
    libsForQt5.qtstyleplugins
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
  ];

  environment.variables.QT_QPA_PLATFORMTHEME = "gtk2";
}
