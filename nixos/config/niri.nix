{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swaynotificationcenter
    swaylock
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
  };

  security.pam.services.swaylock.text = ''
    auth include login
  '';
}
