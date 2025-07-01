{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    arion
    docker-client
  ];
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.defaultNetwork.dnsname.enable = true;
  users.extraUsers.krode.extraGroups = [ "podman" ];
}