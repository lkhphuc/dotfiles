-- plugins that provide apis for other plugins
return {
  'nvim-lua/popup.nvim',
  'stevearc/dressing.nvim',
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  { 'rcarriga/nvim-notify',
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      level = vim.log.levels.INFO,
      fps = 20,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_option(win, "winblend", 20) end,
    },
  }
}
