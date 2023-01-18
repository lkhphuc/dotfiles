return {

  { -- file tree
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<CMD>Neotree toggle<CR>", desc = "NeoTree" },
    },
    init = function() vim.g.neo_tree_remove_legacy_commands = 1 end,
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- file explorer
  { "stevearc/oil.nvim", cmd = "Oil", config = true },

  {
    "s1n7ax/nvim-window-picker",
    opts = { show_prompt = false, use_winbar = "smart" },
    keys = {
      {
        "<C-w>0",
        function()
          local win_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(win_id)
        end,
        { desc = "Pick a window" },
      },
    },
  },

  { -- Undo tree
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = { { "<leader>uu", "<cmd>MundoToggle<CR>", desc = "Undo" } },
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  { -- search/replace in multiple files
    "windwp/nvim-spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  {
    "echasnovski/mini.map",
    config = function()
      local map = require("mini.map")
      map.setup({
        symbols = {
          encode = require("mini.map").gen_encode_symbols.dot("4x2"),
        },
        integrations = {
          require("mini.map").gen_integration.builtin_search(),
          require("mini.map").gen_integration.gitsigns(),
          require("mini.map").gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      })
    end,
    keys = {
      { "<leader>mm", "<Cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap" },
      { "<leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", desc = "MiniMap" },
      { "<leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", desc = "MiniMap" },
    },
  },
  -- { "smjonas/live-command.nvim",
  --   opts = { commands = { Norm = { cmd = "norm" }, } }
  -- },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Trouble Toggle" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References (Trouble)" },
      { "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>", desc = "Definitions (Trouble)" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "QuickFix (Trouble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "LocationList (Trouble)" },
    },
  },

  {
    "mattboehm/vim-unstack",
    init = function() vim.g.unstack_mapkey = "<leader>uS" end,
    keys = { { "<leader>uS", "<Cmd>Unstack<CR>", desc = "Un-stack trace" } },
  },

  -- Terminal
  {
    "jpalardy/vim-slime",
    event = "TermOpen",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mapping = 1
      vim.keymap.set("n", "<S-CR>", "<Plug>SlimeSend")
      vim.keymap.set("x", "<S-CR>", "<Plug>SlimeRegionSend")
      -- vim.keymap.set("n", "<S-CR>", "<Plug>SlimeParagraphSend")
      -- vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell '>")
    end,
  },
  {
    "romainchapou/nostalgic-term.nvim",
    event = "TermOpen",
    config = true,
  },
  -- {  -- NOTE: currently use smart-splits
  --   "numToStr/Navigator.nvim",
  --   keys = {
  --     { "<C-h>", "<CMD>NavigatorLeft<CR>" },
  --     { "<C-l>", "<CMD>NavigatorRight<CR>" },
  --     { "<C-k>", "<CMD>NavigatorUp<CR>" },
  --     { "<C-j>", "<CMD>NavigatorDown<CR>" },
  --     { "<C-p>", "<CMD>NavigatorPrevious<CR>" },
  --   },
  --   config = true,
  -- },
  -- { "nikvdp/neomux", event = "VeryLazy",
  --   init = function()
  --     vim.g.neomux_win_num_status = ""
  --   end
  -- },
  {
    "voldikss/vim-floaterm",
    event = "VeryLazy",
    init = function()
      vim.g.floaterm_keymap_next = "<End>" -- Hyper+o
      vim.g.floaterm_keymap_prev = "<S-End>" -- Hyper+Command+o
      vim.g.floaterm_keymap_new = "<S-Home>" -- Hyper+Command+i
      vim.g.floaterm_keymap_toggle = "<Home>" -- Hyper+i
      vim.g.floaterm_position = "center"
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_autoinsert = false
    end,
  },
  -- {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
  --   require("toggleterm").setup()
  -- end},
}
