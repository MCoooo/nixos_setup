{
  programs.nixvim = {
    keymaps = [
      {
        action = "<C-d>zz";
        key = "<C-d>";
        options = {
          desc = "Keep cursor in middle when jumping";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<C-u>zz";
        key = "<C-e>";
        options = {
          desc = "Keep cursor in middle when jumping";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "mzJ`z";
        key = "J";
        options = {
          desc = "Combine line into one";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "nzzzv";
        key = "n";
        options = {
          desc = "Keep cursor in middle when searching";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "Nzzzv";
        key = "N";
        options = {
          desc = "Keep cursor in middle when searching";
        };
        mode = [
          "n"
        ];
      }
      # {
      #   action = "v:count == 0 ? 'gj' : 'j'";
      #   key = "j";
      #   options = {
      #     silent = true;
      #     expr = true;
      #   };
      #   mode = [
      #     "n"
      #   ];
      # }
      # {
      #   action = "v:count == 0 ? 'gk' : 'k'";
      #   key = "k";
      #   options = {
      #     silent = true;
      #     expr = true;
      #   };
      #   mode = [
      #     "n"
      #   ];
      # }
      {
        action = "<C-w>v";
        key = "<leader>|";
        options = {
          desc = "Split window right";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<C-w>s";
        key = "<leader>-";
        options = {
          desc = "Split window below";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>w<cr><esc>";
        key = "<C-s>";
        options = {
          desc = "Save file";
        };
        mode = [
          "n"
          "v"
          "x"
        ];
      }
      {
        action = "<cmd>w<cr><esc>";
        key = "<C-x><C-s>";
        options = {
          desc = "Save file";
        };
        mode = [
          "n"
          "v"
          "x"
        ];
      }
      {
        action = "<cmd>wq<cr>";
        key = "<C-x><C-s><C-x>";
        options = {
          desc = "Save file";
        };
        mode = [
          "n"
          "v"
          "x"
        ];
      }
      {
        action = "<cmd>q!<cr>";
        key = "<C-c><C-c><C-x>";
        options = {
          desc = "Save file";
        };
        mode = [
          "n"
          "v"
          "x"
        ];
      }
      {
        action = "'_dP";
        key = "<leader>p";
        options = {
          desc = "Paste without updating buffer";
        };
        mode = [
          "v"
        ];
      }
      {
        action = ">gv";
        key = ">";
        options = {
          desc = "Stay in visual mode during outdent";
        };
        mode = [
          "v"
          "x"
        ];
      }
      {
        action = "<gv";
        key = "<";
        options = {
          desc = "Stay in visual mode during indent";
        };
        mode = [
          "v"
          "x"
        ];
      }
      {
        action ="<esc>";
        key = "<C-c>";
        options = {
          desc = "Escape";
        };
        mode = [
          "v"
          "i"
        ];
      }
    ];
  };
}


