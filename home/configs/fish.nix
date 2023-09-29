{
  programs.fish = {
    enable = true;
    plugins = [
      { name = "hydro-prompt"; src = pkgs.fishPlugins.hydro.src; }
    ];
    interactiveShellInit = ''
      set fish_greeting

      bind \ck up-or-search
    '';
  };
}
