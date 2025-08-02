{ config, pkgs, lib, ... }:
{
  imports = [
    ./modules/hyprland-base.nix
  ];
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

home.packages = with pkgs; [

];

  programs.git = {
    enable = true;
    userName = "kass";
    userEmail = "kass@basedzone.xyz";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#metis";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#metis";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "half-life";
    };
  };
  home.file.".zshrc".text = lib.mkAfter ''
    export TERM=xterm-256color
  '';
  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-2,2560x1600@165,0x0,1" ];
  };
}
