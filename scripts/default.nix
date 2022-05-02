{ pkgs, device, self }:

let
  rebuildSystem = pkgs.writeScriptBin "rebuildSystem" ''
    #!${pkgs.runtimeShell}

    echo 'Rebuilding config "${device}" ...'

    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake \
    $(${pkgs.nixUnstable}/bin/nix flake archive $HOME/.nixos --json | ${pkgs.jq}/bin/jq -r .path)#${device}
  '';

in pkgs.symlinkJoin {
  name = "scripts";
  paths = [
    rebuildSystem
  ];
}
