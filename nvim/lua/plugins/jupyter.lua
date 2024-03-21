-- In a native script, we mimick a notebook cell by defining a marker
-- It's commonly defined in many editors and program to use
-- a space and two percent (%) sign after the comment symbol
-- For python, that would be a line starting with `# %%`

-- Define code cell marker treesitter object
-- Open a python file and run `:TSEditQueryUserAfter textobjects`
-- Add the following query to the opened file:
--
-- ; extends
-- ((comment) @code_cell.marker
-- (#lua-match? @code_cell.marker "^# %%%%"))
--
--
-- Injecting markdown highlight to all standalone multiline string
-- Open a python file and run `:TSEditQueryUserAfter injections`
-- Add the following query to the opened file:
--
-- ;extends
-- (module
--   (expression_statement
--     (string
--       (string_content) @injection.content)
--     )
--   (#set! injection.language "markdown")
-- )

return {
  -- Automatically convert ipynb to py script with cell markers
  {
    "GCBallesteros/jupytext.nvim",
    ft = { "json", "ipynb" },
    opts = { },
  },
  -- Overlay cell marker & metadata so it's less distracting
  {
    "echasnovski/mini.hipatterns",
    opts = function(_, opts)
      local censor_extmark_opts = function(_, match, _)
        local mask = string.rep("=", vim.api.nvim_win_get_width(0))
        return {
          virt_text = { { mask, "SignColumn" } },
          virt_text_pos = "overlay",
          priority = 200,
          right_gravity = false,
        }
      end
      opts.highlighters["cell"] = {
        pattern = function(bufid)
          local cms = vim.api.nvim_get_option_value("commentstring", { buf = bufid })
          return "^" .. string.gsub(cms, "%%s", "") .. "%%%%.*"
        end,
        group = "",
        extmark_opts = censor_extmark_opts,
      }
    end,
  },
  -- Define code cell object `ix`, `ax`
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        x = function(ai_mode, _, _) -- Code Cell objects
          local buf_nlines = vim.api.nvim_buf_line_count(0)
          local begin_cell = 1 -- First cell from first line to first cell delimeter
          local res = {}
          for i = 1, buf_nlines do
            local cur_line = vim.fn.getline(i)
            if cur_line:sub(1, 4) == "# %%" then -- NOTE: Cell delimeter
              local end_cell = i - 1
              local region = {
                from = { line = begin_cell, col = 1 },
                to = { line = end_cell, col = vim.fn.getline(end_cell):len() },
              }
              table.insert(res, region)
              begin_cell = i
              if ai_mode == "i" then begin_cell = begin_cell + 1 end
            end
          end
          table.insert(res, { -- Last cell from last delimeter to end of file
            from = { line = begin_cell, col = 1 },
            to = { line = buf_nlines, col = vim.fn.getline(buf_nlines):len() },
          })
          return res
        end,
      },
    },
  },
  -- Mapping for moving between cell `]x`, `[x`
  {
    "nvim-treesitter",
    opts = {
      textobjects = {
        move = {
          goto_next_start = { ["]x"] = "@code_cell.marker" },
          goto_previous_start = { ["[x"] = "@code_cell.marker" },
        },
      },
    },
  },
  -- Inspect and completion in neovim from running kernel
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = { timeout = 0.5 },
    build = ":UpdateRemotePlugins",
    cmd = "JupyterAttach",
    keys = {
      { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" },
    },
    dependencies = {
      {
        "nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, 1, { name = "jupyter", group_index = 1, priority = 100 })
        end,
      },
    },
  },
  -- Notebook-style run and display results
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    cmd = "MoltenInit",
    keys = {
      { "<leader>r", "<cmd>MoltenEvaluateOperator<CR>", expr = true },
      { "<leader>rr", "<cmd>MoltenEvaluateLine<CR>" },
      { "<leader>rc", "<cmd>MoltenReevaluateCell<CR>" },
      { "<leader>rd", "<cmd>MoltenDelete<CR>" },
      { "<leader>ro", "<cmd>MoltenShowOutput<CR>" },
      { "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v" },
      {
        "<leader>re",
        ":noautocmd MoltenEnterOutput<CR>",
        desc = "open output window",
        silent = true,
      },
    },
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
}
