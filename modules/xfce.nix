{ pkgs, config, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  
  environment.systemPackages = with pkgs; [
    light-locker
    libsForQt5.qtstyleplugins
  ];

  environment.variables = [
    "QT_STYLE_OVERRIDE" = "gtk2";
    "QT_QPA_PLATFORMTHEME" = "gtk2";
  ];
}
