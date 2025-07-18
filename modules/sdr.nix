{ pkgs, hardware, ... }:
{
  hardware.rtl-sdr.enable = true;
  users.users.krode.extraGroups = [ "plugdev" ];
  users.users.krode.packages = with pkgs; [
  ];
  systemd.services.rtl_tcp = {
    description = "RTL-SDR TCP server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rtl-sdr}/bin/rtl_tcp -a 0.0.0.0 -p 1234";
      Restart = "on-failure";
      User = "krode";
      Group = "plugdev";
    };
  };
}
