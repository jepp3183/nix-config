{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
  };

  security.pam.services.swaylock.text = ''
    auth include login
  '';
}
