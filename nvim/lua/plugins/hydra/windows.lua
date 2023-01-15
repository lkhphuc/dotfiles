return {
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
    { "h", function() require("smart-splits").move_cursor_left() end },
    { "j", function() require("smart-splits").move_cursor_down() end },
    { "k", function() require("smart-splits").move_cursor_up() end },
    { "l", function() require("smart-splits").move_cursor_right() end },

    { "H", "<Cmd>WinShift left<CR>" },
    { "J", "<Cmd>WinShift down<CR>" },
    { "K", "<Cmd>WinShift up<CR>" },
    { "L", "<Cmd>WinShift right<CR>" },

    { "<C-h>", function() require("smart-splits").resize_left() end },
    { "<C-j>", function() require("smart-splits").resize_down() end },
    { "<C-k>", function() require("smart-splits").resize_up() end },
    { "<C-l>", function() require("smart-splits").resize_right() end },
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
}
