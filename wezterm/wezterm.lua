local wezterm = require 'wezterm';
local act = wezterm.action;

local function isViProcess(pane)
  return pane:get_foreground_process_name():find('n?vim') ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = 'CTRL' }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
  conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
  conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
  conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
  conditionalActivatePane(window, pane, 'Down', 'j')
end)


return {
  -- default_gui_startup_args = {"connect", "gpu"},
  ssh_domains = {
    {
      name = "gpu",
      remote_address = "gpu",
      username = "phuc",
      local_echo_threshold_ms = 100,
    },
    {
      name = "carles",
      remote_address = "carles",
      username = "phuc"
    },
  },

  font = wezterm.font_with_fallback({
    { family="Cascadia Code",
      harfbuzz_features={"calt", "ss01", "ss02"},
    },
    { family="Rec Mono Duotone", },
    { family = "JetBrains Mono" },
    { family = "Symbols Nerd Font" },
  }),
  allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  font_size = 14,
  color_scheme = "Catppuccin Mocha",

  window_padding = {
    left   = "0.1cell",
    right  = "0.1cell",
    top    = "0.0cell",
    bottom = "0.0cell",
  },
  window_decorations = "RESIZE",

  keys = {
    { key = "_", mods = "CMD|SHIFT", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "|", mods = "CMD|SHIFT", action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "Enter", mods = "SHIFT", action = act.DisableDefaultAssignment},
    { key = "w", mods = "CMD", action = wezterm.action { CloseCurrentPane = { confirm = true } } },

    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },

    { key = "UpArrow", mods = "SHIFT", action = wezterm.action { ScrollToPrompt = -1 } },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action { ScrollToPrompt = 1 } },
  },
  -- mouse_bindings = {
  --   { event={Down={streak=3, button="Left"}},
  --     action={SelectTextAtMouseCursor="SemanticZone"},
  --     mods="NONE"
  --   },
  -- },
  enable_kitty_graphics=true,
}
