{ pkgs, ...}:

let
  jsonPath = "chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json";
in {
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";

  # make browser integration work
  environment.etc."${jsonPath}".source = "${pkgs.libsForQt5.plasma-browser-integration}/etc/${jsonPath}";
}
