{ pkgs, config, lib, ... }:

{
  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;
  
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
  
  fonts.fonts = with pkgs; [
    open-sans
    source-code-pro
    noto-fonts
  ];

  fonts.fontconfig.localConf = builtins.readFile ./local.conf;

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
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };                                                                                                                                  
                                                                                                                                       
  services.udev.packages = [ pkgs.android-udev-rules ];                                                                                
                                                                                                                                       
  system.stateVersion = "unstable";

  # printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # touchpad and wacom
  services.xserver.libinput.enable = true;
  services.xserver.wacom.enable = true;

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        matches = [ { "device.name" = "~bluez_card.*"; } ];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            "bluez5.msbc-support" = true;
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          { "node.name" = "~bluez_input.*"; }
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
          "node.pause-on-idle" = false;
        };
      }
    ];
  };
}
