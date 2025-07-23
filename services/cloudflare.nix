{
  services.cloudflare-dyndns = {
    enable = true;
    domains = [
      "nextcloud.basedzone.xyz"
      "docs.basedzone.xyz"
      "immich.basedzone.xyz"
    ];
    apiTokenFile = "/home/krode/nixos-config/secrets/cloudflare.env";
  }
}