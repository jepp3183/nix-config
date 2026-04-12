{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
  };

  # Required for Noctalia-shell:
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  security.pam.services.swaylock.text = ''
    auth include login
  '';
}
