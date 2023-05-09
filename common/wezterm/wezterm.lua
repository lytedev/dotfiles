local wezterm = require 'wezterm'
local catpuccin = require 'catpuccin'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_cursor_style = 'BlinkingBar'

catpuccin.apply_to_config(config)

config.font = wezterm.font('IosevkaLyteTerm', { weight = 'Regular', italic = false })
config.font_size = 12.0

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_background_opacity = 1.0

config.color_scheme = "Catppuccin Mocha"

config.window_frame.font = wezterm.font { family = 'IosevkaLyteTerm', weight = 'Regular' }
config.window_frame.font_size = 12.0

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}

config.keys = {
  {
    key = 'j',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection'Down'
  },
  {
    key = 'h',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection'Left'
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection'Right'
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection'Up'
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical{domain='CurrentPaneDomain'}
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal{domain='CurrentPaneDomain'}
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.ShowDebugOverlay
  },
}

config.default_gui_startup_args = { 'connect', 'unix' }

return config
