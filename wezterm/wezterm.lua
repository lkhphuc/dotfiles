local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({
    {family="Rec Mono Duotone"},
    {family="JetBrainsMono Nerd Font Mono"}
  }),
  font_size = 14,
  color_scheme = "OneHalfDark",
}
