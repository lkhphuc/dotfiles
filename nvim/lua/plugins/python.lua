return {
  {
    "blueyed/semshi",
    branch = "handle-ColorScheme",
    ft = "python",
    build = "<Cmd>UpdateRemotePlugins<CR>",
    init = function()
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
    end,
  },
  -- 'AckslD/swenv.nvim',
  {
    "hanschen/vim-ipython-cell",
    ft = "python",
    init = function()
      vim.g.slime_python_ipython = 1
      vim.keymap.set(
        "n",
        "<leader>ri",
        "<Cmd>SlimeSend1 ipython --matplotlib --ext=autoreload<CR>",
        { desc = "Run interpreter" }
      )
      vim.keymap.set("n", "<leader>ra", "<Cmd>SlimeSend1 %autoreload 2<CR>", { desc = "Autoreload python module" })
      vim.keymap.set("n", "<leader>rd", "<Cmd>SlimeSend1 %debug<CR>", { desc = "Debug ipython" })
      vim.keymap.set("n", "<leader>re", "<Cmd>SlimeSend1 exit<CR>", { desc = "Exit" })
      vim.keymap.set("n", "<leader>rs", "<Cmd>IPythonCellRun<CR>", { desc = "Run script" })
      vim.keymap.set("n", "<leader>rS", "<Cmd>IPythonCellRunTime<CR>", { desc = "Run script and time it" })
      vim.keymap.set("n", "<leader>rc", "<Cmd>IPythonCellClear<CR>", { desc = "Clear IPython screen" })
      vim.keymap.set("n", "<leader>rx", "<Cmd>IPythonCellClose<CR>", { desc = "Close all matplotlib figure windows" })
      vim.keymap.set("n", "<leader>rp", "<Cmd>IPythonCellPrevCommand<CR>", { desc = "Run Previous command" })
      vim.keymap.set("n", "<leader>rR", "<Cmd>IPythonCellRestart<CR>", { desc = "Restart ipython" })
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<Cmd>IPythonCellExecuteCellJump<CR>",
        { desc = "Execute and jumpt to next cell" }
      )
      vim.keymap.set("n", "<leader>cC", "<Cmd>IPythonCellExecuteCell<CR>", { desc = "Execute cell" })
      vim.keymap.set("n", "<leader>cj", "<Cmd>IPythonCellNextCell<CR>", { desc = "Jump to previous cell" })
      vim.keymap.set("n", "<leader>ck", "<Cmd>IPythonCellNextCell<CR>", { desc = "Jump to next cell" })
      vim.keymap.set("n", "<leader>ci", "<Cmd>IPythonCellInsertAbove<CR>i", { desc = "Insert new cell above" })
      vim.keymap.set("n", "<leader>ca", "<Cmd>IPythonCellNextCell<CR>i", { desc = "Insert new cell below" })
    end,
  },
  { "goerz/jupytext.vim" },
}
