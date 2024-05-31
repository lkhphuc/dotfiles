return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        wezterm = { enabled = true, font = "+2" },
      },
    },
    cmd = "ZenMode",
    keys = { { "<leader>wz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
  },
  {
    "sindrets/winshift.nvim",
    opts = {},
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
      { "<Home>", "<Cmd>SmartCursorMoveLeft<CR>", mode = { "n", "t" } },
      { "<C-End>", "<Cmd>SmartCursorMoveDown<CR>", mode = { "n", "t" } },
      { "<C-Home>", "<Cmd>SmartCursorMoveUp<CR>", mode = { "n", "t" } },
      { "<End>", "<Cmd>SmartCursorMoveRight<CR>", mode = { "n", "t" } },
      { "<leader>wr", "<Cmd>SmartResizeMode<CR>", mode = "n", desc = "Resize mode" },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    keys = {
      {
        "<leader>wp",
        function()
          local winnr = require("window-picker").pick_window()
          if winnr ~= nil then vim.api.nvim_set_current_win(winnr) end
        end,
        desc = "Pick window",
      },
    },
    opts = {
      show_prompt = false,
      hint = "floating-big-letter",
      filter_rules = {
        bo = { filetype = { "incline", "noice" } },
      },
    },
  },
  {
    "hydra.nvim",
    opts = {
      windows = {
        name = "Windows",
        hint = [[
 ^^^^^^^^^^^^     Move      ^^     Split
 ^^^^^^^^^^^^-------------  ^^------------------------------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   _p_: pick       _s_,_-_: horizontally 
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _r_: resize     _v_,_|_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   _=_: equalize   _c_,_d_: close
 focus^^^^^^  window^^^^^^  _z_: maximize   _o_: remain only
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   
]],
        config = {
          invoke_on_body = true,
          hint = {
            offset = -1,
          },
        },
        mode = "n",
        body = "<leader>w",
        heads = {
          { "h", "<C-w>h" },
          { "j", "<C-w>j" },
          { "k", "<C-w>k" },
          { "l", "<C-w>l" },

          { "H", "<CMD>WinShift left<CR>" },
          { "J", "<CMD>WinShift down<CR>" },
          { "K", "<CMD>WinShift up<CR>" },
          { "L", "<CMD>WinShift right<CR>" },

          { "s", "<CMD>split<CR>" },
          { "-", "<CMD>split<CR>", { desc = false } },
          { "v", "<CMD>vsplit<CR>" },
          { "|", "<CMD>vsplit<CR>", { desc = false } },
          { "o", "<C-w>o", { exit = true, desc = "remain only" } },
          { "z", "<CMD>ZenMode<CR>", { exit = true, desc = "maximize" } },

          { "w", "<C-w>w", { exit = true, desc = false } },

          { "p", "<leader>wp", { remap = true, exit = true, desc = "pick" } },
          { "r", "<CMD>SmartResizeMode<CR>", { exit = true, desc = "resize" } },
          { "=", "<C-w>=", { nowait = true, exit = false, desc = "equalize" } },
          { "c", "<Cmd>close<CR>", { desc = "close window" } },
          { "d", "<Cmd>close<CR>", { desc = "close window" } },
          { "<C-c>", "<Cmd>close<CR>", { desc = false } },

          { "<Esc>", nil, { exit = true, desc = false } },
        },
      },
    },
  },
}
