local M = {
  'anuvyklack/hydra.nvim',
}

function M.config()
  require("plugins.hydra.options").setup()
  require("plugins.hydra.windows").setup()
  require("plugins.hydra.git").setup()
end
return M
