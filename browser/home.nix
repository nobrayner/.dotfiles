{ config, lib, pkgs, pkgsUnstable, ... }:

{

  programs.chromium = {
    enable = true;
    package = pkgsUnstable.ungoogled-chromium;
  };

  programs.firefox = {
    enable = true;
  };

  home.packages = with pkgs; [
    microsoft-edge
  ];

}
