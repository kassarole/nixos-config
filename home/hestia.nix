{ config, pkgs, plasma-manager, ... }:

{
  imports = [ plasma-manager.homeManagerModules.plasma-manager ];
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
      cursor.theme = "WhiteSur-cursors";
      iconTheme = "WhiteSur-dark";
    };
    hotkeys.commands."launch-ghostty" = {
      command = "ghostty";
      key = "Meta+Alt+T"; # Meta is usually the Windows key
    };
  };

  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

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
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      shell-integration = "zsh";
      command = "${pkgs.zsh}/bin/zsh"; # Set zsh as the default shell
    };
  };
}
