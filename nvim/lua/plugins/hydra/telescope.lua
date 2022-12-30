local M = {}

function M.setup()
  local Hydra = require("hydra")
  local cmd = require("hydra.keymap-util").cmd

  local hint = [[
                 _f_: files       _*_: cursorword
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _m_: marks
  🭉🭁🭠🭘    🭣🭕🭌🬾   _b_: buffers     _g_: live grep
  🭅█ ▁     █🭐   _p_: projects    _/_: search in file
  ██🬿      🭊██   _r_: resume      _t_: search in workspace
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

  Hydra({
    name = "Telescope",
    hint = hint,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "rounded",
      },
    },
    mode = "n",
    body = "<Leader>s",
    heads = {
      { "f", cmd("Telescope find_files") },
      { "b", cmd("Telescope buffers") },
      { "*", cmd("Telescope grep_string") },
      { "g", cmd("Telescope live_grep") },
      { "t", cmd("Telescope grep_string search= theme=ivy"), { desc = "Fuzzy workspace"} },
      { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
      { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
      { "m", cmd("Telescope marks"), { desc = "marks" } },
      { "k", cmd("Telescope keymaps") },
      { "O", cmd("Telescope vim_options") },
      { "r", cmd("Telescope resume") },
      { "p", cmd("Telescope projects"), { desc = "projects" } },
      { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
      { "?", cmd("Telescope search_history"), { desc = "search history" } },
      { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
      { "c", cmd("Telescope commands"), { desc = "execute command" } },
      -- { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
      { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
      { "<Esc>", nil, { exit = true, nowait = true } },
    },
  })
end

return M
