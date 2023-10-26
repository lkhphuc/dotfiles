return {
  {
    "nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        u = require("mini.ai").gen_spec.function_call(), -- "usage" call of function or class
        n = { "%f[%d]%d+" }, -- Numbers
        e = { -- Word with camel case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        E = { "()()%f[%w]%w+()[ \t]*()" }, -- Imitate word ignoring digits and punctuation
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
        -- Whole buffer
        g = function()
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
      },
    },
  },
  {
    "echasnovski/mini.align",
    opts = { mappings = { start = "", start_with_preview = "gA" } },
    keys = { { "gA", desc = "Align with preview", mode = { "n", "x" } } },
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      {
        "<leader>mt",
        function() require("mini.trailspace").trim() end,
        desc = "Trim white space",
      },
    },
  },
  {
    "mini.indentscope",
    opts = {
      mappings = { goto_top = "[ai", goto_bottom = "]ai" },
      draw = { priority = 12 },
    },
  },
  { "tpope/vim-sleuth", event = "VeryLazy" }, --One plugin everything tab indent
  {
    "CKolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    config = true,
    keys = {
      {
        "ga",
        function() require("ts-node-action").node_action() end,
        desc = "Node Action",
      },
    },
  },
  { "ThePrimeagen/refactoring.nvim", opts = {}, cmd = "Refactor" },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = { -- Emulate Tpope's original mapping
        add = "ys",
        delete = "ds",
        find = "]s",
        find_left = "[s",
        highlight = "vs",
        replace = "cs",
        update_n_lines = "",
      },
    },
  },
  { "echasnovski/mini.operators", opts = {}, keys = { "g=", "gx", "gm", "gr", "gs" } },
}
