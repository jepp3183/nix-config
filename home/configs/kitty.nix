{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    font.package = pkgs.meslo-lgs-nf;
    font.size = 11;
    settings = {
      background_opacity = 0.1;
    };
  }
}
