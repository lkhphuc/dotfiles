-- In a native script, we mimick a notebook cell by defining a marker
-- It's commonly defined in many editors and program to use
-- a space and two percent (%) sign after the comment symbol
-- For python, julia etc that would be a line starting with `# %%`
local cell_marker = [[# %%]]

return {
  {
    "mtikekar/nvim-send-to-term",
    cmd = { "SendTo", "SendHere" },
    init = function()
      vim.g.send_disable_mapping = true -- dont use default
      local function send_to_wez(opts)
        local pane_id = opts.args
        local function send_to_pane(lines)
          lines = table.concat(lines, "\n"):gsub('"', '\\"') -- Escape double quote since it's used to wrap lines
          os.execute('wezterm cli send-text --pane-id=' .. pane_id .. ' "' .. lines .. '"')
          os.execute('wezterm cli send-text --pane-id=' .. pane_id .. ' --no-paste "\r\r"')
        end
        vim.g.send_target = { send = send_to_pane, }
      end
      vim.api.nvim_create_user_command("SendToWez", send_to_wez, { nargs = 1 })
      local function send_to_jupyter(opts)
        if vim.b.jupyter_attached == nil then
          vim.notify("No jupyter kernel attached")
          return
        end
        vim.g.send_target = { send = function (lines)
          lines = table.concat(lines, "\n")
          vim.fn.JupyterExecute(lines)
        end}
      end
      vim.api.nvim_create_user_command("SendToJupyter", send_to_jupyter, {})
    end,
    keys = {
      { "<C-CR>",   "<Plug>Send",    desc = "Send", mode = "n" },
      { "<S-CR>",   "<Plug>Send'>",  desc = "Send", mode = "v" },
      { "<S-CR>", "vip<Plug>Send}j", desc = "Send", mode = "n" },
      { "<leader>ti", "<CMD>SendHere ipy<CR>", desc="Send to current ipython terminal.", mode="n"},
    },
  },
  { -- General vim repl code send
    "jpalardy/vim-slime",
    enabled = false,
    init = function()
      vim.g.slime_no_mappings = 1
      vim.g.slime_cell_delimiter = cell_marker
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_target = "neovim"
      -- vim.g.slime_target = "wezterm"
      -- vim.g.slime_default_config = { pane_direction = "next" }
      vim.g.slime_menu_config = true
      vim.api.nvim_create_user_command("SlimeTarget", function(opts)
        if opts.args ~= nil then
          vim.b.slime_target = opts.args
          vim.b.slime_config = nil
        else
          vim.b.slime_config = vim.g.slime_config
          vim.b.slime_target = vim.g.slime_target
        end
        vim.notify("Slime send target is: " .. vim.b.slime_target)
      end, { desc = "Change Slime target", nargs = 1 })
    end,
    cmd = { "SlimeConfig", "SlimeTarget" },
    keys = {
      { "<S-CR>", "<Plug>SlimeRegionSend", mode = "x", desc = "Send Selection" },
      { "<S-CR>", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Motion / Text Object" },
      {
        "<S-CR><S-CR>",
        "vir<S-CR>]rj",
        mode = "n",
        remap = true,
        desc = "Send Cell and Jump Next",
      },
      { "<leader>rr", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Motion (Aslo <C-CR>)" },
      { "<leader>rC", "<Cmd>SlimeConfig<CR>", desc = "Slime Run Config" },
      { "<leader>rT", "<Cmd>SlimeTarget<CR>", desc = "Slime Run Target" },
    },
  },

  { -- Overlay cell marker & metadata so it's less distracting
    "echasnovski/mini.hipatterns",
    ft = { "python" },
    opts = function(_, opts)
      local censor_extmark_opts = function(buf_id, match, data)
        local mask = string.rep("⎯", vim.api.nvim_win_get_width(0))
        return {
          virt_text = { { mask, "SignColumn" } },
          virt_text_pos = "overlay",
          virt_text_hide = true,
          -- virt_text_win_col = 5,
          priority = 200,
          right_gravity = false,
        }
      end
      opts.highlighters["cell_marker"] = {
        pattern = function(bufid)
          -- local cms = vim.api.nvim_get_option_value("commentstring", { buf = bufid })
          -- return "^" .. string.gsub(cms, [[%s]], "") .. [[%%.*]]
          return "^# *%%"
        end,
        group = "",
        extmark_opts = censor_extmark_opts,
      }
    end,
  },
  { -- Define code cell object `ir`, `ar`
    "echasnovski/mini.ai",
    opts = function(_, opts)
      opts.custom_textobjects["r"] = function(ai_mode, _, _) -- Repl Code Cell object
        local buf_nlines = vim.api.nvim_buf_line_count(0)
        local cell_markers = {}
        for line_no = 1, buf_nlines do
          if vim.fn.getline(line_no):sub(1, 4) == cell_marker then
            table.insert(cell_markers, line_no)
          end
        end
        table.insert(cell_markers, 1, 0) -- Beginning
        table.insert(cell_markers, #cell_markers + 1, buf_nlines + 1)

        local regions = {}
        for i = 1, #cell_markers - 1 do
          local from_line = ai_mode == "i" and cell_markers[i] + 1 or math.max(cell_markers[i], 1)
          -- for `around cell` on empty line select previous cell
          local to_line = cell_markers[i + 1] - 1
          local to_line_len = vim.fn.getline(to_line):len() + 1
          table.insert(regions, {
            from = { line = from_line, col = 1 },
            to = { line = to_line, col = to_line_len },
          })
        end
        return regions
      end
    end,
  },
  { -- Mapping for moving between cell `]r`, `[r`
    "nvim-treesitter",
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["ix"] = "@cell.inner",
            ["ax"] = "@cell.outer",
          },
        },
        move = {
          goto_next_start = { ["]r"] = "@cell_marker" },
          goto_previous_start = { ["[r"] = "@cell_marker" },
        },
      },
    },
  },
  { -- Automatically convert ipynb to py script with cell markers
    "GCBallesteros/jupytext.nvim",
    lazy = false, -- for auto convert ipynb on open, minimal startup time
    opts = {},
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
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_wrap_output = true
      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          vim.keymap.set(
            "n",
            "<leader>rM",
            "<cmd>MoltenDeinit<CR>",
            { buffer = true, desc = "Molten Stop" }
          )
          vim.keymap.set(
            "n",
            "<S-CR>",
            "<cmd>MoltenEvaluateOperator<CR>",
            { buffer = true, silent = true, desc = "Run" }
          )
          vim.keymap.set(
            "x",
            "<S-CR>",
            ":<C-u>MoltenEvaluateVisual<CR>'>",
            { buffer = true, silent = true, desc = "Run selection" }
          )
          vim.keymap.set(
            "n",
            "<S-CR><S-CR>",
            "vir<S-CR>]rj",
            { remap = true, buffer = true, desc = "Run cell and move" }
          )
          vim.keymap.set(
            "n",
            "<leader>rh",
            "<cmd>MoltenHideOutput<CR>",
            { buffer = true, silent = true, desc = "Hide Output" }
          )
          vim.keymap.set(
            "n",
            "<leader>ro",
            "<cmd>noautocmd MoltenEnterOutput<CR>",
            { buffer = true, silent = true, desc = "Show/Enter Output" }
          )
          vim.keymap.set(
            "n",
            "<leader>ri",
            "<cmd>MoltenImportOutput<CR>",
            { buffer = true, desc = "Import Notebook Output" }
          )
          if vim.fn.bufname():match("ipynb") then vim.cmd("MoltenImportOutput") end
          vim.cmd([[JupyterAttach]])
        end,
      })
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,
    dependencies = {
      { "lualine.nvim",
        opts = function(_, opts)
          table.insert(opts.sections.lualine_x, {
            function()
              local kernels = require('molten.status').kernels()
              return kernels == "" and "" or " " .. kernels
            end,
            color = "PreProc",
          })
        end,
      },
    },
  },
  {
    "hydra.nvim",
    optional = true,
    opts = {
      code_cells = {
        name = "Code cells",
        mode = "n",
        color = "pink",
        body = "<leader>r",
        hint = [[_j_/_k_: move down/up  _r_: run cell_l_: run line  _R_: run above^^     _<esc>_/_q_: exit]],
        config = { invoke_on_body = true,  },
        heads = {
          { "J", "]r", remap = true },
          { "K", "[r", remap = true },
          { "<S-CR>", "<C-CR>ir]r", remap = true },
          { "<CR>", "V<C-CR>", remap = true },
          { "m", "<Cmd>MoltenInit<CR>" },
          { "R", ":QuartoSendAbove<CR>" },
          { "C", "<Cmd>SlimeConfig<CR>" },
          { "T", "<Cmd>SlimeTarget<CR>" },
          { "<esc>", nil, { exit = true } },
          { "q", nil, { exit = true } },
        }
      }
    }
  }
}
