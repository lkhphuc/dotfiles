local M = {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { 'LukasPietzschmann/telescope-tabs', config = true },
  }
}

function M.config()
  local telescope = require "telescope"
  local actions = require "telescope.actions"
  local builtin = require "telescope.builtin"
  local trouble = require "trouble.providers.telescope"

  telescope.setup {
    defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"]   = actions.move_selection_previous,

          ["<CR>"]  = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"]   = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          -- ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-x>"]   = trouble.open_with_trouble,
          ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"]   = actions.complete_tag,
          ["<C-_>"]   = actions.which_key, -- keys from pressing <C-/>
          ["<C-f>"]   = actions.to_fuzzy_refine,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"]  = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-x>"]   = trouble.open_with_trouble,
          ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"]   = actions.move_selection_previous,
          ["gg"]     = actions.move_to_top,
          ["G"]      = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"]   = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
      layout_strategies = 'flex',
      layout_config = {}
    },
    pickers = {
      grep_string = { theme = "dropdown" },
      find_files = { theme = "dropdown", },
      buffers = {
        theme = "dropdown",
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          }
        }
      },
      current_buffer_fuzzy_find = { theme = "ivy", },
      live_grep = {},
      colorscheme = { theme = "dropdown", enable_preview = true },
      lsp_references = { theme = "dropdown", show_line = false },
      lsp_definitions = { theme = "dropdown" }
    },
    extensions = {
      fzf = {},
      file_browser = {
        theme = "ivy",
      }
    },
  }

  telescope.load_extension('fzf')
  telescope.load_extension('file_browser')
  local fb = require("telescope").extensions.file_browser

  require("which-key").register({ ["<leader>s"] = { name = "Search" } })
  vim.keymap.set("n", "<leader>*", builtin.grep_string, { desc = "Cursor word" })
  vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>sf", fb.file_browser, { desc = "Browse files" })
  vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Files" })
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep [T]ext workspace" })
	vim.keymap.set("n", "<leader>st",
		"<cmd>Telescope grep_string search= theme=ivy <CR>", { desc = "Fuzzy grep workspace" }
	)
  vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy buffer" })
  vim.keymap.set("n", "<leader>sC", builtin.colorscheme, { desc = "[C]olorschemes" })
  vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[C]ommand" })
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[H]elp" })
  vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "[M]an Page" })
  vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Recent [O]ld files" })
  vim.keymap.set("n", "<leader>s\'", builtin.registers, { desc = "Registers" })
  vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[K]eymaps" })
  vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[J]umplist" })
  vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[M]arks" })
  vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[R]esume last search" })
  vim.keymap.set("n", "<leader>sp", builtin.builtin, { desc = "[P]ickers" })
  vim.keymap.set("n", "<leader>s?", builtin.search_history, { desc = "Search history" })
  vim.keymap.set("n", "<leader>s;", builtin.command_history, { desc = "Command history" })
  -- vim.keymap.set("n", "<leader>sP", builtin.projects, { desc = "Projects"})
  vim.keymap.set("n", "<leader>sO", builtin.vim_options, { desc = "Vim options" })
  vim.keymap.set("n", "<leader>s<Tab>", require('telescope-tabs').list_tabs, { desc = "Tabs" })
end

return M
