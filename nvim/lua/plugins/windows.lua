return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        wezterm = { enabled = true, font = "+2" },
      },
    },
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    dependencies = { "folke/twilight.nvim", opts = {} },
  },
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    opts = { highlight_moving_win = true },
    keys = { { "<leader>ws", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" } },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      -- these keymaps will also accept a range,
      { "<A-h>", "<Cmd>SmartResizeLeft<CR>", mode = { "n", "t" } },
      { "<A-j>", "<Cmd>SmartResizeDown<CR>", mode = { "n", "t" } },
      { "<A-k>", "<Cmd>SmartResizeUp<CR>", mode = { "n", "t" } },
      { "<A-l>", "<Cmd>SmartResizeRight<CR>", mode = { "n", "t" } },
      { "<C-h>", "<Cmd>SmartCursorMoveLeft<CR>", mode = { "n", "t" } },
      { "<C-j>", "<Cmd>SmartCursorMoveDown<CR>", mode = { "n", "t" } },
      { "<C-k>", "<Cmd>SmartCursorMoveUp<CR>", mode = { "n", "t" } },
      { "<C-l>", "<Cmd>SmartCursorMoveRight<CR>", mode = { "n", "t" } },
      { "<leader>wr", "<Cmd>SmartResizeMode<CR>", mode = "n", desc = "Resize mode" },
    },
  },
}
