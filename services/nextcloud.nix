{
  security.acme.certs."nextcloud.basedzone.xyz" = {
    dnsProvider = "cloudflare";
    environmentFile = "/home/krode/nixos-config/secrets/cloudflare.env";
  };
  security.acme.certs."docs.basedzone.xyz" = {
    dnsProvider = "cloudflare";
    environmentFile = "/home/krode/nixos-config/secrets/cloudflare.env";
  };

  services.nginx = {
  virtualHosts."nextcloud.basedzone.xyz" = {
    forceSSL = true;
    useACMEHost = "nextcloud.basedzone.xyz";
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080/";
      proxyWebsockets = true;
    };
    extraConfig = ''
      client_max_body_size 16G;
    '';
  };
  virtualHosts."docs.basedzone.xyz" = {
    forceSSL = true;
    useACMEHost = "docs.basedzone.xyz";
    locations."/" = {
      proxyPass = "http://127.0.0.1:8081/";
      proxyWebsockets = true;
    };
  };
  };

  nextcloud  = {
    enable = true;
    hostName = "nextcloud.basedzone.xyz";
    package = pkgs.nextcloud31;
    database.createLocally = true;
    configureRedis = true;
    maxUploadSize = "16G";
    https = true;
    enableBrokenCiphersForSSE = false;
    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    extraApps with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts mail notes onlyoffice tasks;
    };
    config = {
      owerwriteProtocol = "https";
      defaultPhoneRegion = "US";
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = "/run/nextcloud-admin-password";
    };
  };
  onlyoffice = {
    enable = true;
    hostname = "docs.basedzone.xyz";
  };
}