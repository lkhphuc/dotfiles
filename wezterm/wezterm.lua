local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- ZenMode.nvim
wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
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

config.warn_about_missing_glyphs = false
config.enable_wayland = false
config.window_background_opacity = 0.80
config.macos_window_background_blur = 10
-- config.debug_key_events = true,
-- config.default_gui_startup_args = { "connect", "unix" }
config.unix_domains = {
  {
    name = "gpu",
    proxy_command = { "ssh", "-T", "gpu", "wezterm", "cli", "proxy", },
  },
}
config.ssh_domains = wezterm.default_ssh_domains()

config.font = wezterm.font_with_fallback({
  -- { family = "0xProto Nerd Font" },
  { family = "Cascadia Code" },
  { family = "Rec Mono Duotone" },
  { family = "Victor Mono", weight = "Medium" },
  { family = "JetBrains Mono" },
})
config.harfbuzz_features = {
  "calt", "clig", "dlig", "liga", "ss01", "ss02",
  "ss03", "ss04", "ss05", "ss06", "ss07", "ss08",
}
config.font_size = 15
config.underline_position = "-2pt"
config.color_scheme = "kanagawabones"

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.tab_max_width = 32
config.window_frame = {
  font_size = 14.0,
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.75,
}


config.mouse_bindings = {
  {
    event = { Down = { streak = 2, button = 'Right' } },
    action = wezterm.action.SelectTextAtMouseCursor 'Block',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 4, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}
config.keys = {
  { key = "_", mods = "CMD", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "|", mods = "CMD", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "_", mods = "CTRL|SHIFT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "|", mods = "CTRL|SHIFT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

  { key = "p", mods = "CMD", action = act.ActivateCommandPalette },
  { key = "z", mods = "CMD", action = act.TogglePaneZoomState },
  { key = "V", mods = "CMD", action = act.ActivateCopyMode },
  { key = "s", mods = "CTRL|SHIFT", action = act.QuickSelect },
  { key = "s", mods = "CMD", action = act.QuickSelect },
  { key = "+", mods = "CMD", action = act.IncreaseFontSize },

  { key = "PageUp", mods = "", action = act.ScrollByPage(-1) },
  { key = "PageDown", mods = "", action = act.ScrollByPage(1) },
  { key = "PageUp", mods = "CMD", action = act.ScrollToPrompt(-1) },
  { key = "PageDown", mods = "CMD", action = act.ScrollToPrompt(1) },

  { key = ">", mods = "CMD|SHIFT", action = act.MoveTabRelative(1) },
  { key = "<", mods = "CMD|SHIFT", action = act.MoveTabRelative(-1) },
  -- { key = "d", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "d", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "d", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "g", mods = "CMD", action = act.SpawnTab("DefaultDomain") },
  { key = "g", mods = "CTRL|SHIFT", action = act.SpawnTab("DefaultDomain") },
  { key = "l", mods = "CMD", action = act.ActivateLastTab },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivateLastTab },

  { key = "Enter", mods = "SHIFT", action = act.DisableDefaultAssignment },
  -- { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
  { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = 'L', mods = 'CMD', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', }, },
  { key = 'T', mods = 'CMD',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then window:perform_action(act.SwitchToWorkspace { name = line, }, pane) end
      end),
    },
  },

  { key = "]", mods = "CMD", action = act.RotatePanes("Clockwise") },
  { key = "[", mods = "CMD", action = act.RotatePanes("CounterClockwise") },
}
config.enable_kitty_graphics = true

wezterm.on("update-status", function(window, pane)
  local right_status = ""
  local workspace = window.active_workspace()
  if workspace ~= "default" then
    right_status = right_status .. workspace
  end
  local meta = pane:get_metadata() or {}
  if meta.is_tardy then
    local secs = meta.since_last_response_ms / 1000.0
    right_status = string.format("tardy: %5.1fs⏳", secs) + right_status
  end
  window:set_right_status(right_status)
end)

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then return title end
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
  if has_unseen_output then title = title .. " ●" end

  return title
end)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end
  local host = ''
  if pane.domain_name and pane.domain_name ~= "local" then
    host = " (" .. pane.domain_name .. ") "
  end

  return zoomed .. index .. tab.active_pane.title .. host
end)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
  direction_keys = { "h", "j", "k", "l" },
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})
smart_splits.apply_to_config(config, {
  direction_keys = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

return config
