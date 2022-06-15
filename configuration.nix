{ pkgs, lib, config, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  boot.kernelParams = [
    "quiet"
    "loglevel=2"
    "i915.fastboot=1"
    "i915.force_probe=4e55"
  ];

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

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

  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
}
