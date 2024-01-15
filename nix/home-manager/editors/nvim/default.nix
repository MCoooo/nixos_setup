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
        keymaps = {
          diagnostic = {
            "]d" = "goto_next";
            "[d" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gD = "declaration";
            gr = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
            "<leader>cr" = { action = "rename"; desc = "Rename"; };
            "<leader>ca" = { action = "code_action"; desc = "Show Code Actions"; };
          };
        }; 
      };
    };
    extraConfigLua =
      # lua
      ''
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        	border = "rounded",
        })

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        	callback = function()
        		require("lint").try_lint()
        	end,
        })
      '';
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = comment-nvim;
        config = "lua require(\"Comment\").setup()";
      }
    ];
  };
}
