{ pkgs, lib, config, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
 
  hardware.cpu.intel.updateMicrocode = true;
  
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

  networking.networkmanager.enable = true;

  fonts.fonts = with pkgs; [
    open-sans
    source-code-pro
    noto-fonts
  ];

  services.xserver.layout = "tr";
  i18n.defaultLocale = "tr_TR.UTF-8";
  time.timeZone = "Europe/Istanbul";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };


  users.users.musfay = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    initialPassword = "123456";  
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  services.udev.packages = [ pkgs.android-udev-rules ];

  system.stateVersion = "unstable";
}
