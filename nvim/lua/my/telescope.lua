local telescope = require "telescope"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"]      = actions.cycle_history_next,
        ["<C-p>"]      = actions.cycle_history_prev,

        ["<C-j>"]      = actions.move_selection_next,
        ["<C-k>"]      = actions.move_selection_previous,

        ["<C-c>"]      = actions.close,

        ["<Down>"]     = actions.move_selection_next,
        ["<Up>"]       = actions.move_selection_previous,

        ["<CR>"]       = actions.select_default,
        ["<C-x>"]      = actions.select_horizontal,
        ["<C-v>"]      = actions.select_vertical,
        ["<C-t>"]      = actions.select_tab,

        ["<C-u>"]      = actions.preview_scrolling_up,
        ["<C-d>"]      = actions.preview_scrolling_down,

        ["<PageUp>"]   = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"]      = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"]    = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"]      = actions.complete_tag,
        ["<C-_>"]      = actions.which_key, -- keys from pressing <C-/>
        ["<C-f>"]      = actions.to_fuzzy_refine,
      },

      n = {
        ["<esc>"]      = actions.close,
        ["<CR>"]       = actions.select_default,
        ["<C-x>"]      = actions.select_horizontal,
        ["<C-v>"]      = actions.select_vertical,
        ["<C-t>"]      = actions.select_tab,

        ["<Tab>"]      = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"]    = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"]          = actions.move_selection_next,
        ["k"]          = actions.move_selection_previous,
        ["H"]          = actions.move_to_top,
        ["M"]          = actions.move_to_middle,
        ["L"]          = actions.move_to_bottom,

        ["<Down>"]     = actions.move_selection_next,
        ["<Up>"]       = actions.move_selection_previous,
        ["gg"]         = actions.move_to_top,
        ["G"]          = actions.move_to_bottom,

        ["<C-u>"]      = actions.preview_scrolling_up,
        ["<C-d>"]      = actions.preview_scrolling_down,

        ["<PageUp>"]   = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"]          = actions.which_key,
      },
    },
    layout_strategies = 'flex',
    layout_config = {
      cursor = {
        widht = 0.6,
      }
    }
  },
  pickers = {
    grep_string = { theme = "dropdown" },
    find_files = { theme = "dropdown", },
    buffers = { theme = "dropdown", },
    current_buffer_fuzzy_find = { theme = "ivy", },
    live_grep = { },
    colorscheme = { theme = "dropdown", },
    lsp_references = { theme = "dropdown" },
    lsp_definitions = { theme = "dropdown" }
  },
  extensions = {
    fzf = {}
  },
}

telescope.load_extension('fzf')

require("which-key").register({["<leader>s"] = {name = "Search" }})
vim.keymap.set("n", "<leader>*", builtin.grep_string, { desc = "Cursor word"})
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers"})
vim.keymap.set("n", "<leader>f", builtin.find_files,{ desc = "Files"})
vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Live grep workspace"})
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy buffer"})
vim.keymap.set("n", "<leader>sC", builtin.colorscheme, { desc = "Find colorschemes"})
vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Find command"})
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Find Help"})
vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "Man Page"})
vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "Recent"})
vim.keymap.set("n", "<leader>sR", builtin.registers, { desc = "Registers"})
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps"})
vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Jumplist"})
vim.keymap.set("n", "<leader>sn", builtin.resume, { desc = "Continue next search"})
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Telescope Pickers"})
