{ pkgs, config, lib, ... }:

{
  fonts.fonts = with pkgs; [
    open-sans
    source-code-pro
    noto-fonts
    font-awesome
  ];

  fonts.fontconfig.localConf = builtins.readFile ./local.conf;

  services.xserver.layout = "tr";
  i18n.defaultLocale = "tr_TR.UTF-8";
  time.timeZone = "Europe/Istanbul";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };

  users.users.muscaln = {
    description = "Mustafa Çalışkan";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "video" "wheel" "dialout" ];
    initialPassword = "123456";
  };

  nix = {
    package = pkgs.nixVersions.unstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
                                                                
  services.udev.packages = [ pkgs.android-udev-rules ];                                                                                
  system.stateVersion = "unstable";

  # printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];
  services.system-config-printer.enable = true;
}
