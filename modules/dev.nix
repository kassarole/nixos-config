{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  users.extraUsers.krode.extraGroups = [ "docker" ];
}