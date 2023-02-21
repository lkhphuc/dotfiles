return {
  { "nvim-zh/colorful-winsep.nvim", config = true, event = "WinNew" },
  {
    "folke/zen-mode.nvim",
    config = true,
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    dependencies = { "folke/twilight.nvim", config = true },
  },
  { "sindrets/winshift.nvim", cmd = "WinShift", opts = { highlight_moving_win = true } },
  {
    "mrjones2014/smart-splits.nvim",
    dependencies = { "kwkarlwang/bufresize.nvim", opts = {} },
    keys = { -- Combine with nostalgic-term.nvim for terminal mapping
      { "<C-j>", "<CMD>SmartCursorMoveDown<CR>" },
      { "<C-k>", "<CMD>SmartCursorMoveUp<CR>" },
      { "<C-h>", "<CMD>SmartCursorMoveLeft<CR>" },
      { "<C-l>", "<CMD>SmartCursorMoveRight<CR>" },
      { "<A-j>", "<CMD>SmartResizeDown<CR>" },
      { "<A-k>", "<CMD>SmartResizeUp<CR>" },
      { "<A-h>", "<CMD>SmartResizeLeft<CR>" },
      { "<A-l>", "<CMD>SmartResizeRight<CR>" },
    },
    config = function()
      require("smart-splits").setup({
        resize_mode = {
          hooks = { on_leave = function() require("bufresize").register() end },
        },
      })

      require("hydra")({
        name = "Windows",
        hint = [[
  ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
  ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
  _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
  focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
  ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
  _<Space>_: pick buffer
           ]],
        config = {
          on_key = function() vim.wait(1) end,
          invoke_on_body = true,
          hint = {
            border = "rounded",
            offset = -1,
          },
        },
        mode = "n",
        body = "<leader>w",
        heads = {
          { "h", "<CMD>SmartCursorMoveLeft<CR>" },
          { "j", "<CMD>SmartCursorMoveDown<CR>" },
          { "k", "<CMD>SmartCursorMoveUp<CR>" },
          { "l", "<CMD>SmartCursorMoveRight<CR>" },

          { "H", "<Cmd>WinShift left<CR>" },
          { "J", "<Cmd>WinShift down<CR>" },
          { "K", "<Cmd>WinShift up<CR>" },
          { "L", "<Cmd>WinShift right<CR>" },

          { "<C-h>", "<CMD>SmartResizeLeft<CR>" },
          { "<C-j>", "<CMD>SmartResizeDown<CR>" },
          { "<C-k>", "<CMD>SmartResizeUp<CR>" },
          { "<C-l>", "<CMD>SmartResizeRight<CR>" },
          { "=", "<C-w>=", { desc = "equalize" } },

          { "s", "<C-w>s" },
          { "<C-s>", "<C-w><C-s>", { desc = false } },
          { "v", "<C-w>v" },
          { "<C-v>", "<C-w><C-v>", { desc = false } },

          { "w", "<C-w>w", { exit = true, desc = false } },
          { "<C-w>", "<C-w>w", { exit = true, desc = false } },

          { "z", "<Cmd>ZenMode<CR>", { exit = true, desc = "Zen mode" } },

          { "o", "<C-w>o", { exit = true, desc = "remain only" } },
          { "<C-o>", "<C-w>o", { exit = true, desc = false } },

          { "<Space>", "<CMD>BufferLinePick<CR>", { exit = true, desc = "choose buffer" } },

          { "c", vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]) },
          { "q", vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]), { desc = "close window" } },
          { "<C-q>", vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]), { desc = false } },
          { "<C-c>", vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]), { desc = false } },

          { "<Esc>", nil, { exit = true, desc = false } },
        },
      })
    end,
  },
}
