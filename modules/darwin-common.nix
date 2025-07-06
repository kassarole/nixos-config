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
  system.defaults.dock.show-recents = false;
  system.activationScripts.installRosetta.text = ''
    if [[ $(uname -m) == "arm64" ]]; then
      if ! /usr/bin/pgrep oahd &>/dev/null; then
        echo "Installing Rosetta 2..."
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
      fi
    fi
  '';
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
