return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  config = function()
    require("hydra")({
      name = "Folding screen",
      mode = "n",
      color = "pink",
      body = "z<space>",
      hint = [[
  _m_:     _M_: 󰡍    _[_: 󰜝    _k_:     _i_: 󰌁       _<Esc>_: Quit
  _r_:     _R_: 󰡏    _]_: 󰜙    _j_:     _a_/_<Space>_:       Fold
  _H_:     _h_:     _l_:     _L_:     _z_: 󰘢             Screen
  ]],
      config = {
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
        { "H", "zH", { nowait = true } },
        { "L", "zL", { nowait = true } },
        { "[", "[z", { nowait = true } },
        { "]", "]z", { nowait = true } },
        { "j", "zj", { nowait = true } },
        { "k", "zk", { nowait = true } },
        { "i", "zi", { nowait = true } },
        { "a", "za", { nowait = true } },
        { "<Space>", "za", { nowait = true } },
        { "m", "zm", { nowait = true } },
        { "M", "zM", { nowait = true } },
        { "r", "zr", { nowait = true } },
        { "R", "zR", { nowait = true } },
        { "z", "zz", { nowait = true } },
      },
    })

    -- TODO: mini.visit
    require("hydra")({
      name = "Buffers",
      body = "<leader>b",
      hint = [[
      _h_:     _l_:     _j_:     _s_:     _d_: 󰆴   _D_: 󰒺   _<Tab>_:  
      _H_: 󰁍    _L_: 󰁔    _p_: 󰐃    _c_: 󰦀    _q_:    _E_: 󰒻   _m_: Move _<Esc>_: Quit 
      ]],
      config = {
        color = "pink",
        -- hint = { position = "top", offset = 1 },
        invoke_on_body = true,
      },
      heads = {
        { "h", "<cmd>BufferLineCyclePrev<Cr>" },
        { "l", "<cmd>BufferLineCycleNext<Cr>" },
        { "H", "<cmd>BufferLineMovePrev<Cr>" },
        { "L", "<cmd>BufferLineMoveNext<Cr>" },
        { "j", "<cmd>BufferLinePick<Cr>", { exit = true } },
        { "p", "<Cmd>BufferLineTogglePin<Cr>", { nowait = true } },
        { "s", "<Cmd>Telescope buffers<CR>", { nowait = true, exit = true } },
        { "m", "<Cmd>ScopeMoveBuf<CR>", { nowait = true, exit = true } },
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
        { "q", nil, { exit = true } },
        { "<Esc>", nil, { exit = true } },
      },
    })

    require("hydra")({
      name = "Git",
      hint = [[
    _J_: next hunk       _s_: stage hunk      _b_: blame line         _d_: Diff this    _h_: file history  
    _K_: prev hunk       _S_: stage buffer    _B_: blame show full    _D_: Diff orig    _H_: files history
    _l_: deleted lines   _u_: undo stage      _p_: preview hunk       _/_: base file    _v_: Diff View
    ^ ^ _g_: LazyGit        _<Esc>_: exit    
            ]],
      config = {
        color = "pink",
        invoke_on_body = true,
        on_enter = function()
          local gs = package.loaded.gitsigns
          vim.cmd("silent! %foldopen!")
          vim.bo.modifiable = false
          gs.toggle_linehl(true)
          gs.toggle_numhl(true)
          gs.toggle_word_diff(true)
          gs.toggle_current_line_blame(true)
        end,
        on_exit = function()
          local gs = package.loaded.gitsigns
          gs.toggle_linehl(false)
          gs.toggle_numhl(false)
          gs.toggle_word_diff(false)
          gs.toggle_current_line_blame(false)
          gs.toggle_deleted(false)
        end,
      },
      mode = { "n", "x" },
      body = "<leader>g",
      heads = {
        { "J", "<CMD>Gitsigns next_hunk<CR>", { desc = "next hunk" } },
        { "K", "<CMD>Gitsigns prev_hunk<CR>", { desc = "prev hunk" } },
        { "s", "<CMD>Gitsigns stage_hunk<CR>", { desc = "stage hunk" } },
        { "u", "<CMD>Gitsigns undo_stage_hunk<CR>", { desc = "undo last stage" } },
        { "S", "<CMD>Gitsigns stage_buffer<CR>", { desc = "stage buffer" } },
        { "p", "<CMD>Gitsigns preview_hunk<CR>", { desc = "preview hunk" } },
        { "l", "<CMD>Gitsigns toggle_deleted<CR>", { nowait = true } },
        { "d", "<CMD>Gitsigns diffthis<CR>", { desc = "Diff This", exit = true } },
        { "D", "<CMD>Gitsigns diffthis ~<CR>", { desc = "Diff with ~", exit = true } },
        { "h", "<CMD>DiffviewFileHistory %<CR>", { exit = true } },
        { "H", "<CMD>DiffviewFileHistory <CR>", { exit = true } },
        { "b", "<CMD>Gitsigns blame_line<CR>", { desc = "blame" } },
        { "B", "<CMD>Gitsigns blame_line full=true<CR>" },
        { "/", "<CMD>Gitsigns show<CR>" }, -- show the base of the file
        { "g", function() LazyVim.terminal.open("lazygit") end, { exit = true } },
        { "v", "<CMD>DiffviewOpen<CR>", { exit = true } },
        { "<Esc>", nil, { exit = true, nowait = true } },
      },
    })
  end,
}
