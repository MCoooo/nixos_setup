{pkgs, ...}: {

  imports = [
              ./keymaps.nix # My zsh and bash config
	      ./options.nix
	    ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

    plugins = {
      telescope = {
	enable = true;
	keymapsSilent = true;
	keymaps = {
	  "<C-p>" = {
	    action = "git_files";
	    desc = "Telescope Git Files";
	  };
	  "<leader>fd" = {
	    action = "fd";
	    desc = "Telescope fd";
	  };
	  "<leader>fg" = "live_grep";
	  "<leader>ff" = "find_files";
	  "<leader>." = "oldfiles";
	  "<leader>," = "buffers";
	};
	defaults = {
	  border = true;
	  layout_strategy = "horizontal";
	  layout_config = {
	    anchor = "center";
	    height = 0.75;
	    width = 0.5;
	    prompt_position = "bottom";
	  };
	};
      };
      nvim-cmp = {
	enable = true;
	autoEnableSources = true;
	sources = [
	  {name = "nvim_lsp";}
	  {name = "path";}
	  {name = "buffer";}
	  {name = "luasnip";}
	];

	mapping = {
	  "<CR>" = "cmp.mapping.confirm({ select = true })";
	  "<Tab>" = {
	    action = ''
	      function(fallback)
		if cmp.visible() then
		  cmp.select_next_item()
		elseif luasnip.expandable() then
		  luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
		  luasnip.expand_or_jump()
		elseif check_backspace() then
		  fallback()
		else
		  fallback()
		end
	      end
	    '';
	    modes = [ "i" "s" ];
	  };
	};
      };

      lsp = {
        enable = true;
        servers = {
          tsserver = {
	    enable = true;
	  };
	  lua-ls = {
	    enable = true;
	    settings.telemetry.enable = false;
	  };
	  rust-analyzer = {
	    enable = true;
	    installCargo = true;
	    installRustc = true;
	  };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
	{
	  plugin = comment-nvim;
	  config = "lua require(\"Comment\").setup()";
	}
    ];
  };
}
