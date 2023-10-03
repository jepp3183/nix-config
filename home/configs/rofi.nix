{pkgs, ...}:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      kb-remove-to-eol: "";
      kb-accept-entry: "Control+m,Return,KP_Enter";
      kb-row-up: "Up,Control+k,ISO_Left_Tab";
      kb-row-down: "Down,Control+j";
    };
  };
}
