{ inputs, config, pkgs, ... }:

{

  home.packages = with pkgs; [lua51Packages.luarocks lua51Packages.lua];

  home.file."./.config/nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.neovim-unwrapped;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
  };

  programs.ripgrep.enable = true;
  programs.fd.enable = true;

}
