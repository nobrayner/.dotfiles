{ config, lib, pkgs, ... }:

{

  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/zorua/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;

    userName = "Braydon Hall";
    userEmail = "40751395+nobrayner@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

}
