{ config, pkgs, ... }:

{
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
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
}
