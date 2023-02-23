local side_scroll = {
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
}

local buffers = {
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
    { "h", "<cmd>BufferLineCyclePrev<Cr>", { desc = "choose left", on_key = false } },
    { "l", "<cmd>BufferLineCycleNext<Cr>", { desc = "choose right", on_key = false } },

    { "H", "<cmd>BufferLineMovePrev<Cr>", { desc = "move left" } },
    { "L", "<cmd>BufferLineMoveNext<Cr>", { desc = "move right" } },

    { "p", "<cmd>BufferLinePick<Cr>", { desc = "Pick" } },

    { "P", "<Cmd>BufferLineTogglePin<Cr>", { desc = "pin" } },

    { "b", "<Cmd>Telescope buffers<CR>", { desc = "fuzzy pick " } },

    { "d", function() require("mini.bufremove").delete(0, false) end, { desc = "close" } },
    { "q", function() require("mini.bufremove").unshow(0) end, { desc = "unshow" } },
    { "c", "<Cmd>BufferLinePickClose<CR>", { desc = "Pick close" } },

    { "sd", "<Cmd>BufferLineSortByDirectory<CR>", { desc = "by directory" } },
    { "se", "<Cmd>BufferLineSortByExtension<CR>", { desc = "by extension" } },
    { "st", "<Cmd>BufferLineSortByTabs<CR>", { desc = "by tab" } },
    { "<Esc>", nil, { exit = true } },
  },
}

return {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  opts = { buffers, side_scroll },
  config = function(_, opts)
    for _, head in ipairs(opts) do
      require("hydra")(head)
    end
  end,
}
