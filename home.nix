{ config, pkgs, ... }:

{
  imports = [
    ./bin.nix
    ./bspwm/home.nix
    ./kitty/home.nix
    ./starship/home.nix
    ./nvim/home.nix
    ./tmux/home.nix
    ./browser/home.nix
    ./git/home.nix
    ./jq/home.nix
    ./obs/home.nix
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zorua";
  home.homeDirectory = "/home/zorua";

  # ZSH
  programs.zsh.enable = true;
  home.file = {
    ".zshrc".source = ./zsh/.zshrc;
  };

  services.playerctld.enable = true;
  services.flameshot.enable = true;

  home.packages = with pkgs; [
    file
    fzf
    nodejs
    discord
    pnpm
    rustup
    gcc
    audacity
    pulseaudio
    playerctl
    tidal-hifi
    beekeeper-studio
    telegram-desktop
    gimp
    zip
    unzip
    mate.eom
    godot_4
    lm_sensors
    mgba
    tree
    libretro.citra
    httpie
    openssl
    imagemagick
    vlc
    htop
    gparted
    unrar
    samba
    ffmpeg
    git-ps-rs
    
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zorua/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
