---@diagnostic disable: undefined-field
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- SmartSplit.nvim
local function is_vim(pane)
  local prog = pane:get_user_vars().WEZTERM_PROG
  return pane:get_user_vars().IS_NVIM or prog:match("^vim") or prog:match("^nvim") or prog:match("^v ")
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

config.window_background_opacity = 0.80
config.macos_window_background_blur = 10
-- config.debug_key_events = true,
-- config.default_gui_startup_args = { "connect", "unix" }
config.unix_domains = { { name = "unix" } }
config.ssh_domains = {
  {
    name = "gpu",
    remote_address = "gpu",
    username = "phuc",
    local_echo_threshold_ms = 100,
  },
  {
    name = "carles",
    remote_address = "carles",
    username = "phuc",
  },
}

config.font = wezterm.font_with_fallback({
  -- { family="Cascadia Code", harfbuzz_features={"calt", "ss01", "ss02"}, },
  { family = "IBM Plex Mono" },
  { family = "Rec Mono Duotone" },
  { family = "JetBrains Mono" },
})
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.font_size = 15
config.color_scheme = "catppuccin-frappe"

config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.keys = {
  { key = "_", mods = "CMD|SHIFT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "|", mods = "CMD|SHIFT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

  { key = 'X', mods = 'CMD', action = act.ActivateCopyMode },
  { key = 'Z', mods = 'CMD', action = act.TogglePaneZoomState },
  { key = 'p', mods = 'CMD', action = act.ActivateCommandPalette },

  { key = 'phys:Space', mods = 'CMD|SHIFT', action = act.QuickSelect },

  { key = 'PageUp',   mods = '', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = '', action = act.ScrollByPage(1) },

  { key = '>', mods = 'CMD|SHIFT', action = act.MoveTabRelative(1) },
  { key = '<', mods = 'CMD|SHIFT', action = act.MoveTabRelative(-1) },

  { key = "Enter", mods = "SHIFT", action = act.DisableDefaultAssignment },

  { key = 'h', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Down' },

  { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },
  { key = 'Enter', mods = 'CMD|ALT', action = act.ToggleFullScreen, },
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
--config.mouse_bindings = {
--   { event={Down={streak=3, button="Left"}},
--     action={SelectTextAtMouseCursor="SemanticZone"},
--     mods="NONE"
--   },
-- },
config.enable_kitty_graphics = true

return config
