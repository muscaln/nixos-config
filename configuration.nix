{ pkgs, lib, config, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
  boot.blacklistedKernelModules = [ "rtw88_8821ce" ];
  
  hardware.cpu.intel.updateMicrocode = true;
  
  boot.kernelParams = [
    "quiet"
    "loglevel=2"
    "i915.fastboot=1"
    "i915.force_probe=4e55"
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


  users.users.milhan = {
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
