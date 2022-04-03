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
    "loglevel=2"
    "amdgpu.si_support=1"
    "radeon.si_support=0"
    "modules_blacklist=iTCO_wdt"
    "i915.fastboot=1"
    "mitigations=off"
  ];

  environment.etc."X11/xorg.conf.d/20-intel.conf".text = ''
Section "Device"
    Identifier "Intel Graphics"
    Driver "i915"
    Option "DRI" "3"
    Option "TearFree" "true"
EndSection
  '';

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
      device = "/dev/disk/by-uuid/71c9e1f0-0f14-480a-83c3-995f7b12c621";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/E2CE-535E";
      fsType = "vfat";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/38fb965e-95c1-491a-8398-7b5312d9888a"; } ];
}
