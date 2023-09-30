{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    font.name = "MesloLGS NF";
    font.size = 11;
    settings = {
      background_opacity = "0.5";
      confirm_os_window_close = 0;
    };
  };
}
