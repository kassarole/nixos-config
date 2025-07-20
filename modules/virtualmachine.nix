{ pkgs, ... }:
{
  virtualisation.vmware.guest.enable = true;
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}