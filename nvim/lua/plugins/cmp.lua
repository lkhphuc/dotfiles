local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    'hrsh7th/cmp-nvim-lsp-document-symbol', -- For / search command
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    'tzachar/fuzzy.nvim',
    'tzachar/cmp-fuzzy-path',
    'tzachar/cmp-fuzzy-buffer',
    "ray-x/cmp-treesitter",
    "quangnguyen30192/cmp-nvim-tags",
    -- 'lukas-reineke/cmp-rg',
    -- {'tzachar/cmp-tabnine', build='./install.sh' },
    { "zbirenbaum/copilot.lua", config = true },
    { "zbirenbaum/copilot-cmp",
      config = function ()
        require("copilot_cmp").setup({
            formatters = { insert_text = require("copilot_cmp.format").remove_existing }
        })
      end
    },

    -- Snippets plugin
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    "saadparwaiz1/cmp_luasnip",

    'onsails/lspkind.nvim', -- Add pictogram to LSP
  },
}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end



function M.config()
  vim.o.completeopt = 'menu,menuone,noselect' -- complete to comment string

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  local luasnip = require 'luasnip'
  local cmp = require 'cmp'
  local compare = require('cmp.config.compare')

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        border = "shadow",
        col_offset = -2,
        -- side_padding = 0,
      },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-l>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.complete_common_string()
        end
        fallback()
      end, { 'i', 'c' }),

    }),
    formatting = {
      fields = { "kind", "abbr", "menu", },
      format = function(entry, vim_item)
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
        local item = require("lspkind").cmp_format({
          maxwidth = 100,
          mode = "symbol_text",
          menu = {
            nvim_lsp = "",
            luasnip = "",
            treesitter = "",
            tags = "",
            buffer = "",
            fuzzy_buffer = "",
            path = "",
            fuzzy_path = "",
            copilot = "",
            cmp_tabnine = "",
            rg = "",
          },
          symbol_map = { Copilot = "" },
        })(entry, vim_item)
        local strings = vim.split(item.kind, "%s", { trimempty = false })
        item.kind = (strings[1] or " ")
        item.menu = (item.menu or " ") .. " " .. (strings[2] or "")
        return item
      end,
    },
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'treesitter' },
      { name = 'tags' },
      { name = 'fuzzy_buffer',
        option = {
          get_bufnrs = function() -- Get all opened buffers
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
              if buftype ~= 'nofile' and buftype ~= 'prompt' then
                bufs[#bufs + 1] = buf
              end
            end
            return bufs
          end
        },
      },
      { name = 'fuzzy_path' },
      { name = 'copilot', },
      -- { name = 'cmp_tabnine' },
      -- { name = 'rg' },
    },
    view = {
      entries = {name = 'custom', selection_order = 'near_cursor' }
    },
    experimental = {
      ghost_text = { hl_group = "LspCodeLens" },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
        require('cmp_fuzzy_buffer.compare'),
        require('cmp_fuzzy_path.compare'),
        require("copilot_cmp.comparators").prioritize,
      }
    }
  }

  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'fuzzy_buffer'},
      { name = 'nvim_lsp_document_symbol' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'fuzzy_path' },
    }),
  })
end

return M
