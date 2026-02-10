{ config, pkgsUnstable, ... }:

{

    home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/zorua/.ssh/id_ed25519.pub}";

    programs.git = {
        enable = true;

        settings = {
            user.name = "Braydon Hall";
            user.email = "40751395+nobrayner@users.noreply.github.com";
            user.signingkey = "~/.ssh/id_ed25519.pub";

            init.defaultBranch = "main";
            pull.rebase = true;
            commit.gpgsign = true;
            gpg.format = "ssh";
            gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
            gpg.ssh.program = "~/.dotfiles/git/ssh-keygen-agent";
        };
    };

    home.packages = with pkgsUnstable; [
        jujutsu
    ];
    home.file."./.config/jj/config.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/git/jj.toml";
    };

    programs.gh = {
        enable = true;

        settings = {
            git_protocol = "ssh";
            prompt = "enabled";
            aliases = {
                co = "pr checkout";
            };
            version = "1";
        };
    };

}
