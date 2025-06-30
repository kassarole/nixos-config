{ pkgs, ... }:
{
  time.timeZone = "America/Chicago";
  environment.systemPackages = with pkgs; [
    git vim wget htop
  ];
  services.openssh.enable = true;
  environment.variables.GTK_THEME = "Adwaita-dark";
}
