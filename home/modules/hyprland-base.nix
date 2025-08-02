{ config, pkgs, ...}:
let
  super = "SUPER";
  wallpaper = "https://wallpapers.com/images/hd/pink-90s-aesthetic-x2i9y8jjvje2hu5b.jpg";
in
{
  home.packages = with pkgs; [
    wofi
    wl-clipboard
    mako
    swaybg
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    curl
    pkgs.nerd-fonts.jetbrains-mono
    playerctl
    pamixer
    brightnessctl
    xdg-utils
    grim
    slurp       
    gnome-control-center
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "pink";
      variant = "macchiato";
    })
  ];
  ### Hyprland
  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    general.theme = "catppuccin-macchiato-pink";
  };

  home.file."Pictures/wallpapers/default.jpg".source = pkgs.fetchurl {
    url = wallpaper;
    sha256 = "1kd7qam0isz3zz124d0pfmclvy0653f0zdlshd2rrag0i5wczskv";
  };

  home.file.".config/dolphinrc".text = lib.mkAfter ''
  [General]
  Version=202
  ViewPropsTimestamp=2025,6,30,19,20,43.744

  [KFileDialog Settings]
  Places Icons Auto-resize=false
  Places Icons Static Size=22

  [MainWindow]
  MenuBar=Disabled
  
  [UiSettings]
  ColorScheme=Kvantum
  '';

  home.file.".config/wofi/style.css".text = ''
  * {
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 14px;
    color: #f8f8f2;
    background-color: transparent;
  }

  window {
    background-color: #1a1a1a;
    border: 2px solid #ff79c6; /* or #bd93f9 for purple */
    border-radius: 8px;
  }

  #input {
    margin: 10px;
    padding: 5px;
    background-color: #2a2a2a;
    color: #f8f8f2;
    border-radius: 4px;
    border: none;
  }

  #entry {
    padding: 5px 10px;
    border-radius: 4px;
  }

  #entry:selected {
    background-color: #ff79c6; /* highlight color */
    color: #1a1a1a;
  }

  #scroll {
    margin: 5px 10px;
  }
'';
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Hivacruz";
      shell-integration = "zsh";
      command = "${pkgs.zsh}/bin/zsh"; # Set zsh as the default shell
      window-theme = "dark";
      background-opacity = 0.75; 
      background = "#1a1a1a";    
      foreground = "#f8f8f2";    
      cursor-color = "#ff79c6"; 
      selection-background = "#ff79c6"; 
      selection-foreground = "#1a1a1a"; 
    };
  };
  home.file.".config/wofi/powermenu.sh" = {
    text = ''
      #!/bin/sh
      choice=$(printf "⏻ Power Off\n Reboot\n Suspend\n Logout" | wofi --show dmenu --prompt "Power Menu")
      case "$choice" in
        "⏻ Power Off") systemctl poweroff ;;
        " Reboot") systemctl reboot ;;
        " Suspend") systemctl suspend ;;
        " Logout") hyprctl dispatch exit ;;
      esac
    '';
    executable = true;
  };
    programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces"];
        modules-center = [ ];
        modules-right = [ "pulseaudio" "network" "battery" "clock" "tray" ];
        clock = {
          format = "{:%a %b %d %I:%M %p}";
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-icons = [ "" "" "" ];
          scroll-step = 5;
        };
      };
    };
    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, monospace;
        font-size: 14px;
      }

      window#waybar {
        background: rgba(26, 26, 26, 0.8);
        color: #ff79c6;
        border-bottom: 2px solid #ff79c6;
      }

      #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 10px;
      }
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "BROWSER=microsoft-edge"
        "XDG_CURRENT_DESKTOP=Hyprland"
        "XDG_SESSION_TYPE=wayland"
      ];

      exec-once = [
        "waybar"
        "swaybg -i /home/krode/Pictures/wallpapers/default.jpg --mode fill"
        "mako"
        "wl-paste --watch clipman store"
      ];

      input = {
        kb_layout = "us";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        "col.active_border"   = "rgba(ff79c6ff) rgba(ff79c6ff) 45deg";
        "col.inactive_border" = "rgba(1a1a1aff)";
      };

      decoration = {
        rounding = 8;
        shadow = {
          range = 30;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      dwindle = {
        preserve_split = true;
        special_scale_factor = 1;
      };

      master = {
        new_on_top = true;
        new_status = "master";
        mfact = 0.55;
        special_scale_factor = 1;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_hyprland_qtutils_check = true;
        animate_mouse_windowdragging = true;
        initial_workspace_tracking = 1;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1,10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default, slidevert"
          "specialWorkspace, 1, 6, default, fade"
        ];
      };

      bind = [
        "${super}, Return, exec, ghostty"
        "${super}, E, exec, dolphin"
        "${super}, D, exec, wofi --show drun --style ~/.config/wofi/style.css"
        "${super}_SHIFT, Q, killactive"
        "${super}, F, fullscreen, 0"
        "${super}, V, togglefloating"
        "${super}, Space, togglefloating"
        "${super}_SHIFT, E, exec, ~/.config/wofi/powermenu.sh"
        "${super}, 1, workspace, 1"
        "${super}, 2, workspace, 2"
        "${super}, 3, workspace, 3"
        "${super}, 4, workspace, 4"
        "${super}, 5, workspace, 5"
        "${super}, 6, workspace, 6"
        "${super}, 7, workspace, 7"
        "${super}, 8, workspace, 8"
        "${super}, 9, workspace, 9"
        "${super}, 0, workspace, 10"
        "${super}_SHIFT, 1, movetoworkspace, 1"
        "${super}_SHIFT, 2, movetoworkspace, 2"
        "${super}_SHIFT, 3, movetoworkspace, 3"
        "${super}_SHIFT, 4, movetoworkspace, 4"
        "${super}_SHIFT, 5, movetoworkspace, 5"
        "${super}_SHIFT, 6, movetoworkspace, 6"
        "${super}_SHIFT, 7, movetoworkspace, 7"
        "${super}_SHIFT, 8, movetoworkspace, 8"
        "${super}_SHIFT, 9, movetoworkspace, 9"
        "${super}_SHIFT, 0, movetoworkspace, 10"
        ", F1, exec, pamixer -t"
        ", F2, exec, pamixer --decrease 5"
        ", F3, exec, pamixer --increase 5"
        ", F4, exec, playerctl previous" 
        ", F5, exec, playerctl play-pause"
        ", F6, exec, playerctl next"
        ", F7, exec, brightnessctl set 5%-"
        ", F8, exec, brightnessctl set +5%"
        ", F9, exec, wlr-randr"
        ", F10, exec, nmcli radio all off"
        ", F11, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot_$(date +%s).png"
        ", F12, exec, gnome-control-center"
      ];
      bindm = [
        "${super}, mouse:272, movewindow"
        "${super}, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "float,class:^(ghostty)$"
      ];
    };
  };
}