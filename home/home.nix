{config, pkgs, ...}:
{
  home.username = "jeppe";
  home.homeDirectory = "/home/jeppe";
  home.packages = with pkgs; [
    # GUI Packages
    microsoft-edge
    sioyek
    spotify
    obsidian
    discord
    anydesk
    vlc
    qimgv
    sway-contrib.grimshot
    wl-clipboard
    gnome.gnome-font-viewer
    
    # CMD UTILS
    fd
    ripgrep
    eza
    bat
    bat-extras.batman
    btop
    fzf
    gdu
    lazygit
    libqalculate
    nodejs_20 # Needed for neovim (coc)
    nushell
    rclone
    wireguard-tools
    sage

    # PYTHON
    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas scipy ]))
  ];

  imports = [
    ./configs/hypr.nix
    ./configs/fish.nix
    ./configs/kitty.nix
    ./configs/zathura.nix
    ./configs/lf.nix
    ./configs/waybar.nix
    ./configs/sioyek.nix
  ];

  # home.file.".config/nvim".source = ./configs/nvim;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # "application/pdf" = "org.pwmt.zathura.desktop";
    "application/pdf" = "sioyek.desktop";
    "image/jpeg" = "qimgv.desktop";
    "image/png" = "qimgv.desktop";
    "image/gif" = "qimgv.desktop";
  };

  programs.git = {
    enable = true;
    userName = "Jeppe Allerslev";
    userEmail = "jeppeallerslev@gmail.com";
  };
  
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
