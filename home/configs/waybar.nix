{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = ["hyprland/workspaces"   "custom/media"];
        modules-center = ["hyprland/window"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "backlight" "battery" "clock" "tray"];

        tray = {
            icon-size = 21;
            spacing = 10
        };
        clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}"
        };
        cpu = {
            format = "CPU = {usage}%";
            tooltip = true;
            on-click = "alacritty -e btop";
            interval = 10
        };
        memory = {
            format = "RAM = {}%";
            on-click = "alacritty -e btop";
            interval = 10
        };
        backlight = {
            format = "{percent}% {icon}";
            format-icons = ["", "", "", "", "", "", "", "", ""]
        };
        battery = {
            states = {
                good = 95;
                warning = 30;
                critical = 15
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["", "", "", "", ""]
        };
        network = {
            format-wifi = "{bandwidthUpBits} ⇅ {bandwidthDownBits}";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname} = {ipaddr}/{cidr}";
            interval = 5
        };
        pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["", "", ""]
            };
            on-click = "pavucontrol"
        }
      }; 
    };

    style = ''

    '';
  } 
}
