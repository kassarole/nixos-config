{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    vscode
    digikam
    darktable
    ghostty
}