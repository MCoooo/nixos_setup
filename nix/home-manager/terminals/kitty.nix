
{
  config,
  lib,
  ...
}: {
    programs.kitty = {
      enable = true;
      font = {
          size = 14;
          name = "Fira Code Nerd Font";
    };
     theme = "Gruvbox Material Dark Hard";
     shellIntegration.enableZshIntegration = true;
  };
}
