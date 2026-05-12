{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        lightdm
    ];

    programs.i3lock = {
        enable = true;
        package = pkgs.i3lock-color;
    };

    security.pam.services.i3lock = {
        text = ''
            auth include login
        '';
    };
    security.pam.services.i3lock-color = {
        text = ''
            auth include login
        '';
    };

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
