return {
  {
    "mtikekar/nvim-send-to-term",
    cmd = { "SendTo", "SendHere" },
    init = function()
      vim.g.send_disable_mapping = true -- dont use default
    end,
    keys = {
      { "<CR>", "<Plug>Send", mode = { "n", "v" }, desc = "Send" },
      { "<S-CR>", "vip<Plug>Send", desc = "Send", mode = "n" },
    },
  },
  {
    "romainchapou/nostalgic-term.nvim",
    event = "TermOpen",
    opts = { -- this extension doesn't override terminal app mapping
      mappings = {
        { "<C-l>", "l" },
        { "<C-h>", "h" },
        { "<C-j>", "j" },
        { "<C-k>", "k" },
      },
      enabled_filetypes = { "toggleterm" },
    },
  },
  {
    "nikvdp/neomux",
    event = "VeryLazy",
    init = function()
      vim.g.neomux_win_num_status = ""
      vim.g.neomux_winswap_map_prefix = "<leader>ws"
      vim.g.neomux_term_sizefix_map = "<leader>wf"
      vim.g.neomux_dont_fix_term_ctrlw_map = 1
    end,
  },
  {
    "voldikss/vim-floaterm",
    keys = "<Home>",
    init = function()
      vim.g.floaterm_keymap_next = "<End>" -- Hyper+o
      vim.g.floaterm_keymap_prev = "<S-End>" -- Hyper+Command+o
      vim.g.floaterm_keymap_new = "<S-Home>" -- Hyper+Command+i
      vim.g.floaterm_keymap_toggle = "<Home>" -- Hyper+i
      vim.g.floaterm_position = "center"
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.4
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      terminal_mapping = true,
      start_in_insert = false, -- nostalgic-term
    },
    cmd = "ToggleTerm",
    keys = { [[<C-\>]] },
  },
  {
    "chomosuke/term-edit.nvim",
    event = "TermOpen",
    version = "1.*",
  },
}
