local wezterm = require 'wezterm';

return {
  ssh_domains = {
    {
      name = "gpu",
      remote_address = "gpu-et",
      username = "phuc",
    },
    {
      name = "carles",
      remote_address = "carles",
      username = "phuc"
    },
  },

  font = wezterm.font_with_fallback({
    {family="Rec Mono Duotone"},
    {family="Victor Mono"},
    {family="Libertinus Mono"},
    {family="Hack Nerd Font"},
    {family="JetBrainsMono Nerd Font"}
  }),
  font_size = 14,
  color_scheme = "OneDark",

  keys = {
    {key="s", mods="CMD", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}
    }
  }
}
