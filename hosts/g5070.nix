{ pkgs, lib, config, modulesPath, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };

  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  boot.extraModprobeConfig = ''
    options rtl8723be fwlps=0 ant_sel=2
  '';

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
 
  boot.kernelParams = [
    "nomce"
    "nowatchdog"
    "quiet"
    "loglevel=1"
    "amdgpu.si_support=1"
    "radeon.si_support=0"
    "modules_blacklist=iTCO_wdt"
    "i915.fastboot=1"
    "mitigations=off"
  ];

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # hardware configuration
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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
