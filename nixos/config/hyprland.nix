{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    swaynotificationcenter
    hyprpolkitagent
    swaylock
    sddm-astronaut
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
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

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  security.pam.services.swaylock.text = ''
    auth include login
  '';
}
