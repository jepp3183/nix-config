{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    gamescope-wsi # HDR won't work without this
  ];

  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
  ];

  # GOATED HDR LAUNCH OPTIONS: PROTON_ENABLE_HDR=1 DXVK_HDR=1 gamescope -W 3440 -H 1440 -r 240 -f --hdr-enabled -- %command%
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
}
