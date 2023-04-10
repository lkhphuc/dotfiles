local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", config = true },
    { "theHamsta/nvim-dap-virtual-text", config = true },
    { "mfussenegger/nvim-dap-python" },
    { "jayp0521/mason-nvim-dap.nvim" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dappy = require("dap-python")
    local dapmason = require("mason-nvim-dap")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapStopped", {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    })

    dapmason.setup({
      handlers = {
        function(config) dapmason.default_setup(config) end,
        python = function(config)
          dappy.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3")
        end,
      },
    })

    -- TODO: create a Hydra for DAP
    require("which-key").register({ ["<leader>d"] = { name = "Debug" } })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Repl" })
    vim.keymap.set("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Widgets Hover" })

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "UI" })
    vim.keymap.set("n", "<leader>drl", dap.run_last, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>drc", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "Go to line (no execute)" })
    vim.keymap.set("n", "<leader>dt", dap.step_out, { desc = "Step ouT" })
    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
    vim.keymap.set("v", "<leader>de", dapui.eval, { desc = "Eval" })
    vim.keymap.set("n", "<leader>dD", dap.disconnect, { desc = "Disconnect" })
    vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Quit" })
    vim.keymap.set("n", "<leader>dS", dap.session, { desc = "Session" })

    vim.keymap.set("n", "<leader>dtm", dappy.test_method, { desc = "Test Method" })
    vim.keymap.set("n", "<leader>dtc", dappy.test_class, { desc = "Test Class" })
    vim.keymap.set("v", "<leader>ds", dappy.debug_selection, { desc = "Debug Selection" })
  end
}

return M
