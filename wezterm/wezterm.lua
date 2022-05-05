local wezterm = require 'wezterm';
local os = require("os")

local move_around = function(window, pane, direction_wez, direction_nvim)
  local result = os.execute("env NVIM_LISTEN_ADDRESS=/tmp/nvim" .. pane:pane_id() ..  " $HOME/go/bin/wezterm.nvim.navigator " .. direction_nvim)
  if result then
    window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
  else
    window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
  end
end


wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)


return {
  -- default_gui_startup_args = {"connect", "gpu"},
  ssh_domains = {
    {
      name = "gpu",
      remote_address = "gpu-et",
      username = "phuc",
      local_echo_threshold_ms = 100,
      -- remote_wezterm_path = "/home/linuxbrew/.linuxbrew/bin/wezterm",
    },
    {
      name = "carles",
      remote_address = "carles",
      username = "phuc"
    },
  },

  font = wezterm.font_with_fallback({
    { family="Cascadia Code",
      harfbuzz_features={"calt", "ss01"},
    },
    -- {family="Rec Mono Duotone"},
    -- {family="VictorMono Nerd Font", weight="Medium"},
    {family="JetBrainsMono Nerd Font"},
  }),
  allow_square_glyphs_to_overflow_width = "Always",
  -- allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  font_size = 14,
  color_scheme = "OneHalfDark",

  window_padding = {
    left   = "0cell",
    right  = "0cell",
    top    = "0cell",
    bottom = "0cell",
  },

  keys = {
    {key = "_", mods="CMD|SHIFT", action=wezterm.action{SplitVertical   = {domain="CurrentPaneDomain"}}},
    {key = "|", mods="CMD|SHIFT", action=wezterm.action{SplitHorizontal = {domain="CurrentPaneDomain"}}},
    {key = "Enter", mods="SHIFT", action="DisableDefaultAssignment"},
    -- pane move(vim aware)
    { key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-left"  }) },
    { key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-right" }) },
    { key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-up"    }) },
    { key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-down"  }) },

    {key="UpArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=-1}},
    {key="DownArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=1}},
  },
  -- mouse_bindings = {
  --   { event={Down={streak=3, button="Left"}},
  --     action={SelectTextAtMouseCursor="SemanticZone"},
  --     mods="NONE"
  --   },
  -- },
}
