{ pkgs, ...}: {
  programs.emacs = {
    enable = true;
    extraConfig = ''
    '';
  };
  home.file.".emacs.d" = {
    source = ./.emacs.d;
    recursive = true;
  };
}
