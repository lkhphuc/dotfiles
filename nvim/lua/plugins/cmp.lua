return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "abecodes/tabout.nvim", opts = {} },
    { "lukas-reineke/cmp-under-comparator" },

    {
      "L3MON4D3/LuaSnip",
      keys = function() return {} end, -- override LazyVim to configure suptertab
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    { "saadparwaiz1/cmp_luasnip" },

    "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-nvim-lsp-document-symbol", -- For / search command
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "ray-x/cmp-treesitter",
    -- "quangnguyen30192/cmp-nvim-tags",

    "tzachar/fuzzy.nvim",
    "tzachar/cmp-fuzzy-path",
    "tzachar/cmp-fuzzy-buffer",
    -- 'lukas-reineke/cmp-rg',

    -- {'tzachar/cmp-tabnine', build='./install.sh' },
    { "zbirenbaum/copilot.lua", opts = {} },
    {
      "zbirenbaum/copilot-cmp",
      opts = {},
      init = function() vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" }) end,
    },
  },
  opts = function(_, opts)
    opts.window = {
      -- completion = cmp.config.window.bordered(),
      completion = {
        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        -- border = "none",
        col_offset = -4, -- to align text when 2 icons are prepended
        -- padding = 0,
      },
    }

    -- Super tab completion
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local compare = require("cmp.config.compare")
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })
    opts.formatting = {
      fields = { "menu", "kind", "abbr" },
      format = function(entry, vim_item)
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        local item = require("lspkind").cmp_format({
          mode = "symbol",
          preset = "codicons",
          menu = {
            nvim_lsp = "",
            luasnip = "",
            treesitter = "",
            tags = "",
            buffer = "",
            fuzzy_buffer = "",
            path = "",
            fuzzy_path = "",
            copilot = "",
            cmp_tabnine = "9",
            rg = "",
          },
          symbol_map = { Copilot = "" },
        })(entry, vim_item)
        return vim_item
      end,
    }
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "treesitter" },
      { name = "buffer" },
      { name = "fuzzy_path" },
      { name = "tags" },
      { name = "copilot" },
      -- { name = 'cmp_tabnine' },
      -- { name = 'rg' },
    })
    -- opts.sorting = {
    --   priority_weight = 2,
    --   comparators = {
    --     -- require("cmp_fuzzy_buffer.compare"),
    --     -- require("cmp_fuzzy_path.compare"),
    --     compare.offset,
    --     compare.exact,
    --     compare.score,
    --     compare.recently_used,
    --     compare.kind,
    --     compare.sort_text,
    --     compare.length,
    --     compare.order,
    --     require("copilot_cmp.comparators").prioritize,
    --     require("copilot_cmp.comparators").score,
    --   },
    -- }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "treesitter" },
        {
          name = "fuzzy_buffer",
          option = {
            get_bufnrs = function() -- Get all opened buffers
              local bufs = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                if buftype ~= "nofile" and buftype ~= "prompt" then bufs[#bufs + 1] = buf end
              end
              return bufs
            end,
          },
        },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "cmdline_history" },
        { name = "fuzzy_path" },
      }),
    })
  end,
}
