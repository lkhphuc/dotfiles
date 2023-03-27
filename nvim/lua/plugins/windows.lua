return {
  { "folke/zen-mode.nvim",
    config = true,
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    dependencies = { "folke/twilight.nvim", config = true },
  },
  { "sindrets/winshift.nvim",
    cmd = "WinShift",
    opts = { highlight_moving_win = true },
    keys = { "<leader>wS", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" }
  },
  { "kwkarlwang/bufresize.nvim", opts = {}, event = "WinEnter" }, -- on terminal resize
  { "numToStr/Navigator.nvim", opts = {},
    keys = {
      { "<C-j>", "<CMD>NavigatorDown<CR>" },
      { "<C-k>", "<CMD>NavigatorUp<CR>" },
      { "<C-h>", "<CMD>NavigatorLeft<CR>" },
      { "<C-l>", "<CMD>NavigatorRight<CR>" },
      { "<C-w>w", "<CMD>NavigatorPrevious<CR>" },
    }
  },
  { "mrjones2014/smart-splits.nvim",
    keys = { -- Combine with nostalgic-term.nvim for terminal mapping
      { "<A-j>", "<CMD>SmartResizeDown<CR>" },
      { "<A-k>", "<CMD>SmartResizeUp<CR>" },
      { "<A-h>", "<CMD>SmartResizeLeft<CR>" },
      { "<A-l>", "<CMD>SmartResizeRight<CR>" },
    },
    opts = {
      resize_mode = { hooks = { on_leave = function() require("bufresize").register() end, }, },
    },
  },
}
