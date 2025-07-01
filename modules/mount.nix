{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/USB2" = {
    device = "//10.0.25.220/USB2";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "${automount_opts},credentials=/etc/nixos/credentials/USB2,rw,file_mode=0777,dir_mode=0777"
    ];
  };
  fileSystems."/mnt/Storage" = {
    device = "//10.0.25.101/Storage";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "${automount_opts},credentials=/etc/nixos/credentials/Storage,rw,file_mode=0777,dir_mode=0777"
    ];
  };
  fileSystems."/mnt/MediaStorage" = {
    device = "//10.0.25.101/MediaStorage";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "${automount_opts},credentials=/etc/nixos/credentials/Storage,rw,file_mode=0777,dir_mode=0777"
    ];
  };
  fileSystems."/mnt/MediaServer" = {
    device = "//10.0.25.100/MediaServer";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "${automount_opts},credentials=/etc/nixos/credentials/Storage,rw,file_mode=0777,dir_mode=0777"
    ];
  };
}