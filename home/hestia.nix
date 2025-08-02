{ config, pkgs, lib, plasma-manager, ... }:
{
  imports = [ 
    plasma-manager.homeManagerModules.plasma-manager
    ./modules/hyprland-base.nix
    ];
  home.file.".wallpapers/wallpaper.jpg".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/kassarole/kassiopia-photos/refs/heads/main/photos/IMG_2031.png";
    sha256 = "380d8cbaa5e707d6eebc1c4ba717270a7c4010921a2b6b804fc1e79736c2b7e6";
  };

  home.file."bin/start-plasma-wayland.sh" = {
  executable = true;
  text = ''
    #!/bin/sh
    if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty2" ]; then
      exec dbus-launch startplasma-wayland
    fi
  '';
  };

  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
      cursor.theme = "WhiteSur-cursors";
      iconTheme = "WhiteSur-dark";
      wallpaper = "/home/krode/.wallpapers/wallpaper.jpg";
    };
    kscreenlocker.appearance.wallpaper = "/home/krode/.wallpapers/wallpaper.jpg";
    hotkeys.commands."launch-ghostty" = {
      command = "ghostty";
      key = "Meta+Alt+T"; # Meta is usually the Windows key
    };
  };

  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    whitesur-kde
    whitesur-cursors
    whitesur-icon-theme
  ];
    programs.git = {
    enable=true;
    userName = "kass";
    userEmail = "kass@basedzone.xyz";
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      if [ -f "$HOME/bin/start-plasma-wayland.sh" ]; then
        . "$HOME/bin/start-plasma-wayland.sh"
      fi
    '';
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#hestia";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#hestia";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "half-life";
    };
  };
  home.file.".zshrc".text = lib.mkAfter ''
    export TERM=xterm-256color
  '';
  wayland.windowManager.hyprland.settings = {
    monitor = [ 
      "DP-3,1920x1080@165,0x0,1"
      "DP-1,2560x1440@165,1920x0,1"
      "DP-2,1920x1080@165,4480x0,1"
    ];
  };
}
