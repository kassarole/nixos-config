{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    vscode
    digikam
    darktable
    ghostty
    godot
    blender
    libresprite
    sdrangel
    sdrpp
    element-desktop
  ];
}