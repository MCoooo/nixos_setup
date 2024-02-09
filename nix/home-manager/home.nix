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
              ./apps/misc/wlogout.nix
              ./apps/misc/swaylock.nix
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
    nodejs
    quickemu
    wl-clipboard
    zoxide
    fzf

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
  # wayland.windowManager.hyprland.enableNvidiaPatches = true;
  wayland.windowManager.hyprland.settings = {

  monitor = "eDP-1, 1920x1080, 0x0, 1";


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
      "$mod SHIFT, E, exec, wlogout"
      "$mod, F, exec, Files"
      "$mod, D, exec, $menu"
      "SUPER, F,Fullscreen,0"

      # Focus
      "SUPER,h,movefocus,l"
      "SUPER,l,movefocus,r"
      "SUPER,k,movefocus,u"
      "SUPER,j,movefocus,d"
      "SHIFT, LEFT,movefocus,l"
      "SHIFT, RIGHT,movefocus,r"
      "SHIFT, UP,movefocus,u"
      "SHIFT, DOWN,movefocus,d"
      "CTRL_SHIFT, LEFT,movewindow,l"
      "CTRL_SHIFT, RIGHT,movewindow,r"
      "CTRL_SHIFT, UP,movewindow,u"
      "CTRL_SHIFT, DOWN,movewindow,d"
      "SUPERCONTROL,h,focusmonitor,l"
      "SUPERCONTROL,l,focusmonitor,r"
      "SUPERCONTROL,k,focusmonitor,u"
      "SUPERCONTROL,j,focusmonitor,d"

      # Change Workspace
      "SUPER,1,workspace,01"
      "SUPER,2,workspace,02"
      "SUPER,3,workspace,03"
      "SUPER,4,workspace,04"
      "SUPER,5,workspace,05"
      "SUPER,6,workspace,06"
      "SUPER,7,workspace,07"
      "SUPER,8,workspace,08"
      "SUPER,9,workspace,09"
      "SUPER,0,workspace,10"

      # Move Workspace
      "SUPERSHIFT,1,movetoworkspacesilent,01"
      "SUPERSHIFT,2,movetoworkspacesilent,02"
      "SUPERSHIFT,3,movetoworkspacesilent,03"
      "SUPERSHIFT,4,movetoworkspacesilent,04"
      "SUPERSHIFT,5,movetoworkspacesilent,05"
      "SUPERSHIFT,6,movetoworkspacesilent,06"
      "SUPERSHIFT,7,movetoworkspacesilent,07"
      "SUPERSHIFT,8,movetoworkspacesilent,08"
      "SUPERSHIFT,9,movetoworkspacesilent,09"
      "SUPERSHIFT,0,movetoworkspacesilent,10"
    ];
      # ++ (
      #   # workspaces
      #   # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      #   builtins.concatLists (builtins.genList (
      #       x: let
      #         ws = let
      #           c = (x + 1) / 10;
      #         in
      #           builtins.toString (x + 1 - (c * 10));
      #       in [
      #         "$mod, ${ws}, workspace, ${toString (x + 1)}"
      #         "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 0)}"
      #       ]
      #     )
      #     10)
      # );
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


  programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
  };


}
