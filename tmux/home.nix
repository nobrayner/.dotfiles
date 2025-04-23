{ config, lib, pkgs, ... }:

{

  home.file."./.config/tmux/plugins" = {
    source = ./plugins;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./.tmux.conf;
  };

}
