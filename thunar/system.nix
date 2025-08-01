{ config, lib, pkgs, ... }:

{

    programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
            thunar-archive-plugin
        ];
    };

    programs.xfconf.enable = true;

    services.gvfs.enable = true;
    services.tumbler.enable = true;

}
