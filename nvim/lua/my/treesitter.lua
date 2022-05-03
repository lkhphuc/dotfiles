-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "lua", "bash", "vim", "comment"},
  highlight = {
    enable = true, -- false will disable the whole extension
    -- use_languagetree = true,  -- What is this for?
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "+",
      scope_incremental = "=",
      node_decremental = "_",
    },
  },
  indent = { enable = true, },
  rainbow = { enable = true, },
  refactor = {
    highlight_definitions= { enable = true},
    -- highlight_current_scope = { enable = true},
    smart_rename = {
      enable = true,
      keymaps = { smart_rename = "<leader>Tn"}
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gd",
        list_definitions = "go",
        list_definitions_toc = "gO",
        goto_next_usage = "]u",
        goto_previous_usage = "[u",
      }
    }
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ai"] = "@block.outer",
        ["ii"] = "@block.inner",
        ["c"] = "@comment.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>kf"] = "@function.outer",
        ["<leader>kc"] = "@class.outer",
      },
    },
  },
  matchup = { enable = true },
  pyfold = {
    enable = true,
    custom_foldtext = true,
  }
}
