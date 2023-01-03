return {
  { 's1n7ax/nvim-window-picker',
    config = { show_prompt = false, use_winbar = 'smart', },
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<CMD>Neotree toggle<CR>", desc = "NeoTree", },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- Undo tree
  { "simnalamburt/vim-mundo",
    keys = {{"<leader>uu", "<cmd>MundoToggle<CR>", desc = "Undo"}},
  },

  -- Symbol outline
  { "simrat39/symbols-outline.nvim",
    keys = { { "<leader>ls", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },


}
