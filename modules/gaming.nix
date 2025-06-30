{ pkgs, ... }:
{
  hardware.opengl.driSupport32Bit = true;

  # AMD GPU and Vulkan support
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    vulkan-tools
    # rocm-opencl-icd  # Uncomment if you need OpenCL
    # rocm-opencl-runtime
  ];

  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  services.pipewire.enable = true;

  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288;
}