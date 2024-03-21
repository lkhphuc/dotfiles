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
      signcolumn = true,
      _signs_staged_enable = false,
      numhl = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gU", gs.reset_buffer_index, "Undo all Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

        map("n", "<leader>gtb", gs.toggle_current_line_blame, "blame virtual text")
        map("n", "<leader>gtd", gs.toggle_deleted, "deleted virtual text")
        map("n", "<leader>gtl", gs.toggle_linehl, "line highlight")
        map("n", "<leader>gtn", gs.toggle_numhl, "line number highlight")
        map("n", "<leader>gts", gs.toggle_signs, "signs column")
        map("n", "<leader>gtw", gs.toggle_word_diff, "word diff")
      end,
    },
  },
  { "linrongbin16/gitlinker.nvim", cmd = "GitLink", opts = {} },
}
