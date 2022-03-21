local wezterm = require 'wezterm';

return {
  ssh_domains = {
    {
      name = "gpu",
      remote_address = "gpu-et",
      username = "phuc",
      -- remote_wezterm_path = "/home/linuxbrew/.linuxbrew/bin/wezterm",
    },
    {
      name = "carles",
      remote_address = "carles",
      username = "phuc"
    },
  },

  font = wezterm.font_with_fallback({
    {
      family="Cascadia Code",
      harfbuzz_features={"calt", "ss01"},
    },
    {family="Rec Mono Duotone"},
    {family="VictorMono Nerd Font", weight="Medium"},
    {family="JetBrainsMono Nerd Font"},
  }),
  -- allow_square_glyphs_to_overflow_width = "Always",
  allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace", -- or consider "Always"
  font_size = 14,
  color_scheme = "OneHalfDark",

  window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
  },

  keys = {
    {key="_", mods="CMD|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="\\", mods="CMD|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  }
}
