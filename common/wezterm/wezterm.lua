local w = require 'wezterm'
return {
	color_schemes = {
		["Donokai"] = {
			background = "#111111",
			foreground = "#ffffff",
			cursor_bg = "#333333",
			cursor_fg = "#ffffff",
			cursor_border = "#666666",
			selection_fg = "black",
			selection_bg = "cyan",

			ansi = {"#111111", "#f92672", "#a6e22e", "#f4bf75", "#ae81ff", "#fd971f", "#a1efe4", "#888888"},
			brights = {"#333333", "#f92672", "#a6e22e", "#f4bf75", "#ae81ff", "#fd971f", "#a1efe4", "#888888"},
      -- ansi = {"black", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},
      -- brights = {"grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},
		}
	},
	color_scheme = "Donokai",
	colors = {
	},
	font = w.font("Iosevka"),
	font_size = 14,
  enable_wayland = true,
}
