{ pkgs, lib, config, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModprobeConfig = ''
    options rtl8723be fwlps=0 ant_sel=2
  '';
  
  hardware.enableRedistributableFirmware = true;
  
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot.kernelParams = [
    "nomce"
    "nowatchdog"
    "quiet"
    "loglevel=2"
    "amdgpu.si_support=1"
    "radeon.si_support=0"
    "modules_blacklist=iTCO_wdt"
    "i915.fastboot=1"
    "mitigations=off"
  ];

  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
}
