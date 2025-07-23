{
  security.acme.certs."navidrome.basedzone.xyz" = {
    dnsProvider = "cloudflare";
    environmentFile = "/home/krode/nixos-config/secrets/cloudflare.env";
  };

  services.nginx = {
  virtualHosts."navidrome.basedzone.xyz" = {
    forceSSL = true;
    useACMEHost = "navidrome.basedzone.xyz";
    locations."/" = {
      proxyPass = "http://127.0.0.1:4533/";
      proxyWebsockets = true;
    };
    extraConfig = ''
      client_max_body_size 16G;
    '';
  };
  };
  services.navidrome = {
    enable = true;
    environmentFile = "/home/krode/nixos-config/secrets/navidrome.env";
    settings = {
      MusicFolder = "/mnt/MediaServer/Music";
      BaseUrl = "https://navidrome.basedzone.xyz";
    };
  };
}