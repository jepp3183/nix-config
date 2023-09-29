{
  programs.lf = {
    enable = true;

    extraConfig = ''
      set ifs "\n"

      cmd open ''${{
        case $(xdg-mime query filetype "$f") in
          text/*) $EDITOR "$f";;
          *) nohup xdg-open "$f" >/dev/null 2>&1 &;;
        esac
      }}

      cmd mkdir ''${{
        mkdir $1
      }}

      cmd touch ''${{
        touch $1
      }}

      $mkdir -p ~/.trash
      cmd trash ''${{
        mv $fx ~/.trash
      }}
    
      # unmap clear, which removed yank/cut paths in buffer
      map c

      map D trash

      map gu cd ~/GDrive/SkoleShit/UNI
      map gn cd /etc/nixos

      map S !fish
    
    '';
  };
}
