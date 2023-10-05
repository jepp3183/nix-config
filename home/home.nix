{inputs, config, pkgs, ...}:
{
  home.username = "jeppe";
  home.homeDirectory = "/home/jeppe";
  home.packages = with pkgs; [
    # GUI Packages
    microsoft-edge
    spotify
    obsidian
    discord
    anydesk
    vlc
    qimgv
    wl-clipboard
    
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
    nushell
    rclone
    wireguard-tools
    sage
    rofi

    # PYTHON
    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas scipy ]))
  ];

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./configs/hypr.nix
    ./configs/fish.nix
    ./configs/kitty.nix
    ./configs/zathura.nix
    ./configs/lf.nix
    ./configs/waybar.nix
    ./configs/sioyek.nix
    ./configs/rofi.nix
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "sioyek.desktop";
    "image/jpeg" = "qimgv.desktop";
    "image/png" = "qimgv.desktop";
    "image/gif" = "qimgv.desktop";
  };

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  programs.git = {
    enable = true;
    userName = "Jeppe Allerslev";
    userEmail = "jeppeallerslev@gmail.com";
  };
  
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/configs/nvim;
  xdg.configFile."nvim/plugin/plugins/base16.lua" = {
      enable = true;
      text = with config.colorScheme.colors; ''
        require('base16-colorscheme').setup({
            base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
            base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
            base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
            base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
        })
      '';
  };
}
