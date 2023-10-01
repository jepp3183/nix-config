{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    font.name = "MesloLGS NF";
    font.size = 11;
    settings = {
      # background_opacity = "0.7";
      background = "#10161a";
      confirm_os_window_close = 0;
    };
  };
}
