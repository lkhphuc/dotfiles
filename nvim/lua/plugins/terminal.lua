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
      { "<CR>",   "<Plug>Send",     desc = "Send", mode = { "n", "v" } },
      { "<S-CR>", "vap<Plug>Send}", desc = "Send", mode = "n" },
    },
  },
  {
    "nikvdp/neomux",
    event = "VeryLazy",
    init = function()
      vim.g.neomux_start_term_map = ""
      vim.g.neomux_win_num_status = ""
      vim.g.neomux_winswap_map_prefix = "<leader>ws"
      vim.g.neomux_term_sizefix_map = "<leader>wf"
      vim.g.neomux_dont_fix_term_ctrlw_map = 1
      vim.g.neomux_no_term_autoinsert = 1
    end,
  },
  {
    "voldikss/vim-floaterm",
    keys = "<C-;>",
    init = function()
      vim.g.floaterm_keymap_next = "<Home>"
      vim.g.floaterm_keymap_prev = "<End>"
      vim.g.floaterm_keymap_new = "<M-;>"
      vim.g.floaterm_keymap_toggle = "<C-;>"
      vim.g.floaterm_position = "center"
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
    end,
  },
  {
    "chomosuke/term-edit.nvim",
    event = "TermOpen",
  },
}
