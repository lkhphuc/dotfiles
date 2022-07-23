local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function ()
    require('which-key').register({["<leader>g"] = { name = "Git"}})
    vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>",               { desc = "Next hunk"         })
    vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>",               { desc = "Previous hunk"     })
    vim.keymap.set("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>",       { desc = "Next hunk"         })
    vim.keymap.set("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>",       { desc = "Previous hunk"     })
    vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns blame_line<cr>",      { desc = "Blame"             })
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",    { desc = "Preview Hunk"      })
    vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",      { desc = "Reset Hunk"        })
    vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>",    { desc = "Reset Buffer"      })
    vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>",      { desc = "Stage Hunk"        })
    vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage"        })
    vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",   { desc = "Diff"              })
    vim.keymap.set("n", "<leader>go", "<cmd>Telescope git_status<cr>",     { desc = "Open changed file" })
    vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>",   { desc = "Checkout branch"   })
    vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>",    { desc = "Checkout commit"   })
  end
}

local Hydra = require("hydra")

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: LazyGit              _q_: exit
]]
Hydra({
  name = 'Git',
  hint = hint,
  config = {
    buffer = bufnr,
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'rounded'
    },
    on_enter = function()
      vim.cmd('silent! %foldopen!')
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  mode = {'n','x'},
  body = '<leader>g',
  heads = {
    { 'J',
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'next hunk' } },
    { 'K',
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'prev hunk' } },
    { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
    { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
    { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
    { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
    { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
    { 'b', gitsigns.blame_line, { desc = 'blame' } },
    { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
    { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
    { '<Enter>', ':tabnew term://lazygit<CR>', { exit = true, desc = 'LazyGit' } },
    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
  }
})
