{pkgs,...}:
{
  # home.packages = with pkgs; [
  # ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      input = {
          kb_layout = "us,dk";
          kb_options = "ctrl:nocaps,grp:alt_shift_toggle";
          follow_mouse = 1;
          touchpad.natural_scroll = true;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification
          repeat_delay = 500;
          repeat_rate = 30;
      };
      general = {
          gaps_in = 3;
          gaps_out = 3;
          border_size = 2;
          "col.active_border" = "rgba(33ccff99) rgba(00ff9999) 45deg";
          "col.inactive_border" = "rgba(59595900)";
          layout = "dwindle";
      };
      decoration = {
          rounding = 5;
          blur = {
              enabled = true;
              size = 8;
              passes = 2;
              ignore_opacity = true;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
           ];
      };
      dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
          smart_split = false;
          no_gaps_when_only = 1;
          special_scale_factor = 0.95;
      };
      master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = false;
          orientation = "left";
          no_gaps_when_only = 1;
      };
      gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true;
      };
      monitor = "eDP-1,1920x1080@60.033001,auto,1";

      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "dunst"
        "[workspace special:terminal silent] kitty"
        "[workspace special:qalc silent] kitty -e qalc"
        "${pkgs.swaybg}/bin/swaybg -i Pictures/5rVFQla.jpeg"
      ];
      exec = [];
      windowrule = [
        "opacity 0.9,(kitty)"
      ];
    }; 

    extraConfig = 
    let 
      file_opener = pkgs.writeShellScriptBin "open.sh" ''
        cd ~
        file=$(${pkgs.fd}/bin/fd -tl -tf -a . ~ | ${pkgs.rofi}/bin/rofi -dmenu -matching fuzzy -i -sort -sorting-method fzf)
        type=$(${pkgs.file}/bin/file -Lb --mime-type "$file")

        if [[ $type =~ ^text ]]; then
            nohup ${pkgs.kitty}/bin/kitty -e nvim "$file" >/dev/null 2>&1  &
        else
            nohup xdg-open "$file" >/dev/null 2>&1 &
        fi
        sleep 0.01
      '';
    in
      ''
        # ===========================================
        # BINDS
        # ===========================================
        $mainMod = SUPER

        bind = $mainMod, M, exit, 
        bind = $mainMod+SHIFT, S, exec, ${pkgs.fish}/bin/fish -c "XDG_SCREENSHOTS_DIR=/home/jeppe/Pictures/Screenshots ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- < (${pkgs.sway-contrib.grimshot}/bin/grimshot save area) | wl-copy"
        #bind = ALT, SPACE, exec, [float; size 1200 600; center] ${pkgs.kitty}/bin/kitty -e ${file_opener}/bin/open.sh
        bind = ALT, SPACE, exec, ${file_opener}/bin/open.sh

        # Testing...
        bind = $mainMod, O, movetoworkspace, special
        bind = $mainMod, P, togglespecialworkspace, 
        bind = $mainMod, U, togglespecialworkspace, terminal
        bind = $mainMod, Y, togglespecialworkspace, qalc

        # RUN
        bind = $mainMod, Return, exec, kitty
        bind = $mainMod, B, exec, microsoft-edge
        bind = $mainMod+SHIFT, P, exec, nwg-bar
        bind = $mainMod, SPACE, exec, ${pkgs.rofi}/bin/rofi -show drun -show-icons

        # LID CLOSE
        bindl = ,switch:Lid Switch, exec, ${pkgs.swaylock}/bin/swaylock -i /home/jeppe/Pictures/5rVFQla.jpeg 
        
        # Brightness + Volume
        bind = , XF86MonBrightnessDown, exec, brightnessctl s 10%-
        bind = , XF86MonBrightnessUp, exec, brightnessctl s +10%
        bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.5
        bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5
        bind = , XF86AudioPlay, exec, playerctl play-pause
        bind = , XF86AudioPrev, exec, playerctl previous
        bind = , XF86AudioNext, exec, playerctl next

        # OTHER WINDOW CONTROLS
        bind = $mainMod, F, fullscreen, 0
        bind = $mainMod, Q, killactive, 
        bind = $mainMod+SHIFT, F, togglefloating, 
        bind = $mainMod, T, togglesplit, # dwindle

        # RESIZE WINDOW
        bind = $mainMod, left, resizeactive, -50 0
        bind = $mainMod, right, resizeactive, 50 0
        bind = $mainMod, up, resizeactive, 0 -50
        bind = $mainMod, down, resizeactive, 0 50

        # MOVE FOCUS
        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d

        # MOVE WINDOWS
        bind = $mainMod+SHIFT, H, movewindow, l
        bind = $mainMod+SHIFT, L, movewindow, r
        bind = $mainMod+SHIFT, K, movewindow, u
        bind = $mainMod+SHIFT, J, movewindow, d

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
        bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
        bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
        bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
        bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
        bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
        bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
        bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
        bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
        bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      '';
  };
}
