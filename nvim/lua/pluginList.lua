local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require("packer")
local use = packer.use

return packer.startup({
    function()
        use "wbthomason/packer.nvim"

        use "akinsho/nvim-bufferline.lua"
        use "glepnir/galaxyline.nvim"

        -- color related stuff
        use "siduck76/nvim-base16.lua"
        use "christianchiarulli/nvcode-color-schemes.vim"
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function() require("treesitter-nvim").config() end,
            requires = {
            }
        }
        use "nvim-treesitter/nvim-treesitter-refactor"
        use "nvim-treesitter/nvim-treesitter-textobjects"
        use "romgrk/nvim-treesitter-context"
        use "p00f/nvim-ts-rainbow"
        use 'JoosepAlviste/nvim-ts-context-commentstring'

        use {
          "neovim/nvim-lspconfig",
          event = "BufRead",
          config = function()
            require"nvim-lspconfig".config()
          end
        }
        use "ray-x/lsp_signature.nvim"
        -- use "RRethy/vim-illuminate"
        use "simrat39/symbols-outline.nvim"
        use "kabouzeid/nvim-lspinstall"
       --  use {
       --    "ray-x/navigator.lua",
       --    requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
       --    config = function() require"navigator".setup() end,
       -- }
        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }

        use "folke/which-key.nvim"
        use "machakann/vim-highlightedyank"
        use "romainl/vim-cool"  -- Handle highlight search automatically
        use "sindrets/diffview.nvim"

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("compe-completion").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("compe-completion").snippets()
                    end
                },
                "rafamadriz/friendly-snippets",
                {"tzachar/compe-tabnine", run="./install.sh"},
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require("nvimTree").config()
            end
        }

        use "kyazdani42/nvim-web-devicons"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("telescope-nvim").config()
            end
        }

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("gitsigns-nvim").config()
            end
        }

        use "voldikss/vim-floaterm"
          vim.g.floaterm_keymap_next   = '<End>'   -- Hyper+o
          vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
          vim.g.floaterm_keymap_new    = '<S-Home>'-- Hyper+Command+i
          vim.g.floaterm_keymap_toggle = '<Home>'  -- Hyper+i
          vim.g.floaterm_position = 'center'
          vim.g.floaterm_width = 0.9
          vim.g.floaterm_height = 0.9

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup()
            end
        }

        use {"andymass/vim-matchup", event = "CursorMoved"}

        use {
            "terrortylor/nvim-comment",
            event = "BufRead",
            config = function()
              require("nvim_comment").setup()
            end
        }

        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks",
                "SessionLoad",
                "SessionSave"
            },
            setup = function()
                require("dashboard").config()
            end
        }

        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

        -- load autosave only if its globally enabled
        use {
            "907th/vim-auto-save",
            cond = function()
                return vim.g.auto_save == 1
            end
        }

        -- smooth scroll
        use {
            "karb94/neoscroll.nvim",
            event = "WinScrolled",
            config = function()
                require("neoscroll").setup()
            end
        }

        use {
            "kdav5758/TrueZen.nvim",
            cmd = {"TZAtaraxis", "TZMinimalist"},
            config = function()
                require("zenmode").config()
            end
        }

        --   use "alvan/vim-closetag" -- for html autoclosing tag

        use {
            "lukas-reineke/indent-blankline.nvim",
            branch = "lua",
            event = "BufRead",
            setup = function()
                require("misc-utils").blankline()
            end
        }


        use "ojroques/vim-oscyank"
          vim.api.nvim_exec([[
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
            ]], false)
        use "mattboehm/vim-unstack"

        -- text editing
        use "tpope/vim-surround"
        use "tpope/vim-repeat"
        use "tpope/vim-sleuth"  --One plugin everything tab indent
        use "tpope/vim-unimpaired"
        use "junegunn/vim-easy-align"
          vim.cmd [[xmap ga <Plug>(EasyAlign)]]
          vim.cmd [[nmap ga <Plug>(EasyAlign)]]
        use "ggandor/lightspeed.nvim"
        use "AndrewRadev/splitjoin.vim" -- gS and gJ
        use "simnalamburt/vim-mundo"
          vim.g.mundo_right = 1
          vim.cmd [[noremap <leader>u :MundoToggle<CR> ]]
        use "wellle/targets.vim"
    end,
    config = {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
            open_fn = require('packer.util').float,
        }
    }
  }
)
