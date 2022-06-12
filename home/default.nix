{ pkgs, lib, nix-colors, ... }:

let
  nsWrapper = pkgs.writeScriptBin "nix-shell" ''
    #!${pkgs.runtimeShell}
    export LANG=c
    exec -a "$0" "${pkgs.nixUnstable}/bin/nix-shell"  "$@"
  '';
in {
  imports = [
    ./git.nix
    #./sway.nix
    #./theme.nix
  ];

  home.packages = with pkgs; [
    # tools
    android-tools
    gh
    qdl
    libva-utils
    usbutils
    pciutils
    nsWrapper
    fishPlugins.pure
    glxinfo
    (bootiso.overrideAttrs (oldAttrs: rec {
      patches = [ ./bootiso-syslinux.patch ];
    }))
    nix-prefetch-git
    nixpkgs-review
    gdb
    screen
    neofetch
    
    # development
    python3
    ghc
    nodejs
    go
    rustc
    cargo
  ]; 

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    font_size=16
    position=top-right
  '';

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        rainbow
        vim-nix
        nerdtree
        lightline-vim
        vim-surround
        editorconfig-nvim
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    alacritty = {
      enable = true;
      settings = {
        shell = "${pkgs.fish}/bin/fish";
        window.opacity = 0.95;
        font.size = 9;
        font.normal.family = "Source Code Pro";
        font.normal.style = "Regular";
      };
    };

    chromium = {
      enable = true;
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder"
        "--use-gl=desktop"
        "--enable-accelerated-video-decode"
        "--disable-features=UseChromeOSDirectVideoDecoder"
        "--enable-accelerated-video-encode"
        "--disable-gpu-driver-bug-workarounds"
        "--canvas-oop-rasterization"
        "--disable-gpu-driver-workarounds"
        "--enable-gpu-compositing"
        "--enable-oop-rasterization"
        "--font-render-hinting=slight"
      ];
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fetchFromGitHub {
            owner = "jhillyerd";
            repo = "plugin-git";
            rev = "44a1eb5856cea43e4c01318120c1d4e1823d1e34";
            sha256 = "sha256-A+cw0Rco/3jaFPzijKmHZVNAmFR+p3y/7ig13WYP84Y=";
          }; 
        }
      ];
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
