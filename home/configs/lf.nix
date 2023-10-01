{pkgs, ...}:
{
  home.packages = with pkgs; [
    lf
  ];

  xdg.configFile."lf/icons".source = ./lf_icons;
  
  programs.lf = {

    enable = true;
    settings = {
      ignorecase = true;
      icons = true;
      preview = true;
    };

    commands = {
      open = ''
        ''${{
          case $(${pkgs.file}/bin/file -Lb --mime-type "$f") in
            text/*) $EDITOR "$f";;
            *) nohup xdg-open "$f" >/dev/null 2>&1 &;;
          esac
        }}
      '';
      mkdir = "%mkdir $1";
      touch = "%touch $1";
      trash = "%mv $fx ~/.trash";
    };
    keybindings = {
      # unmap clear, which removed yank/cut paths in buffer
      c = "";
      D = "trash";
      gu = "cd ~/GDrive/SkoleShit/UNI";
      gn = "cd /etc/nixos";
      "<enter>" = "open";
      S = "!fish";
    };

    extraConfig =
      let 
        previewer = 
          pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5
          type="$(${pkgs.file}/bin/file -Lb --mime-type "$file")"
          
          if [[ $type =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          if [[ $type =~ ^text ]]; then
              ${pkgs.bat}/bin/bat -f --style='numbers' "$file"
              exit 1
          fi
          
          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set ifs "\n"
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
  };
}
