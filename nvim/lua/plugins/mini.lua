local M = {
  "echasnovski/mini.nvim",
  lazy = false,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.config()

  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  require("mini.ai").setup({
    n_lines = 500,
    custom_textobjects = {
      F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
      o = spec_treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }, {}),
      t = spec_treesitter({ a = "@block.outer", i = "@block.inner" }, {}),
    },
  })


  require("mini.align").setup({})


  require("mini.animate").setup()


  require("mini.bufremove").setup({})
  vim.keymap.set("n", "<leader>bd", MiniBufremove.delete, { desc = "Delete buffer" })
  vim.keymap.set("n", "<leader>bu", MiniBufremove.unshow, { desc = "Unshow buffer" })


  require("mini.comment").setup({
    hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  })


  require("mini.cursorword").setup({})


  require("mini.indentscope").setup({
    symbol = "▏", -- '╎', "▏", "│", "┊", "┆",
  }) -- also define ai/ii object


  require("mini.jump").setup({})


  local map = require("mini.map")
  map.setup({
    symbols = {
      encode = map.gen_encode_symbols.dot("4x2"),
    },
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.gitsigns(),
      map.gen_integration.diagnostic(),
    },
    window = {
      show_integration_count = false,
    },
  })
  vim.keymap.set("n", "<Leader>mc", MiniMap.close, { desc = "Map close." })
  vim.keymap.set("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "Map focus" })
  vim.keymap.set("n", "<Leader>mr", MiniMap.refresh, { desc = "Map refresh" })
  vim.keymap.set("n", "<Leader>ms", MiniMap.toggle_side, { desc = "Map switch side" })
  vim.keymap.set("n", "<Leader>mm", MiniMap.toggle, { desc = "Map Toggle" })


  require("mini.pairs").setup({})

  local starter = require("mini.starter")
  starter.setup({
    items = {
      starter.sections.builtin_actions(),
      starter.sections.telescope(),
      starter.sections.recent_files(),
      starter.sections.sessions(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center"),
    },
  })

  require('mini.surround').setup({
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = ']s',
      find_left = '[s',
      highlight = '',
      replace = 'cs',
      update_n_lines = '',
    },
    search_method = 'cover_or_next',
    n_lines = 50,
  })

  -- Remap adding surrounding to Visual mode selection
  vim.api.nvim_del_keymap('x', 'ys')
  vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

  -- Make special mapping for "add surrounding for line"
  vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })

  require("mini.trailspace").setup({})
  vim.keymap.set("n", "<leader>mt", MiniTrailspace.trim, { desc = "Trim trailing whitespace." })
end

return M
