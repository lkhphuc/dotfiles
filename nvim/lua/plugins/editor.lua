return {
  { 's1n7ax/nvim-window-picker',
    opts = { show_prompt = false, use_winbar = 'smart', },
    keys = {
      { "<C-w>0",
        function()
          local win_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(win_id)
        end,
        { desc = "Pick a window" }
      }
    }
  },

  -- file explorer
  { "stevearc/oil.nvim", cmd = "Oil", config = true},

  -- file tree
  { "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<CMD>Neotree toggle<CR>", desc = "NeoTree", },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- Undo tree
  { "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = { { "<leader>uu", "<cmd>MundoToggle<CR>", desc = "Undo" } },
  },

  -- Symbol outline
  { "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>ls", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },


}
