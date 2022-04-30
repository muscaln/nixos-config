{ pkgs, lib, config, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    };

    kernelPackages = pkgs.linuxPackages_xanmod;

    extraModprobeConfig = ''
      options rtl8723be fwlps=0 ant_sel=2
    '';

    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "sr_mod"
      "rtsx_usb_sdmmc"
    ];

    kernelModules = [ "kvm-intel" ];

    kernelParams = [
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
  };

  services.xserver.extraConfig = ''
    Section "Device"
      Identifier "Intel Graphics"
      Driver "intel"
      Option "TearFree" "true"
    EndSection
  '';

  services.xserver.videoDrivers = [
    "intel"
    "amdgpu"
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

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
