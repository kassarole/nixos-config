{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
        python3
        python3Packages.pip
        python3Packages.virtualenv
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  users.extraUsers.krode.extraGroups = [ "docker" ];
}