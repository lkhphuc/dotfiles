local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

gl.short_line_list = {" "}

local global_theme = "themes/" .. vim.g.theme
local colors = require(global_theme)

gls.left[#gls.left+1] = {
    FirstElement = {
        provider = function()
            return "▋"
        end,
        highlight = {colors.nord_blue, colors.nord_blue}
    }
}

gls.left[#gls.left+1] = {
    statusIcon = {
        provider = function()
            return "  "
        end,
        highlight = {colors.statusline_bg, colors.nord_blue},
        separator = " ",
        separator_highlight = {colors.nord_blue, colors.lightbg}
    }
}

gls.left[#gls.left+1] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg}
    }
}

gls.left[#gls.left+1] = {
    FileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg},
        separator = "",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.left[#gls.left+1] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name
        end,
        highlight = {colors.grey_fg2, colors.lightbg2},
        separator = " ",
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[#gls.left+1] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.green, colors.statusline_bg}
    }
}

gls.left[#gls.left+1] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.nord_blue, colors.statusline_bg}
    }
}

gls.left[#gls.left+1] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}

gls.left[#gls.left+1] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = " ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[#gls.left+1] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = " ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}

gls.right[#gls.right+1] = {
    python = {
        provider = function()
            local env_name = os.getenv('CONDA_DEFAULT_ENV')
            if env_name == nil then
                env_name = ""
            end return env_name .. ""
        end,
        condition = function()
            if vim.bo.filetype == 'python' then
                return true
            end return false
        end,
        icon = ' ',
        highlight = {colors.grey_fg2, colors.start_line_bg},
    }
}

gls.right[#gls.right+1] = {
    lsp_status = {
        provider = function() return "  LSP" end,
        condition = function()
            if next(vim.lsp.get_active_clients()) ~= nil then
                return true
            end return false
        end,
        highlight = {colors.grey_fg2, colors.statusline_bg},
    }
}

gls.right[#gls.right+1] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.grey_fg2, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.statusline_bg}
    }
}

gls.right[#gls.right+1] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.grey_fg2, colors.lightbg}
    }
}

gls.right[#gls.right+1] = {
    viMode_icon = {
        provider = function()
            return " "
        end,
        highlight = {colors.statusline_bg, colors.red},
        separator = " ",
        separator_highlight = {colors.red, colors.lightbg}
    }
}

gls.right[#gls.right+1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual",
                [""] = "Visual",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            if current_Mode == nil then
                return "  Terminal "
            else
                return "  " .. current_Mode
            end
        end,
        highlight = {colors.red, colors.lightbg}
    }
}

gls.right[#gls.right+1] = {
    some_icon = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.green, colors.lightbg},
        highlight = {colors.lightbg, colors.green}
    }
}

gls.right[#gls.right+1] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return "  Top"
            elseif current_line == vim.fn.line("$") then
                return "  Bot"
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. result .. "%"
        end,
        highlight = {colors.green, colors.lightbg}
    }
}

local NeomuxProvider = {
    Neomux = { -- Add neomux window nums if neomux is present
        provider = function()
            if vim.fn.exists("*WindowNumber") ~= 0 then
                return vim.api.nvim_exec([[echo "  " . WindowNumber()]], true)
            else
                return ""
            end
        end,
        separator = " ",
        separator_highlight = {colors.teal, colors.lightbg},
        highlight = {colors.lightbg, colors.teal}
    }
}

gls.right[#gls.right+1] = NeomuxProvider

-- Short line when not active
gls.short_line_left[#gls.short_line_left+1] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.grey, colors.lightbg}
    }
}

gls.short_line_left[#gls.short_line_left+1] = {
    FileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.short_line_right[#gls.short_line_right+1] = {BufferIcon = {provider = "BufferIcon", highlight = {colors.white, colors.lightbg}}}
gls.short_line_right[#gls.short_line_right+1] = NeomuxProvider
