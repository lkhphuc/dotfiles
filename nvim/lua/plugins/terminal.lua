return {

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
    int = function()
      vim.g.neomux_win_num_status = ""
      vim.g.neomux_start_term_map = "<leader>ft" -- FIX:doesn't work
      vim.g.neomux_winswap_map_prefix = "<leader>ws"
      vim.g.neomux_term_sizefix_map = "<leader>wf"
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
          return 20
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
}
