{
  services = {
    nginx.enable = true;
  }
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kass@basedzone.xyz";
}