return {
  {
    "dlyongemallo/diffview-plus.nvim",
    dependencies = { { "rickhowe/diffchar.vim"}, },
    keys = {
      { "<leader>gC", "<Cmd>DiffviewFileHistory %<CR>", desc = "Current File history" },
      { "<leader>gc", "<Cmd>DiffviewFileHistory <CR>", desc = "Commit history" },
      { "<leader>gv", "<Cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { explorer = { view_mode = "tree" } },
    cmd = "CodeDiff",
    keys = {
      { "<leader>gV", "<Cmd>CodeDiff<CR>", desc = "Git code Diff View" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = { untracked = { text = "┊"}},
      current_line_blame_opts = { virt_text_pos = 'right_align'},
      attach_to_untracked = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

        map("n", "<leader>gtb", gs.toggle_current_line_blame, "blame virtual text")
        map("n", "<leader>gtd", gs.toggle_deleted, "deleted virtual text")
        map("n", "<leader>gtl", gs.toggle_linehl, "line highlight")
        map("n", "<leader>gtn", gs.toggle_numhl, "line number highlight")
        map("n", "<leader>gts", gs.toggle_signs, "signs column")
        map("n", "<leader>gtw", gs.toggle_word_diff, "word diff")
        map("n", "<leader>gT", function () gs.toggle_deleted() gs.toggle_word_diff() end, "Toggle diff mode")
      end,
    },
  },
}
