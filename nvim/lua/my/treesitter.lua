-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "lua", "bash", "vim", "comment", "make", "regex", "yaml", "toml"},
  highlight = {  -- Consistent syntax highlighting
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "+",  -- Hold Shift with 2 keys next to Del
  --     node_incremental = "+",  -- to start and increase selection
  --     node_decremental = "_",  -- or decrease selection per node,
  --     scope_incremental = "`-",  -- or per scope TODO disable this to nomapping
  --   },
  -- },
  textsubjects = {
    enable = true,
    prev_selection = '_', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['+'] = 'textsubjects-smart',
      ['a;'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  -- indent = { enable = true, },
  yati = { enable = true },
  autopair = { enable = true },
  rainbow = { enable = true, },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
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
      border = 'double',
      peek_definition_code = {
        ["<leader>k"] = "@function.outer",
        ["<leader>K"] = "@class.outer",
      },
    },
  },

  matchup = {
    enable = true,
    include_match_words = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,  -- Let comment plugin handles it
  },
  pyfold = {
    enable = true,
    custom_foldtext = true,
  }
}
