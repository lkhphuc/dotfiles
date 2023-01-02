local M = {
  'anuvyklack/hydra.nvim', event = "VeryLazy",
  dependencies = 'anuvyklack/vim-smartword',
}

function M.config()
  local hydra = require "hydra"
  hydra({
    name = 'Side scroll',
    mode = 'n',
    body = 'z',
    hint = "Side scroll",
    heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
    }
  })
  require("plugins.hydra.options").setup()
  require("plugins.hydra.windows").setup()
  require("plugins.hydra.git").setup()
  -- require("plugins.hydra.telescope").setup()
  -- require("plugins.hydra.word").setup()
end
return M
