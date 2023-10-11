return {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  init = function()
    require("hydra")({
      name = "Folding screen",
      mode = "n",
      color = "pink",
      body = "<leader>z",
      hint = [[
  _M_: 󰡍    _m_:     _k_:     _[_: 󰜝    _i_: 󰌁   _<Esc>_: Quit
  _H_:     _h_:     _z_: 󰘢    _l_:     _L_:   
  _R_: 󰡏    _r_:     _j_:     _]_: 󰜙    _a_/_<Space>_:  
  ]],
      config = {
        hint = { border = "rounded" },
        invoke_on_body = true,
        on_enter = function()
          -- vim.opt.statuscolumn = [[%!v:lua.require'config.util'.statuscolumn()]]
          vim.b.minianimate_disable = true
        end,
        on_exit = function()
          -- vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util.ui'.statuscolumn()]]
          vim.b.minianimate_disable = false
        end,
      },
      heads = {
        { "h", "5zh", { nowait = true } },
        { "l", "5zl", { nowait = true } },
        { "H", "zH" , { nowait = true }},
        { "L", "zL" , { nowait = true }},
        { "[", "[z" , { nowait = true }},
        { "]", "]z" , { nowait = true }},
        { "j", "zj" , { nowait = true }},
        { "k", "zk" , { nowait = true }},
        { "i", "zi" , { nowait = true }},
        { "a", "za" , { nowait = true }},
        { "<Space>", "za" , { nowait = true }},
        { "m", "zm" , { nowait = true }},
        { "M", "zM" , { nowait = true }},
        { "r", "zr" , { nowait = true }},
        { "R", "zR" , { nowait = true }},
        { "z", "zz" , { nowait = true }},
      },
    })

    require("hydra")({
      name = "Buffers",
      body = "<leader>b",
      hint = [[
      _h_:     _l_:     _j_:     _s_:     _d_: 󰆴   _D_: 󰒺   _<Tab>_:  
      _H_: 󰁍    _L_: 󰁔    _p_: 󰐃    _c_: 󰦀    _q_:    _E_: 󰒻   _m_: Move _<Esc>_: Quit 
      ]],
      config = {
        color = "pink",
        hint = { position = "top", offset = 1,  border = "rounded" },
        invoke_on_body = true,
      },
      heads = {
        { "h", "<cmd>BufferLineCyclePrev<Cr>" },
        { "l", "<cmd>BufferLineCycleNext<Cr>" },
        { "H", "<cmd>BufferLineMovePrev<Cr>" },
        { "L", "<cmd>BufferLineMoveNext<Cr>" },
        { "j", "<cmd>BufferLinePick<Cr>", {exit = true} },
        { "p", "<Cmd>BufferLineTogglePin<Cr>", { nowait = true } },
        { "s", "<Cmd>Telescope buffers<CR>", { nowait = true, exit=true }},
        { "m", "<Cmd>ScopeMoveBuf<CR>", { nowait = true, exit=true }},
        { "d", function() require("mini.bufremove").delete(0, false) end },
        { "q", function() require("mini.bufremove").unshow(0) end },
        { "c", "<Cmd>BufferLinePickClose<CR>" },
        { "D", "<Cmd>BufferLineSortByDirectory<CR>" },
        { "E", "<Cmd>BufferLineSortByExtension<CR>" },
        { "<Tab>", "<Cmd>BufferLineSortByTabs<CR>" },
        { "<Esc>", nil, { exit = true } },
      },
    })

    require("hydra")({
      name = "UI Options",
      hint = [[
  ^ ^        UI Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          border = "rounded",
          position = "middle",
        },
      },
      mode = { "n", "x" },
      body = "<leader>U",
      heads = {
        { "n", function() vim.o.number = not vim.o.number end, { desc = "number" } },
        {
          "r",
          function() vim.o.relativenumber = not vim.o.relativenumber end,
          { desc = "relativenumber" },
        },
        {
          "v",
          function()
            if vim.o.virtualedit == "all" then
              vim.o.virtualedit = "block"
            else
              vim.o.virtualedit = "all"
            end
          end,
          { desc = "virtualedit" },
        },
        { "i", function() vim.o.list = not vim.o.list end, { desc = "show invisible" } },
        { "s", function() vim.o.spell = not vim.o.spell end, { exit = true, desc = "spell" } },
        { "w", function() vim.o.wrap = not vim.o.wrap end, { desc = "wrap" } },
        {
          "c",
          function() vim.o.cursorline = not vim.o.cursorline end,
          { desc = "cursor line" },
        },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}
