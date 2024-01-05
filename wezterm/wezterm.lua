---@diagnostic disable: undefined-field
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- SmartSplit.nvim
local function is_vim(pane)
  -- local prog = pane:get_user_vars().WEZTERM_PROG
  -- return prog:match("^vim") or prog:match("^nvim") or prog:match("^v ")
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l", -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end


-- ZenMode.nvim
wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

config.window_background_opacity = 0.75
config.macos_window_background_blur = 10
-- config.debug_key_events = true,
-- config.default_gui_startup_args = { "connect", "unix" }
config.unix_domains = { { name = "unix" } }

config.font = wezterm.font_with_fallback({
  { family = "Monaspace Argon",
    harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }
  },
  { family = "Cascadia Code", harfbuzz_features = { "calt", "ss01", "ss02" } },
  { family = "IBM Plex Mono" },
  { family = "Rec Mono Duotone" },
  { family = "JetBrains Mono" },
})
config.font_size = 15
config.underline_position = "-3pt"
config.color_scheme = "Tokyo Night"

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.keys = {
  { key = "_", mods = "CMD", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "|", mods = "CMD", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

  { key = 'p', mods = 'CMD', action = act.ActivateCommandPalette },
  { key = 'z', mods = 'CMD', action = act.TogglePaneZoomState },
  { key = 'V', mods = 'CMD', action = act.ActivateCopyMode },
  { key = ' ', mods = 'CMD|SHIFT', action = act.QuickSelect },
  { key = '+', mods = 'CMD', action = act.IncreaseFontSize },

  { key = 'PageUp',   mods = '', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = '', action = act.ScrollByPage(1) },

  { key = '>', mods = 'CMD|SHIFT', action = act.MoveTabRelative(1) },
  { key = '<', mods = 'CMD|SHIFT', action = act.MoveTabRelative(-1) },
  { key = "C", mods = "CMD", action = act.CloseCurrentPane({confirm=true}) },
  { key = "e", mods = "CMD", action = act.SpawnTab("DefaultDomain")},
  { key = "l", mods = "CMD", action = act.ActivateLastTab},

  { key = "Enter", mods = "SHIFT", action = act.DisableDefaultAssignment },
  { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },

  { key = ']', mods = "CMD", action = act.RotatePanes 'Clockwise'},
  { key = '[', mods = "CMD", action = act.RotatePanes 'CounterClockwise'},
  { key = 'h', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Down' },
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
}
config.enable_kitty_graphics = true

wezterm.on('update-status', function(window, pane)
  local meta = pane:get_metadata() or {}
  if meta.is_tardy then
    local secs = meta.since_last_response_ms / 1000.0
    window:set_right_status(string.format('tardy: %5.1fs⏳', secs))
  end
end)

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_index + 1 .. ": " .. tab_title(tab)
  local pane = tab.active_pane
  if pane.domain_name and pane.domain_name ~= "local" then
    title = title .. " (" .. pane.domain_name .. ") "
  end

  local has_unseen_output = false
  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      has_unseen_output = true
      break
    end
  end
  if has_unseen_output then
    title = title .. " ●"
  end

  return title
end)

return config
