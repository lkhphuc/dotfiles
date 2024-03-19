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
      { "<CR>",   "<Plug>Send'>",  desc = "Send", mode = "v" },
      { "<S-CR>", "vap<Plug>Send'>", desc = "Send", mode = "n" },
    },
  },
}
