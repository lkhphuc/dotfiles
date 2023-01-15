return {
  "b0o/incline.nvim",
  events = "BufAdd",
  opts = {
    window = {
      margin = { vertical = 0 },
    },
    render = function(props)
      local function get_diagnostic_label()
        local icons = require("lazyvim.config").icons.diagnostics
        -- local icons = { error = '', warn = '', info = '', hint = '', }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity }) end
        end
        if #label > 0 then table.insert(label, { "| " }) end
        return label
      end

      local function get_git_diff()
        local icons = { removed = "", changed = "", added = "" }
        -- local icons = require("lazyvim.config").icons.git
        local labels = {}
        local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status")
        print(vim.inspect(signs))
        -- local signs = vim.b.gitsigns_status_dict
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
          end
        end
        if #labels > 0 then table.insert(labels, { "| " }) end
        return labels
      end

      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
      local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"

      local buffer = {
        { get_diagnostic_label() },
        { get_git_diff() },
        { ft_icon, guifg = ft_color, guibg = "none" },
        { " " },
        { filename, gui = modified },
      }
      return buffer
    end,
  },
}
