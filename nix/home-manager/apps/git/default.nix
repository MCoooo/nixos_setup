{ cfg, pkgs, ...} : {

  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/dave/.ssh/id_ed25519.pub}";

  programs = {
    git = {
      enable = true;
      userName = "mcoooo";
      userEmail = "68328255+MCoooo@users.noreply.github.com";

      extraConfig = {
	# Sign all commits using ssh key
	commit.gpgsign = true;
	gpg.format = "ssh";
	gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
	user.signingkey = "~/.ssh/id_ed25519.pub";
      };

    };

  };
}
