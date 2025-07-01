{ config, pkgs, ... }:

{
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vscode
    hyfetch
    python3
    python3Packages.pip
    python3Packages.virtualenv
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
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#kass-dev-nix";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#kass-dev-nix";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "dpoggi";
    };
  };
}
