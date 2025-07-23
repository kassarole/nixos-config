{
  security.acme.certs."immich.basedzone.xyz" = {
    dnsProvider = "cloudflare";
    environmentFile = "/home/krode/nixos-config/secrets/cloudflare.env";
  };

  services.nginx = {
  virtualHosts."immich.basedzone.xyz" = {
    forceSSL = true;
    useACMEHost = "immich.basedzone.xyz";
    locations."/" = {
      proxyPass = "http://127.0.0.1:2283/";
      proxyWebsockets = true;
    };
    extraConfig = ''
      client_max_body_size 16G;
    '';
  };
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "/mnt/USB2/";
    openFirewall = true;
  };
}