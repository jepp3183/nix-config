{pkgs, ...}:
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      kb-remove-to-eol = "";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-row-up = "Up,Control+k,ISO_Left_Tab";
      kb-element-prev = "";
      kb-element-next = "";
      kb-row-down = "Down,Control+j,Tab";
    };

    theme = ./rofi-theme.nix;
  };
}
