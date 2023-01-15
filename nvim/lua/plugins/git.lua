return {
  "tpope/vim-fugitive", -- Git commands in nvim
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

          vim.keymap.set("v", "<leader>gs", "<Cmd>'<,'>Gitsigns stage_hunk<CR>", { desc = "stage" })
          vim.keymap.set("v", "<leader>gr", "<Cmd>'<,'>Gitsigns reset_hunk<CR>", { desc = "reset" })
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
              b = { function() gs.blame_line({ full = true }) end, "blame" },
              d = { gs.diffthis, "diff with index" },
              D = { function() gs.diffthis("~") end, "diff with last commit" },
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
        end,
      }
    end,
  },
}
