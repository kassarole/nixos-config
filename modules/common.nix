{ pkgs, ... }:
{
  time.timeZone = "America/Chicago";
  environment.systemPackages = with pkgs; [
    git 
    vim 
    wget 
    htop
    hyfetch
    ncdu
    nettools
  ];
  services.openssh.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.nix-ld.enable = true;

}
