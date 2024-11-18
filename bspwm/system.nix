{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lightdm
  ];

  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      displayManager = {
        lightdm = {
          enable = true;
          background = ./background.png;
        };
        session = [
          {
            manage = "window";
            name = "bspwm";
            start = ''
              bspwm &amp;
              waitPID=$!
            '';
          }
        ];
      };
    };
  };
  
}
