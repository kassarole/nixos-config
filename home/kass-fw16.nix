{ config, pkgs, ... }:

{
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vesktop
    vscode
    digikam
    darktable
    hyfetch
    protonup-qt
    ghostty
    lutris
    heroic
  ];
  programs.git = {
    enable=true;
    userName = "kass";
    userEmail = "kass@basedzone.xyz";
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#kass-fw16";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#kass-fw16";
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
    };
  };
}
