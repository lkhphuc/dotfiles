return {
  { "tpope/vim-fugitive", cmd = "G" }, -- Git commands in nvim
  -- 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  { "sindrets/diffview.nvim", event = "CmdlineEnter" },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "契" },
          topdelete = { text = "契" },
          changedelete = { text = "▎" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Text object
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "git hunk", buffer = bufnr })

          -- Navigation
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

          require("which-key").register({
            ["]c"] = { next_hunk, "change", expr = true },
            ["[c"] = { prev_hunk, "change", expr = true },
            ["<leader>g"] = {
              s = { gs.stage_hunk, "stage" },
              r = { gs.reset_hunk, "reset" },
              u = { gs.undo_stage_hunk, "undo" },
              p = { gs.preview_hunk, "preview" },
              S = { gs.stage_buffer, "stage buffer" },
              R = { gs.reset_buffer, "reset buffer" },
              b = { function() gs.blame_line({ full = false }) end, "blame message" },
              B = { function() gs.blame_line({ full = true }) end, "blame full" },
              d = { gs.diffthis, "diff with index" },
              D = { function() gs.diffthis("~") end, "diff with last commit" },
              h = { "<Cmd>DiffviewFileHistory %<CR>", "file history" },
              H = { "<Cmd>DiffviewFileHistory <CR>", "Commit history" },
            },
            ["<leader>gt"] = {
              name = "toggle",
              b = { gs.toggle_current_line_blame, "blame" },
              d = { gs.toggle_deleted, "deleted" },
            },
            ["<leader>gf"] = {
              name = "find",
              s = { "<cmd>Telescope git_status<cr>", "Open changed file" },
              b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
              c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            },
            ["<leader>gg"] = { "<cmd>tabnew term://lazygit<CR>", "LazyGit" },
          }, { buffer = bufnr })

          require("hydra")({
            name = "Git",
            hint = [[
   _J_: next hunk    _s_: stage hunk    _S_: stage buffer  _b_: blame line
   _K_: prev hunk    _r_: reset hunk    _R_: reset buffer  _B_: blame show full
   _/_: base file    _u_: undo stage    _p_: preview hunk  _d_: show deleted 
   _h_: file history _H_: files history
   ^
   ^ ^ _D_: Diff View         _<Enter>_: LazyGit         _<Esc>_: exit
            ]],
            config = {
              color = "pink",
              invoke_on_body = true,
              hint = {
                border = "rounded",
              },
              on_enter = function()
                vim.cmd("silent! %foldopen!")
                vim.bo.modifiable = false
                gs.toggle_linehl(true)
                gs.toggle_numhl(true)
                gs.toggle_word_diff(true)
                gs.toggle_current_line_blame(true)
              end,
              on_exit = function()
                gs.toggle_linehl(false)
                gs.toggle_numhl(false)
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
              { "d", gs.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
              { "h", "<CMD>DiffviewFileHistory %<CR>", { exit = true, desc = "File history" } },
              { "H", "<CMD>DiffviewFileHistory <CR>", { exit = true, desc = "Files history" } },
              { "b", gs.blame_line, { desc = "blame" } },
              {
                "B",
                function() gs.blame_line({ full = true }) end,
                { desc = "blame show full" },
              },
              { "/", gs.show, { exit = true, desc = "show base file" } }, -- show the base of the file
              { "<Enter>", ":tabnew term://lazygit<CR>", { exit = true, desc = "LazyGit" } },
              { "D", "<Cmd>DiffviewOpen<CR>", { exit = true, desc = "Open Diffview" } },
              { "<Esc>", nil, { exit = true, nowait = true, desc = "exit" } },
            },
          })
        end,
      }
    end,
  },
}