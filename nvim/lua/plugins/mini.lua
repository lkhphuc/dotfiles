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
      f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
      o = spec_treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }, {}),
      -- t = spec_treesitter({ a = "@block.outer", i = "@block.inner" }, {}),
      N = { '%f[%d]%d+' },  -- Numbers
    },
  })

  local map_navigate = function(text_obj, desc)
    for _, side in ipairs({ "left", "right" }) do
      for dir, d in pairs({ prev = "[", next = "]" }) do
        local lhs = d .. (side == "right" and text_obj:upper() or text_obj:lower())
        for _, mode in ipairs({ "n", "x", "o" }) do
          vim.keymap.set(mode, lhs, function()
            require("mini.ai").move_cursor(side, "a", text_obj, { search_method = dir })
          end, {
            desc = dir .. " " .. desc,
          })
        end
      end
    end
  end
  map_navigate("f", "function")
  map_navigate("c", "class")
  map_navigate("o", "block")

  require("mini.align").setup({})


  local animate = require("mini.animate")
  local mouse_scrolled = false
  for _, scroll in ipairs({ "Up", "Down" }) do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set("", key, function()
      mouse_scrolled = true
      return key
    end, { remap = true, expr = true })
  end

  vim.go.winwidth = 20
  vim.go.winminwidth = 5
  animate.setup({
    scroll = {
      timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      subscroll = animate.gen_subscroll.equal({
        predicate = function(total_scroll)
          if mouse_scrolled then
            mouse_scrolled = false
            return false
          end
          return total_scroll > 1
        end,
      }),
    },
  })


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
      starter.sections.recent_files(5, true, true),
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
