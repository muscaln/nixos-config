{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Open Sans";
      size = 10;
    };
    iconTheme.name = "Papirus-Dark";
    theme.name = "Matcha-dark-azul";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.package = pkgs.libsForQt5.qtstyleplugins;
  };
}
