{ config, pkgs, ... }:

{
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      privateKeyFile = "/etc/wireguard/privatekey";
      listenPort = 51820;
      peers = [
        {
          publicKey = "peer-public-key";
          allowedIPs = [ "10.0.0.2/32" ];
          endpoint = "peer.example.com:51820";
        }
      ];
      addresses = [ "10.0.0.1/24" ];
    };
  };
}
