local M = {
  'anuvyklack/hydra.nvim', event = "VeryLazy",
  dependencies = 'anuvyklack/vim-smartword',
}

function M.config()
  require("plugins.hydra.options").setup()
  require("plugins.hydra.windows").setup()
  require("plugins.hydra.git").setup()
  require("plugins.hydra.telescope").setup()
  -- require("plugins.hydra.word").setup()
end
return M
