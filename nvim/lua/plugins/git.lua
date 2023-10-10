return {
  -- { "tpope/vim-fugitive", cmd = "G" }, -- Git commands in nvim
  {
    "sindrets/diffview.nvim",
    event = "BufEnter",
    keys = {
      { "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "file history" },
      { "<leader>gH", "<Cmd>DiffviewFileHistory <CR>", desc = "Commit history" },
      { "<leader>gv", "<Cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "🮇" },
        change = { text = "🮇" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "🮇" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        local next_hunk = function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end
        local prev_hunk = function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end
        map("n", "]c", next_hunk, "Next Hunk")
        map("n", "[c", prev_hunk, "Prev Hunk")

        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

        map("n", "<leader>gtb", gs.toggle_current_line_blame, "blame")
        map("n", "<leader>gtd", gs.toggle_deleted, "deleted")

        map("n", "<leader>gfs", "<cmd>Telescope git_status<cr>", "Open changed file")
        map("n", "<leader>gfb", "<cmd>Telescope git_branches<cr>", "Checkout branch")
        map("n", "<leader>gfc", "<cmd>Telescope git_commits<cr>", "Checkout commit")

        require("hydra")({
          name = "Git",
          hint = [[
   _J_: next hunk    _s_: stage hunk    _S_: stage buffer  _b_: blame line
   _K_: prev hunk    _r_: reset hunk    _R_: reset buffer  _B_: blame show full
   _/_: base file    _u_: undo stage    _p_: preview hunk  _d_: show deleted
   _h_: file history _H_: files history
   ^
   ^ ^ _v_: Diff View         _g_: LazyGit         _<Esc>_: exit
            ]],
          config = {
            color = "pink",
            invoke_on_body = true,
            hint = { border = "rounded" },
            on_enter = function()
              vim.cmd("silent! %foldopen!")
              vim.bo.modifiable = false
              gs.toggle_linehl(true)
              -- gs.toggle_numhl(true)
              gs.toggle_word_diff(true)
              gs.toggle_current_line_blame(true)
            end,
            on_exit = function()
              gs.toggle_linehl(false)
              -- gs.toggle_numhl(false)
              gs.toggle_word_diff(false)
              gs.toggle_current_line_blame(false)
              gs.toggle_deleted(false)
            end,
          },
          mode = { "n", "x" },
          body = "<leader>g",
          heads = {
            { "J", next_hunk, { expr = true, desc = "next hunk" } },
            { "K", prev_hunk, { expr = true, desc = "prev hunk" } },
            { "s", gs.stage_hunk, { desc = "stage hunk" } },
            { "u", gs.undo_stage_hunk, { desc = "undo last stage" } },
            { "r", gs.reset_hunk, { desc = "reset hunk" } },
            { "S", gs.stage_buffer, { desc = "stage buffer" } },
            { "R", gs.reset_buffer, { desc = "reset buffer" } },
            { "p", gs.preview_hunk, { desc = "preview hunk" } },
            { "d", gs.toggle_deleted, { nowait = true } },
            { "h", "<CMD>DiffviewFileHistory %<CR>", { exit = true } },
            { "H", "<CMD>DiffviewFileHistory <CR>", { exit = true } },
            { "b", gs.blame_line, { desc = "blame" } },
            { "B", function() gs.blame_line({ full = true }) end, },
            { "/", gs.show, { exit = true } }, -- show the base of the file
            { "g", function() require("lazyvim.util").float_term("lazygit") end, { exit = true }, },
            { "v", "<Cmd>DiffviewOpen<CR>", { exit = true } },
            { "<Esc>", nil, { exit = true, nowait = true } },
          },
        })
      end,
    },
  },
  {
    "linrongbin16/gitlinker.nvim",
    keys = { { "<leader>gl", desc = "Copy git link" }, { "<leader>gL", desc = "Open git link" } },
    opts = {
      custom_rules = function(remote_url)
        local pattern_rules = {
          {
            ["^git@es.naverlabs%.([_%.%-%w]+):([%.%-%w]+)/([%.%-%w]+)%.git$"] = "https://es.naverlabs.%1/%2/%3/blob/",
            ["^https://es.naverlabs%.([_%.%-%w]+)/([%.%-%w]+)/([%.%-%w]+)%.git$"] = "https://es.naverlabs.%1/%2/%3/blob/",
          },
        }
        for _, group in ipairs(pattern_rules) do
          for pattern, replace in pairs(group) do
            if string.match(remote_url, pattern) then
              local result = string.gsub(remote_url, pattern, replace)
              return result
            end
          end
        end
        return nil
      end,
    },
  },
}
