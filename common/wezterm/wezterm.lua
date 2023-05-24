local wezterm = require 'wezterm'
local catpuccin = require 'catpuccin'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local hostname = io.popen("/bin/hostname"):read("*a"):gsub("%s", "")
local font_spec = { family = 'IosevkaLyteTerm', weight = 'Regular', italic = false }
local font_size = 12.0

if hostname == "laptop" then
  font_size = 13
end

local font = wezterm.font_with_fallback{
  font_spec,
  { family = 'Symbols Nerd Font Mono', weight = 'Regular', italic = false },
  'Noto Color Emoji',
}

if hostname == "laptop" then
  config.font_rules = {
    -- no italics
    {
      font = font
    },
  }
end

config.default_cursor_style = 'BlinkingBar'

catpuccin.apply_to_config(config)

config.font = font
config.font_size = font_size

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 1.0

config.color_scheme = "Catppuccin Mocha"

config.window_frame.font = config.font
config.window_frame.font_size = font_size

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
    key = 'Insert',
    mods = 'SHIFT',
    action = wezterm.action.PasteFrom'Clipboard'
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom'PrimarySelection'
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

-- config.default_gui_startup_args = { 'connect', 'unix' }

config.window_padding = {
  top = '0.5cell',
  bottom = '0.5cell',
  left = '1cell',
  right = '1cell',
}

return config
