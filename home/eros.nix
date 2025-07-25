{ config, pkgs, lib, ... }:

{
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    jdk21_headless
    screen
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
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#eros";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#eros";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "dpoggi";
    };
  };
  home.file.".zshrc".text = lib.mkAfter ''
    export TERM=xterm-256color
  '';
}
