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
  system.primaryUser = "krode";
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
        
    ];
    casks = [
        "karabiner-elements"
    ];
    taps = [

    ];
  };
}
