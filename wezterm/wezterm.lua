---@diagnostic disable: undefined-field
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local function isViProcess(pane)
  local prog = pane:get_user_vars()["WEZTERM_PROG"]
  local isVi = prog:match("^nvim") or prog:match("^v") or prog:match("^vim")
  return isVi
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = "CTRL" }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditionalActivatePane(window, pane, "Down", "j")
end)

config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
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
config.window_padding = {left=0, right=0, top=0, bottom=0}

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

  { key = "h", mods = "CTRL",     action = act.EmitEvent("ActivatePaneDirection-left") },
  { key = "l", mods = "CTRL",     action = act.EmitEvent("ActivatePaneDirection-right") },
  { key = "k", mods = "CTRL",     action = act.EmitEvent("ActivatePaneDirection-up") },
  { key = "j", mods = "CTRL",     action = act.EmitEvent("ActivatePaneDirection-down") },
  { key = 'h', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|CMD', action = act.ActivatePaneDirection 'Down' },

  { key = 'h', mods = 'CMD|ALT', action = act.AdjustPaneSize{ 'Left',  1 } },
  { key = 'l', mods = 'CMD|ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
  { key = 'k', mods = 'CMD|ALT', action = act.AdjustPaneSize{ 'Up',    1 } },
  { key = 'j', mods = 'CMD|ALT', action = act.AdjustPaneSize{ 'Down',  1 } },
}
--config.mouse_bindings = {
--   { event={Down={streak=3, button="Left"}},
--     action={SelectTextAtMouseCursor="SemanticZone"},
--     mods="NONE"
--   },
-- },
config.enable_kitty_graphics = true

return config
