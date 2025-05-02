{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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

  environment.systemPackages = with pkgs; [
     wget
     curl
     neovim
     kitty
     git
     dnsutils
     wireshark
     distrobox
     wireguard-tools
     keymapp

     (waybar.overrideAttrs (oldAttrs: {
     mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))

     swaynotificationcenter
     hyprpolkitagent
     networkmanagerapplet
     pavucontrol
     brightnessctl
     playerctl
     swaylock
     sddm-astronaut
  ] ++ [kdePackages.qtmultimedia];

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
      withUWSM = true;
      xwayland.enable = true;
    };

    _1password.enable = true;
    _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "jeppe" ];
    };
    steam.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    gwenview
    okular
    kate
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };
  services.resolved.enable = true;

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  services.xserver = {
    enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = [
      pkgs.sddm-astronaut
    ];
    theme = "sddm-astronaut-theme";
    settings = {        
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeppe = {
    isNormalUser = true;
    description = "jeppe";
    extraGroups = [ "plugdev" "networkmanager" "wheel" "input" "wireshark" "docker" "dialout" ];
    shell = pkgs.fish;
  };
  
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.pam.services.swaylock.text = ''
  auth include login
  '';

  # Install firefox.
  programs.firefox.enable = true;

  # Moonlander setup
  services.udev.extraRules = ''
  KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
  KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev" 
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
  '';


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
