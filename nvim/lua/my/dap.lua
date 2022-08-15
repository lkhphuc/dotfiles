local dap = require('dap')
local dapui = require('dapui')
local dappy = require('dap-python')

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
vim.fn.sign_define("DapStopped",{
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    })

dappy.setup(vim.fn.stdpath("data")..'/mason/packages/debugpy/venv/bin/python3')


require('which-key').register({["<leader>d"] = {name="Debug"}})
vim.keymap.set("n", "<leader>dy", dapui.toggle , {desc="Toggle Debug UI"})
vim.keymap.set("n", "<leader>ds", dap.continue, {desc = "Start"})
--[[ vim.keymap.set("n", "<leader>dc", dap.continue, {desc="Continue"} ) ]]
vim.keymap.set("n", "<leader>dl", dap.run_last, {desc = "Run Last"})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {desc="Toggle breakpoint"})
vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, {desc="Run to Cursor"})
vim.keymap.set("n", "<leader>dg", dap.goto_, {desc="Go to line (no execute)"})
vim.keymap.set("n", "<leader>di", dap.step_into, {desc = "Step Into"})
vim.keymap.set("n", "<leader>do", dap.step_over, {desc = "Step Over"})
vim.keymap.set("n", "<leader>dt", dap.step_out, {desc = "Step ouT"})
vim.keymap.set("n", "<leader>du", dap.up, {desc = "Up"})
vim.keymap.set("n", "<leader>du", dap.down, {desc = "Down"})
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, {desc = "Repl"})
vim.keymap.set("v", "<leader>de", dapui.eval, {desc="Eval"})
vim.keymap.set("n", "<leader>dD", dap.disconnect, {desc="Disconnect"})
vim.keymap.set("n", "<leader>dp", dap.pause, {desc = "Pause"})
vim.keymap.set("n", "<leader>dq", dap.terminate, {desc="Quit"})
vim.keymap.set("n", "<leader>dS", dap.session, {desc="Session"})

vim.keymap.set("n", "<leader>dm", dappy.test_method, {desc="Test Method"})
vim.keymap.set("n", "<leader>dC", dappy.test_class, {desc="Test Class"})
vim.keymap.set("v", "<leader>ds", dappy.debug_selection, {desc="Debug Selection"})
