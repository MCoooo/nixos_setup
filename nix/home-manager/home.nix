{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {

  home.username = "dave";
  home.homeDirectory = "/home/dave";
  
   imports = [
              ./apps/shell/shell.nix # My zsh and bash config
              ./editors/emacs/default.nix
              ./editors/nvim/default.nix
              ./apps/git/default.nix
              ./terminals/kitty.nix
             ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh
    zig
    fd
    eza
    bat
    ripgrep
    kitty
    qbittorrent
    wofi
    tmux
    direnv
    gnome.gnome-tweaks
    citrix_workspace
    gnome.dconf-editor
    gnome-extension-manager
    gradience

    # useful utils
    nautilus-open-any-terminal

    # extensions
    gnomeExtensions.appindicator
    gnomeExtensions.aylurs-widgets
    gnomeExtensions.blur-my-shell
    gnomeExtensions.extensions-sync
    gnomeExtensions.hibernate-status-button
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection
    gnomeExtensions.pano
    gnomeExtensions.pop-shell
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.search-light
    gnomeExtensions.smart-auto-move
    gnomeExtensions.space-bar
    gnomeExtensions.order-gnome-shell-extensions

    libgda # used by pano extension

    # styles
    adw-gtk3
    adwaita-qt
    papirus-icon-theme
    papirus-folders
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dave/etc/profile.d/hm-session-vars.sh
  #
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {

      input = {
        kb_layout = "gb";
        follow_mouse = 1;
      };
    "$mod" = "SUPER";
    "$menu" = "wofi --show drun";
    bind =
      [
        "$mod, W, exec, firefox"
        "$mod, T, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, F, exec, Files"
        "$mod, D, exec, $menu"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 0)}"
            ]
          )
          10)
      );
  };



  home.sessionVariables = {
    TERM = "kitty";
    EDITOR = "emacs";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };


}
