return {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  init = function()
    require("hydra")({
      name = "Side scroll",
      mode = "n",
      body = "z",
      hint = "Side scroll",
      heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "half screen ←/→" } },
      },
    })

    require("hydra")({
      name = "Buffers",
      body = "<leader>b",
      -- hint = [[
      --        ^<-^  ^-> ^
      -- Cycle  ^_h_^ ^_l_^
      -- Move   ^_H_^ ^_L_^
      -- ]],
      config = {
        hint = { type = "window", border = "single" },
        invoke_on_body = true,
        on_key = function()
          -- Preserve animation
          vim.wait(200, function() vim.cmd("redraw") end, 30, false)
        end,
      },
      heads = {
        {
          "h",
          "<cmd>BufferLineCyclePrev<Cr>",
          { desc = "choose left", on_key = false },
        },
        {
          "l",
          "<cmd>BufferLineCycleNext<Cr>",
          { desc = "choose right", on_key = false },
        },
        {
          "H",
          "<cmd>BufferLineMovePrev<Cr>",
          { desc = "move left" },
        },
        {
          "L",
          "<cmd>BufferLineMoveNext<Cr>",
          { desc = "move right" },
        },
        { "p", "<cmd>BufferLinePick<Cr>", { desc = "Pick" } },
        { "P", "<Cmd>BufferLineTogglePin<Cr>", { desc = "pin" } },
        {
          "b",
          "<Cmd>Telescope buffers<CR>",
          { desc = "fuzzy pick " },
        },
        { "d", function() require("mini.bufremove").delete(0, false) end, { desc = "close" } },
        { "q", function() require("mini.bufremove").unshow(0) end, { desc = "unshow" } },
        {
          "c",
          "<Cmd>BufferLinePickClose<CR>",
          { desc = "Pick close" },
        },
        {
          "sd",
          "<Cmd>BufferLineSortByDirectory<CR>",
          { desc = "by directory" },
        },
        {
          "se",
          "<Cmd>BufferLineSortByExtension<CR>",
          { desc = "by extension" },
        },
        { "st", "<Cmd>BufferLineSortByTabs<CR>", { desc = "by tab" } },
        { "<Esc>", nil, { exit = true } },
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
        {
          "<Space>",
          "<CMD>BufferLinePick<CR>",
          {
            exit = true,
            desc = "choose buffer",
          },
        },

        { "c", vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]) },
        {
          "q",
          vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]),
          { desc = "close window" },
        },
        {
          "<C-q>",
          vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]),
          { desc = false },
        },
        {
          "<C-c>",
          vim.cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]),
          { desc = false },
        },
        {
          "<Esc>",
          nil,
          { exit = true, desc = false },
        },
      },
    })

    require("hydra")({
      name = "UI Options",
      hint = [[
  ^ ^        UI Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          border = "rounded",
          position = "middle",
        },
      },
      mode = { "n", "x" },
      body = "<leader>U",
      heads = {
        { "n", function() vim.o.number = not vim.o.number end, { desc = "number" } },
        {
          "r",
          function() vim.o.relativenumber = not vim.o.relativenumber end,
          { desc = "relativenumber" },
        },
        {
          "v",
          function()
            if vim.o.virtualedit == "all" then
              vim.o.virtualedit = "block"
            else
              vim.o.virtualedit = "all"
            end
          end,
          { desc = "virtualedit" },
        },
        { "i", function() vim.o.list = not vim.o.list end, { desc = "show invisible" } },
        { "s", function() vim.o.spell = not vim.o.spell end, { exit = true, desc = "spell" } },
        { "w", function() vim.o.wrap = not vim.o.wrap end, { desc = "wrap" } },
        {
          "c",
          function() vim.o.cursorline = not vim.o.cursorline end,
          { desc = "cursor line" },
        },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}
