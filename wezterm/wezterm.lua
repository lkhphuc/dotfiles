---@diagnostic disable: undefined-field
local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local function isViProcess(pane)
  local prog = pane:get_user_vars()["WEZTERM_PROG"]
  return prog:match("^nvim") or prog:match("^v")
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      wezterm.action.SendKey({ key = vim_direction, mods = "CTRL" }),
      pane
    )
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
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

-- config.window_background_opacity = 0.9,
-- config.debug_key_events = true,
config.default_gui_startup_args = { "connect", "unix" }
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
  {
    key = "_",
    mods = "CMD|SHIFT",
    action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
  },
  {
    key = "|",
    mods = "CMD|SHIFT",
    action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
  },
  { key = "Enter", mods = "SHIFT", action = wezterm.action.DisableDefaultAssignment },
  { key = "w", mods = "CMD", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

  { key = "h", mods = "CTRL", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
  { key = "j", mods = "CTRL", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
  { key = "k", mods = "CTRL", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
  { key = "l", mods = "CTRL", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },

  { key = "UpArrow", mods = "SHIFT", action = wezterm.action({ ScrollToPrompt = -1 }) },
  { key = "DownArrow", mods = "SHIFT", action = wezterm.action({ ScrollToPrompt = 1 }) },
}
--config.mouse_bindings = {
--   { event={Down={streak=3, button="Left"}},
--     action={SelectTextAtMouseCursor="SemanticZone"},
--     mods="NONE"
--   },
-- },
config.enable_kitty_graphics = true

return config
