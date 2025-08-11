{ inputs, config, pkgs, ... }:

{

  home.file.".local/bin/tmux-sessionizer".source = ./bin/tmux-sessionizer;

}
