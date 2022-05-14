-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "lua", "bash", "vim", "comment", "make", "regex", "yaml", "toml"},
  highlight = {
    enable = true, -- false will disable the whole extension
    -- use_languagetree = true,  -- What is this for?
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",  -- Hold Shift with 2 keys next to Del 
      node_incremental = "+",  -- to start and increase selection
      node_decremental = "_",  -- or decrease selection per node,
      scope_incremental = "`-",  -- or per scope TODO disable this to nomapping
    },
  },
  indent = { enable = true, },
  autopair = { enable = true },
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

  --- { nvim-treesitter-textobjects
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
        ["c"] = "@comment.outer", -- There is no comment.inner
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
        ["]s"] = "@parameter.inner",
      },
      swap_previous = {
        ["[s"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'shadow',
      peek_definition_code = {
        ["<leader>k"] = "@function.outer",
        ["<leader>K"] = "@class.outer",
      },
    },
  },
  --- }

  matchup = {
    enable = true,
    include_match_words = true,
  },
  context_commentstring = {
    enable = true,
    -- enable_autocmd = false,  -- Let Comment.nvim handles
  },
  pyfold = {
    enable = true,
    custom_foldtext = true,
  }
}
