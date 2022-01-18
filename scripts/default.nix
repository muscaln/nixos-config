{ pkgs, device }:

let
  updateHardwareConfig = pkgs.writeScriptBin "updateHardwareConfig" ''
    if [ [$(${pkgs.git}/bin/git diff --stat) != "" ]]; then
      echo "Tree is dirty. Aborting."
    else
      export root=/
      [ -d "/mnt/boot" ] && export root=/mnt
      ${pkgs.nixos-install-tools}/bin/nixos-generate-config \
        --dir ./modules/ --root $root
      rm modules/configuration.nix
      git add modules/hardware-configuration.nix
      git commit -m "updateHardwareConfig: changes"
    fi
  '';

  rebuildSystem = pkgs.writeScriptBin "rebuildSystem" ''
    echo 'Rebuilding config "${device}" ...'
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake .#${device}
  '';

  bumpFlake = pkgs.writeScriptBin "bumpFlake" ''
    if [ "$(${pkgs.git}/bin/git diff --stat)" != "" ]; then
      echo "Tree is dirty. Aborting."
    else
      ${pkgs.nixUnstable}/bin/nix flake update
      git add flake.lock
      git commit -m "bumpFlake: update flake.lock"
    fi
  '';

in pkgs.mkShell {
  name = "config-env";
  buildInputs = [
    updateHardwareConfig
    rebuildSystem
    bumpFlake
    pkgs.git
  ];
}
