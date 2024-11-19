{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # What could possibly go wrong?
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {from = 0; to=65535;}
    ];
    allowedUDPPortRanges = [
      {from = 0; to=65535;}
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
  environment.systemPackages = with pkgs; [
    wget
    curl
    neovim
    kitty
    git
    dnsutils
    wireshark
    distrobox

    (waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))

    dunst #notifications
    libnotify #dunst needs this
    networkmanagerapplet
    pavucontrol
    brightnessctl
    playerctl
    swaylock
    sddm-chili-theme
  ];

  programs = {
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    
    wireshark.enable = true; # Does some extra needed work
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    _1password.enable = true;
    _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "jeppe" ];
    };
    steam.enable = true;
  };

  virtualisation.virtualbox = {
    host.enable = true;
    guest.enable = true;
  };
  virtualisation.docker = {
    enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

  # Enable networking
  networking.hostName = "nixos-envy"; # Define your hostname.
  networking.networkmanager.enable = true;


  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      wayland.enable = true;
    };
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeppe = {
    isNormalUser = true;
    description = "Jeppe Allerslev";
    extraGroups = [ "networkmanager" "wheel" "input" "wireshark" "vboxusers" "docker" "dialout" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # environment.variables.EDITOR = "nvim";

  hardware.opengl.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.acpid= {
    enable = true;
    logEvents = true;
  };
  security.pam.services.swaylock.text = ''
  auth include login
  '';
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
