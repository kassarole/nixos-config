{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    vscode
    digikam
    microsoft-edge
    darktable
    ghostty
    godot
    blender
    libresprite
    sdrangel
    sdrpp
    element-desktop
    kicad
    signal-desktop
  ];
}