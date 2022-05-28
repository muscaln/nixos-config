{ pkgs, config, lib, ... }:

let
  background = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x8/wallhaven-x8ye3z.jpg";
    sha256 = "0b89cgbkadbs1by07jmq0f22sc0vlsdicbil9zi26mvmn5v6dk3r";
  };
in

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec dmenu_run -b";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+a" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "Print" = "exec grim - | wl-copy -t image/png";
        "Shift+Print" = "exec grim -g \"$(slurp)\" - | wl-copy -t image/png";

        "XF86AudioMute" = "exec pamixer -t";
        "XF86AudioRaiseVolume" = "exec pamixer -i 5";
        "XF86AudioLowerVolume" = "exec pamixer -d 5";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaymsg exit";

        "${modifier}+l" = "exec swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2";
        "${modifier}+r" = "mode resize";
      };

      fonts = {
        names = [ "FontAwesome" "Source Code Pro" ];
        style = "Regular";
        size = 10.0;
      };

      gaps = {
        inner = 10;
        outer = 5;
      };

     input = {
        "*" = {
          xkb_layout = "tr";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:touchpad" = {
          tap = "enabled";
        };
      };

      output = {
        "*" = {
          bg = "${background} fill";
        };
      };

      bars = [{
        command = "waybar";
      }];
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 15;

        output = [ "eDP-1" ];

        modules-left = [ "sway/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "network" "battery" ];

        modules = {
          battery = {
            format = "{icon}";
            format-alt = "{power:.2} W {capacity}% {time} {icon}";
            format-charging = "{icon}󰉁";
            format-icons = ["" "" "" "" "" "" "" "" "" ""];
            format-plugged = "{capacity}%󰚥";
            interval = 2;
            states = {
              critical = 15;
              warning = 30;
            };
          };

          clock.format = "{:%e %b %H:%M}";

          network = {
            interval = 1;
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-disconnected = "Disconnected 󰀨";
            format-ethernet = "󰇧 {ifname} 󰁞 {bandwidthUpBits} 󰁆 {bandwidthDownBits}";
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-linked = "{ifname} (No IP) 󰀨";
            format-wifi = "{icon}";
          };

          pulseaudio = {
            format = "{icon} {volume}% {format_source}";
            format-muted = "󰖁 {format_source}";
            format-bluetooth = "{icon} {volume}% {format_source}";
            format-bluetooth-muted = "󰖁 {icon} {format_source}";
            format-icons = {
              car = "";
              default = ["󰕿" "󰖀" "󰕾"];
              hands-free = "";
              headphone = "󰋋";
              headset = "";
              phone = "󰏲";
              portable = "󰏲";
            };
            format-source = "󰍬";
            format-source-muted = "󰍭";
            on-click = "pavucontrol";
          };
        };
      }
    ];

    style = ./style.css;
  };
}
