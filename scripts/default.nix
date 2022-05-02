{ pkgs, device, self }:

let
  updateHardwareConfig = pkgs.writeScriptBin "updateHardwareConfig" ''
    #!${pkgs.runtimeShell}

    if [ [$(${pkgs.git}/bin/git diff --stat) != "" ]]; then
      echo "Tree is dirty. Aborting."
    else
      export root=/
      [ -d "/mnt/boot" ] && export root=/mnt
      ${pkgs.nixos-install-tools}/bin/nixos-generate-config \
        --root $root
      ${pkgs.coreutils}/bin/mv $root/etc/nixos/hardware-configuration.nix \
        modules/hardware-configuration.nix
      ${pkgs.git}/bin/git add modules/hardware-configuration.nix
      ${pkgs.git}/bin/git commit -m "updateHardwareConfig: changes"
    fi
  '';

  rebuildSystem = pkgs.writeScriptBin "rebuildSystem" ''
    #!${pkgs.runtimeShell}
    echo 'Rebuilding config "${device}" ...'
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake $HOME/.nixos#${device}
  '';

in pkgs.symlinkJoin {
  name = "scripts";
  paths = [
    updateHardwareConfig
    rebuildSystem
  ];
}
