local M = {}
function M.setup()
  local hydra = require('hydra')
  local splits = require('smart-splits')
  -- local winshift = require("winshift")
  -- local tz = require("true-zen")

  -- local buffer_hint = [[
  --        ^<-^  ^-> ^
  -- Cycle  ^_h_^ ^_l_^
  -- Move   ^_H_^ ^_L_^
  -- ]]
  require("mini.bufremove")
  hydra({
    name = 'Buffers',
    body = '<leader>b',
    -- hint = buffer_hint,
    config = {
      hint = {type='window', border = 'single'},
      invoke_on_body = true,
      on_key = function()
        -- Preserve animation
        vim.wait(200, function() vim.cmd 'redraw' end, 30, false)
      end
    },
    heads = {
      { 'h', function() vim.cmd('BufferLineCyclePrev') end, { desc = "choose left", on_key = false } },
      { 'l', function() vim.cmd('BufferLineCycleNext') end, { desc = 'choose right', on_key = false } },

      { 'H', function() vim.cmd('BufferLineMovePrev') end, { desc = "move left" }},
      { 'L', function() vim.cmd('BufferLineMoveNext') end, { desc = 'move right' }},

      { 'p', function() vim.cmd('BufferLinePick') end, { desc = 'Pick' } },

      { 'P', function() vim.cmd('BufferLineTogglePin') end, { desc = 'pin' } },

      { 'b', require("telescope.builtin").buffers, { desc = 'fuzzy pick '} },

      { 'd', MiniBufremove.delete, { desc = 'close' } },
      { 'q', MiniBufremove.unshow, { desc = 'unshow' } },
      { 'c', function() vim.cmd('BufferLinePickClose') end, { desc = 'Pick close' } },

      { 'sd', function() vim.cmd('BufferLineSortByDirectory') end, { desc = 'by directory' } },
      { 'se', function() vim.cmd('BufferLineSortByExtension') end, { desc = 'by extension' } },
      { 'st', function() vim.cmd('BufferLineSortByTabs') end, { desc = 'by tab' } },
      { '<Esc>', nil, { exit = true } }
    }
  })

  vim.keymap.set('n', 'gb', "<CR>BufferLinePick<CR>")

  local window_hint = [[
   ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
   ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
   ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
   _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
   ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
   focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
   ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
   _b_: choose buffer
  ]]

  hydra({
    name = 'Windows',
    hint = window_hint,
    config = {
      on_key = function() vim.wait(50) end,
      invoke_on_body = true,
      hint = {
        border = 'rounded',
        offset = -1
      }
    },
    mode = 'n',
    body = '<leader>w',
    heads = {
      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', '<C-w>k' },
      { 'l', '<C-w>l' },

      { 'H', require('winshift').cmd_winshift('left') },
      { 'J', require('winshift').cmd_winshift('down') },
      { 'K', require('winshift').cmd_winshift('up') },
      { 'L', require('winshift').cmd_winshift('right') },

      { '<C-h>', function() splits.resize_left(2) end },
      { '<C-j>', function() splits.resize_down(2) end },
      { '<C-k>', function() splits.resize_up(2) end },
      { '<C-l>', function() splits.resize_right(2) end },
      { '=', '<C-w>=', { desc = 'equalize' } },

      { 's', '<C-w>s' }, { '<C-s>', '<C-w><C-s>', { desc = false } },
      { 'v', '<C-w>v' }, { '<C-v>', '<C-w><C-v>', { desc = false } },

      { 'w', '<C-w>w', { exit = true, desc = false } },
      { '<C-w>', '<C-w>w', { exit = true, desc = false } },

      { 'z', require('zen-mode').toggle, { desc = 'Zen' } },
      -- { '<C-z>', require('true-zen.ataraxis').off, { exit = true, desc = false } },

      { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
      { '<C-o>', '<C-w>o', { exit = true, desc = false } },

      { 'b', "<CMD>BufferLinePick<CR>", { exit = true, desc = 'choose buffer' } },

      { 'c', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]] },
      { 'q', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = 'close window' } },
      { '<C-q>', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },
      { '<C-c>', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },

      { '<Esc>', nil, { exit = true, desc = false } }
    }
  })
end

return M
