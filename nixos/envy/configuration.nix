{ config, pkgs, pkgs-ab0c, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
    ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

  # Enable networking
  networking.hostName = "nixos-envy"; # Define your hostname.

  hardware.graphics.enable = true;
  services.acpid= {
    enable = true;
    logEvents = true;
  };
  
  services.pipewire = {
    package = pkgs-ab0c.pipewire;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
