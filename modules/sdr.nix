{ pkgs, hardware, ... }:
{
  hardware.rtl-sdr.enable = true;
  users.users.krode.extraGroups = [ "plugdev" ];
}