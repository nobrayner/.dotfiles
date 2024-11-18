{ config, lib, pkgs, ... }:

{

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };

  programs.firefox = {
    enable = true;
  };

  home.packages = with pkgs; [
    microsoft-edge
  ];

}
