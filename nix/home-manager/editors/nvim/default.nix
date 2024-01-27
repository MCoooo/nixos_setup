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

      luasnip = {
        enable = true;
      };
      #
      cmp-nvim-lua = {
        enable = true;
      };

       lspkind = {
        enable = true;
        cmp.ellipsisChar = "...";
        cmp.menu = {
          buffer = "[Buffer]";
          nvim_lsp = "[LSP]";
          luasnip = "[LuaSnip]";
          nvim_lua = "[Lua]";
          latex_symbols = "[Latex]";
        };
        cmp.after = ''
        function(entry, vim_item, kind)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "   " .. strings[2]
        return kind
        end
        '';
      };

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        mappingPresets = [ "insert" ];
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];
        snippet = {
          expand = "luasnip";
        };
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
        # mapping = {
        #   "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        #   "<C-f>" = "cmp.mapping.scroll_docs(4)";
        #   "<C-Space>" = "cmp.mapping.complete()";
        #   "<C-e>" = "cmp.mapping.close()";
        #   "<Tab>" = {
        #     modes = ["i" "s"];
        #     action = "cmp.mapping.select_next_item()";
        #   };
        #   "<S-Tab>" = {
        #     modes = ["i" "s"];
        #     action = "cmp.mapping.select_prev_item()";
        #   };
        #   "<C-s>" = "cmp.mapping.confirm({ select = true })";
        # };
      };
      lsp = {
        enable = true;
        servers = {
          tsserver = {
            enable = true;
          };
          # lua-ls = {
          #   enable = true;
          #   settings.telemetry.enable = false;
          # };
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
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = comment-nvim;
        config = "lua require(\"Comment\").setup()";
      }
    ];
  };
}
