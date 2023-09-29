{config, pkgs, ...}:
{
  home.username = "jeppe";
  home.homeDirectory = "/home/jeppe";
  home.packages = with pkgs; [
    microsoft-edge
    lf
    bat
    bat-extras.batman
    zathura
    sioyek
    gnome.gnome-font-viewer
    btop
    fd
    ripgrep
    fzf
    spotify
    nodejs_20 # Needed for neovim (coc)
    nushell
    eza
    obsidian
    discord
    rclone
    wireguard-tools
    anydesk
    lazygit
    stow
    sage
    gdu
    qimgv
    libqalculate

    # For screenshots
    slurp
    grim 
    wl-clipboard

    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas scipy ]))
  ];

  imports = [
    ./configs/hypr.nix
    ./configs/fish.nix
    ./configs/alacritty.nix
    ./configs/zathura.nix
    ./configs/lf.nix
  ];

  home.file.".config/nvim".source = ./configs/nvim;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
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
