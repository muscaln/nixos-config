{ pkgs, lib, config, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable =
    (!config.services.xserver.desktopManager.plasma5.enable);
}
