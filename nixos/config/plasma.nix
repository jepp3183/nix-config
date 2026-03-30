{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
  ];

  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
  ];
}
