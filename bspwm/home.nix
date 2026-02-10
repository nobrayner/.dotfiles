{ pkgs, ... }:

{

    home.packages = with pkgs; [
        nitrogen
        xclip
        scrot
        imagemagick
    ];

    xsession.windowManager.bspwm.enable = true;

    # command to get the hash needed for fetchFromGitHub:
    # nix-shell -p nix-prefetch-git jq --run "nix hash to-sri sha256:\$(nix-prefetch-git --url https://github.com/ibhagwan/picom --quiet --rev c4107bb6cc17773fdc6c48bb2e475ef957513c7a | jq -r '.sha256')"

    services.sxhkd.enable = true;
    # services.screen-locker = {
    #   enable = lib.mkForce false;
    # };
    services.picom = {
        enable = true;

        settings = {
            experimental-backends = true;
            backend = "glx";
            glx-no-stencil = true;
            glx-no-rebind-pixmap = true;
            vsync = true;
            use-damage = false;

            corner-radius = 12;

            shadow = true;
            shadow-radius = 14;
            shadow-offset-x = -12;
            shadow-offset-y = -12;
            shadow-opacity = 0.8;
            shadow-red = 0.0;
            shadow-green = 0.0;
            shadow-blue = 0.0;
            shadow-exclude = [
                "name = 'stalonetray'"
                "name = 'plank'"
                "name = 'Notification'"
                "name = 'VirtualBox'"
                "class_g = 'pentablet'"
                "class_g = 'Polybar'"
                "class_g = 'Bspwm'"
                "class_i = 'presel_feedback'"
                "class_g ?= 'Notify-osd'"
                "class_g = 'Cairo-clock'"
                "class_i = 'POWERPNT.EXE'"
                "class_i = 'WINWORD.EXE'"
                "class_i = 'Meteo'"
                "class_i = 'motion_recorder'"
            ];
            shadow-ignore-shaped = false;

            active-opacity = 1.0;
            frame-opacity = 1.0;
            inactive-opacity-override = false;

            blur = {
                method = "dual_kawase";
                strength = 4;
                deviation = 1.0;
            };
            blur-background-exclude = [
                "class_g != 'i3lock' && class_g != 'Rofi'"
            ];

            wintypes = {
                menu = {
                    blur-background = false;
                    shadow = false;
                };
                popup_menu = {
                    opacity = 1.0;
                    blur-background = false;
                    shadow = false;
                };
                dropdown_menu = {
                    opacity = 1.0;
                    blur-background = false;
                    shadow = false;
                };
                splash = {
                    blur-background = false;
                    shadow = false;
                };
                combo = {
                    blur-background = false;
                    shadow = false;
                };
                dnd = {
                    shadow = false;
                };
                dock = {
                    shadow = false;
                };
                tooltip = {
                    fade = true;
                    shadow = false;
                    opacity = 1.0;
                    focus = true;
                    blur-background = false;
                };
            };

            # Fading
            fading = true;
            fade-delta = 5;
            fade-in-step = 0.02;
            fade-out-step = 0.02;
            fade-exclude = [];
        };
    };
    services.polybar = {
        enable = true;
        config = ./polybar/config.ini;
        script = ''
            polybar main &
        '';
    };

    programs.rofi.enable = true;

    # Disable the generated config files, as I already have existing dotfiles I want to use
    # These should be removed as config is switched over (or maybe I shouldn't?)
    xdg.configFile."bspwm/bspwmrc".enable = false;
    xdg.configFile."sxhkd/sxhkdrc".enable = false;
    xdg.configFile."rofi/config.rasi".enable = false;
    xdg.configFile."rofi/theme.rasi".enable = false;

    home.file.".config/bspwm/bspwmrc".source = ./bspwmrc;
    home.file.".config/sxhkd/sxhkdrc".source = ./sxhkdrc;

    # home.file.".config/polybar/config".source = ./polybar/config.ini;
    home.file.".config/polybar/launch.sh".source = ./polybar/launch.sh;
    home.file.".config/polybar/playing.sh".source = ./polybar/playing.sh;

    home.file.".config/rofi/config.rasi".source = ./rofi/config.rasi;
    home.file.".config/rofi/theme.rasi".source = ./rofi/theme.rasi;
    
}
