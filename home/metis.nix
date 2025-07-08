{ config, pkgs, ... }:

{
  home.username = "krode";
  home.homeDirectory = "/home/krode";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
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
      update = "sudo nixos-rebuild switch --flake /home/krode/nixos-config#metis";
      build = "sudo nixos-rebuild build --flake /home/krode/nixos-config#metis";
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
  home.file.".zshrc".text = lib.mkAfter ''
    export TERM=xterm-256color
  '';
}
