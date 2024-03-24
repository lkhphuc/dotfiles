-- In a native script, we mimick a notebook cell by defining a marker
-- It's commonly defined in many editors and program to use
-- a space and two percent (%) sign after the comment symbol
-- For python, that would be a line starting with `# %%`
local cell_marker = [[# %%]]

-- Define code cell marker treesitter object
-- Open a python file and run `:TSEditQueryUserAfter textobjects`
-- Add the following query to the opened file:
--
-- ; extends
-- ((comment) @cell_marker
--   (#lua-match? @cell_marker "^# %%%%"))
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
  { -- General vim repl code send
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_no_mappings = 1
      vim.g.slime_cell_delimiter = cell_marker
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_target = "wezterm"
      vim.g.slime_default_config = { pane_direction = "right" }
      vim.g.slime_menu_config = true
      vim.api.nvim_create_user_command("SlimeTarget", function(opts)
        if opts.args ~= nil then
          vim.b.slime_config = nil
          vim.b.slime_target = opts.args
        else
          vim.print(vim.b.slime_target .. vim.b.slime_config)
        end
      end, { desc = "Change Slime target", nargs = "*" })
    end,
    cmd = "SlimeConfig",
    keys = {
      { "<CR>", "<Plug>SlimeRegionSend", mode = "x" },
      { "<CR>", "<Plug>SlimeMotionSend", mode = "n" },
      { "<S-CR>", "<Plug>SlimeSendCell", mode = "n" },
    },
  },
  { -- Automatically convert ipynb to py script with cell markers
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {},
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
      opts.highlighters["cell_marker"] = {
        pattern = function(bufid)
          local cms = vim.api.nvim_get_option_value("commentstring", { buf = bufid })
          return "^" .. string.gsub(cms, [[%s]], "") .. [[%%.*]]
        end,
        group = "",
        extmark_opts = censor_extmark_opts,
      }
    end,
  },
  { -- Define code cell object `ix`, `ax`
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        x = function(ai_mode, _, _) -- Code Cell objects
          local buf_nlines = vim.api.nvim_buf_line_count(0)
          local begin_cell = 1 -- First cell from first line to first cell delimeter
          local res = {}
          for i = 1, buf_nlines do
            local cur_line = vim.fn.getline(i)
            if cur_line:sub(1, 4) == cell_marker then -- NOTE: Cell delimeter
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
  { -- Mapping for moving between cell `]x`, `[x`
    "nvim-treesitter",
    opts = {
      textobjects = {
        move = {
          goto_next_start = { ["]x"] = "@cell_marker" },
          goto_previous_start = { ["[x"] = "@cell_marker" },
        },
      },
    },
  },
  { -- Inspect and completion in neovim from running kernel
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
  { -- Notebook-style run and display results
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    keys = {
      { "<leader>rm", "<cmd>MoltenInit<CR>", desc = "MoltenInit" },
    },
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          vim.keymap.set(
            "n", "<CR>", "<cmd>MoltenEvaluateOperator<CR>",
            { buffer = true, silent = true, desc = "Run" }
          )
          vim.keymap.set(
            "x", "<CR>", ":<C-u>MoltenEvaluateVisual<CR>'>",
            { buffer = true, silent = true, desc = "Run selection" }
          )
          vim.keymap.set(
            "n", "<S-CR>", "vax<CR>]xj",
            { remap = true, buffer = true, desc = "Run cell and move" }
          )
          vim.keymap.set(
            "n", "<leader>rh", "<cmd>MoltenHideOutput<CR>",
            { buffer = true, silent = true, desc = "Hide Output" }
          )
          vim.keymap.set(
            "n", "<leader>ro", "<cmd>noautocmd MoltenEnterOutput<CR>",
            { buffer = true, silent = true, desc = "Show/Enter Output" }
          )
          vim.keymap.set(
            "n", "<leader>ri", "<cmd>MoltenImportOutput<CR>",
            { buffer = true, desc = "Import Notebook Output" }
          )
        end,
      })
    end,
  },
}
