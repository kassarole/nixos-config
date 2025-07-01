{ pkgs, ... }:
{
  time.timeZone = "America/Chicago";
  environment.systemPackages = with pkgs; [
    git vim wget htop
  ];
  services.openssh.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    SDL2
    SDL2_mixer
    libsamplerate
    fluidsynth
  ];
}
