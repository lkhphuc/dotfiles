local Hydra = require("hydra")

local hint = [[
  ^ ^        Options
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
]]

Hydra({
   name = 'Options',
   hint = hint,
   config = {
      color = 'amaranth',
      invoke_on_body = true,
      hint = {
         border = 'rounded',
         position = 'middle'
      }
   },
   mode = {'n','x'},
   body = '<leader>O',
   heads = {
      { 'n', function()
         if vim.o.number == true then
            vim.o.number = false
         else
            vim.o.number = true
         end
      end, { desc = 'number' } },
      { 'r', function()
         if vim.o.relativenumber == true then
            vim.o.relativenumber = false
         else
            vim.o.number = true
            vim.o.relativenumber = true
         end
      end, { desc = 'relativenumber' } },
      { 'v', function()
         if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
         else
            vim.o.virtualedit = 'all'
         end
      end, { desc = 'virtualedit' } },
      { 'i', function()
         if vim.o.list == true then
            vim.o.list = false
         else
            vim.o.list = true
         end
      end, { desc = 'show invisible' } },
      { 's', function()
         if vim.o.spell == true then
            vim.o.spell = false
         else
            vim.o.spell = true
         end
      end, { exit = true, desc = 'spell' } },
      { 'w', function()
         if vim.o.wrap ~= true then
            vim.o.wrap = true
            -- Dealing with word wrap:
            -- If cursor is inside very long line in the file than wraps
            -- around several rows on the screen, then 'j' key moves you to
            -- the next line in the file, but not to the next row on the
            -- screen under your previous position as in other editors. These
            -- bindings fixes this.
            vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end,
                                     { expr = true, desc = 'k or gk' })
            vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end,
                                     { expr = true, desc = 'j or gj' })
         else
            vim.o.wrap = false
            vim.keymap.del('n', 'k')
            vim.keymap.del('n', 'j')
         end
      end, { desc = 'wrap' } },
      { 'c', function()
         if vim.o.cursorline == true then
            vim.o.cursorline = false
         else
            vim.o.cursorline = true
         end
      end, { desc = 'cursor line' } },
      { '<Esc>', nil, { exit = true } }
   }
})

vim.wo.number = true --Make line numbers default
vim.wo.relativenumber = true
vim.o.mouse = 'a' --Enable mouse mode
vim.o.ignorecase = true --Case insensitive searching
vim.o.smartcase = true -- UNLESS /C or capital in search
vim.o.completeopt = 'menu,menuone,noselect' -- complete to comment string
vim.o.timeoutlen = 300
vim.o.tabstop = 2  -- If not set by sleuth, a tab is 2 space
vim.o.shiftwidth = 2  -- For >>, <<
vim.o.wrap = false
vim.o.linebreak = true  -- wrap at specific char rather than last one
vim.o.breakat = " ^I!@*;:,./?(="
vim.o.showbreak = "|>"
vim.o.breakindent = true  -- to indent on wrap
vim.o.breakindentopt = "min:60"
vim.o.undofile = true --Save undo history
vim.o.wildmode = "longest:full,full"
vim.o.path = vim.o.path .. "**"
vim.o.list = false
vim.o.listchars = "eol:↲,trail:·,nbsp:␣"
vim.o.scrolloff = 3
vim.o.sidescrolloff = 1
vim.o.signcolumn = "yes"
vim.o.showtabline = 0
vim.o.swapfile = false
vim.o.showmode = false
vim.g.splitkeep = "screen"

vim.g.python3_host_prog = "/usr/bin/python3"
-- Can not put this inside neomux config for some reason
vim.g.neomux_win_num_status = ""
vim.g.neomux_dont_fix_term_ctrlw_map = 1
vim.g.neomux_no_exit_term_map = 1
vim.g.cursorhold_updatetime = 100
