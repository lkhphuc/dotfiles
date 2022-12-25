local M = {}
function M.setup()
  local hydra = require('hydra')
  local splits = require('smart-splits')
  -- local winshift = require("winshift")
  -- local tz = require("true-zen")

  hydra({
    name = 'Side scroll',
    mode = 'n',
    body = 'z',
    heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
    }
  })

  local buffer_hydra = hydra({
    name = 'Barbar',
    config = {
      on_key = function()
        -- Preserve animation
        vim.wait(200, function() vim.cmd 'redraw' end, 30, false)
      end
    },
    heads = {
      { 'h', function() vim.cmd('BufferPrevious') end, { on_key = false } },
      { 'l', function() vim.cmd('BufferNext') end, { desc = 'choose', on_key = false } },

      { 'H', function() vim.cmd('BufferMovePrevious') end },
      { 'L', function() vim.cmd('BufferMoveNext') end, { desc = 'move' } },

      { 'p', function() vim.cmd('BufferPin') end, { desc = 'pin' } },

      { 'd', function() vim.cmd('BufferClose') end, { desc = 'close' } },
      { 'c', function() vim.cmd('BufferClose') end, { desc = false } },
      { 'q', function() vim.cmd('BufferClose') end, { desc = false } },

      { 'od', function() vim.cmd('BufferOrderByDirectory') end, { desc = 'by directory' } },
      { 'ol', function() vim.cmd('BufferOrderByLanguage') end, { desc = 'by language' } },
      { '<Esc>', nil, { exit = true } }
    }
  })

  local function choose_buffer()
    if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
      buffer_hydra:activate()
    end
  end

  vim.keymap.set('n', 'gb', choose_buffer)

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
      { 'k', vim.cmd [[try | wincmd k | catch /^Vim\%((\a\+)\)\=:E11:/ | close | endtry]] },
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

      { 'z', require('true-zen.ataraxis').toggle, { desc = 'maximize' } },
      { '<C-z>', require('true-zen.ataraxis').off, { exit = true, desc = false } },

      { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
      { '<C-o>', '<C-w>o', { exit = true, desc = false } },

      { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

      { 'c', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]] },
      { 'q', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = 'close window' } },
      { '<C-q>', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },
      { '<C-c>', vim.cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },

      { '<Esc>', nil, { exit = true, desc = false } }
    }
  })
end

return M
