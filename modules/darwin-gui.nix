{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      "wireguard-tools"
      "wireguard-go" 
    ];
    casks = [
        "visual-studio-code"
        "digikam"
        "vesktop"
        "darktable"
        "ghostty"
        "godot"
        "blender"
        "microsoft-edge"
        "windows-app"
        "element"
        "kicad"
    ];
    taps = [

    ];
  };
}