{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../config/common.nix
    # ../config/plasma.nix
    # ../config/niri.nix
  ];

  services.desktopManager.cosmic.enable = true;

  networking.hostName = "nixos"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    streamdeck-ui
    dnsmasq
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
  };

  # COSMIC does not persist per-output VRR settings across reboots, and NVIDIA's
  # handling of Adaptive Sync on the Acer XF270HU (DP-2) causes severe compositor
  # stutter (cosmic-comp pegged ~30% CPU on an otherwise idle system). Force
  # Adaptive Sync off on DP-2 every time the COSMIC session starts.
  systemd.user.services.cosmic-vrr-fix = {
    description = "Disable Adaptive Sync on DP-2 (NVIDIA/COSMIC stutter workaround)";
    partOf = [ "cosmic-session.target" ];
    wantedBy = [ "cosmic-session.target" ];
    after = [ "cosmic-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "cosmic-vrr-fix" ''
        for i in $(seq 1 30); do
          if ${pkgs.cosmic-randr}/bin/cosmic-randr list | grep -q '^DP-2'; then
            exec ${pkgs.cosmic-randr}/bin/cosmic-randr mode DP-2 2560 1440 \
              --refresh 143.856 --adaptive-sync false
          fi
          sleep 1
        done
        echo "cosmic-vrr-fix: DP-2 not found after 30s" >&2
        exit 1
      '';
    };
  };

  # make MSI ultrawide AUX work on desktop
  services.pipewire.wireplumber.extraConfig."51-nvidia-hdmi" = {
    "monitor.alsa.rules" = [
      {
        matches = [ { "device.name" = "alsa_card.pci-0000_26_00.1"; } ];
        actions.update-props."device.profile" = "output:hdmi-stereo-extra1";
      }
    ];
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.jeppe.extraGroups = [
    "libvirtd"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
