{pkgs, ...}:
{
  programs.fish = {
    enable = true;
    plugins = [
      { name = "hydro-prompt"; src = pkgs.fishPlugins.hydro.src; }
    ];
    shellAliases = {
      gs = "git status";
      cat = "bat";
      man = "batman";
      ls = "eza";
    };
    interactiveShellInit = ''
      set fish_greeting

      bind \ck up-or-search
    '';
  };
}
