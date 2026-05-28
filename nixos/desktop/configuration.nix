{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../config/common.nix
    ../config/plasma.nix
    ../config/niri.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    streamdeck-ui
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true; # Set to false to use the proprietary kernel module
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    # 595.71.05 (current `stable`/`production` in this nixpkgs pin) misfires DRM
    # vblank events on Wayland, which makes niri throttle to ~60Hz despite
    # negotiating 144/240. 580.142 is the previous LTS branch and the most
    # widely-deployed open-module driver.
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  # Fix niri vblank throttling on NVIDIA: pin PowerMizer to max so the GPU
  # doesn't clock down between frames and trigger spurious early vblanks
  # (https://github.com/YaLTeR/niri/issues/2516).
  hardware.nvidia.moduleParams = {
    nvidia.NVreg_EnableGpuFirmware = 1;
    nvidia.NVreg_RegistryDwords = "PowerMizerEnable=0x1;PowerMizerDefaultAC=0x1;PerfLevelSrc=0x2222";
  };

  # Enable all SysRq commands so we can use Alt+SysRq+{T,W,L,B} to inspect /
  # force-reboot a wedged system (systemctl is useless when PID 1's D-Bus is
  # hung — SysRq talks straight to the kernel).
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # make MSI ultrawide AUX work on desktop
  services.pipewire.wireplumber.extraConfig."51-nvidia-hdmi" = {
    "monitor.alsa.rules" = [
      {
        matches = [ { "device.name" = "alsa_card.pci-0000_26_00.1"; } ];
        actions.update-props."device.profile" = "output:hdmi-stereo-extra1";
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
