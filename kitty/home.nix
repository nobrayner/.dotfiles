{ config, lib, pkgs, ... }:

{

  programs.kitty = {

    enable = true;
    settings = {
      
      confirm_os_window_close = 0;

      # Fonts
      font_family = "JetBrains Mono";
      bold_font = "JetBrains Mono Bold";
      italic_font  = "JetBrains Mono Italic";
      bold_italic_font = "JetBrains Mono Bold Italic";
      font_size  = "12.0";
      disable_ligatures = "cursor";

      background_opacity = "0.6";

      # Colors
      foreground = "#d8dee9";
      # background = "#2e3440";
      background = "#000000";
      selection_foreground = "#000000";
      selection_background = "#4c566a";
      cursor = "#d8dee9";
      # black
      color0 = "#3B4252";
      color8 = "#4C566A";
      # red
      color1 = "#BF616A";
      color9 = "#BF616A";
      # green
      color2 = "#A3BE8C";
      color10= "#A3BE8C";
      # yellow
      color3 = "#EBCB8B";
      color11= "#EBCB8B";
      # blue
      color4 = "#81A1C1";
      color12= "#81A1C1";
      # magenta
      color5 = "#B48EAD";
      color13= "#B48EAD";
      # cyan
      color6 = "#88C0D0";
      color14= "#8FBCBB";
      # white
      color7 = "#E5E9F0";
      color15= "#ECEFF4";

      #map ctrl+shift+plus change_font_size current +1.0
      #map ctrl+shift+minus change_font_size current -1.0
      #map ctrl+shift+0 change_font_size current 0

    };

  };
  
}
