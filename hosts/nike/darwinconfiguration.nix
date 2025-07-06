{ config, pkgs, ... }:
{
    networking.hostName = "nike";
    environment.systemPackages = with pkgs; [
        git
        vim
        wget
    ];
    users.users.krode = {
        home = "/Users/krode";
        shell = pkgs.zsh;
    };
    system.stateVersion = 6;
    nixpkgs.config.allowUnfree = true;
}