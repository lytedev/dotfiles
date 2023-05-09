local wezterm = require("wezterm")

local M = {}

local colors = {
	latte = {
		rosewater = "#dc8a78",
		flamingo = "#dd7878",
		pink = "#ea76cb",
		mauve = "#8839ef",
		red = "#d20f39",
		maroon = "#e64553",
		peach = "#fe640b",
		yellow = "#df8e1d",
		green = "#40a02b",
		teal = "#179299",
		sky = "#04a5e5",
		sapphire = "#209fb5",
		blue = "#1e66f5",
		lavender = "#7287fd",
		text = "#4c4f69",
		subtext1 = "#5c5f77",
		subtext0 = "#6c6f85",
		overlay2 = "#7c7f93",
		overlay1 = "#8c8fa1",
		overlay0 = "#9ca0b0",
		surface2 = "#acb0be",
		surface1 = "#bcc0cc",
		surface0 = "#ccd0da",
		crust = "#dce0e8",
		mantle = "#e6e9ef",
		base = "#eff1f5",
	},
	frappe = {
		rosewater = "#f2d5cf",
		flamingo = "#eebebe",
		pink = "#f4b8e4",
		mauve = "#ca9ee6",
		red = "#e78284",
		maroon = "#ea999c",
		peach = "#ef9f76",
		yellow = "#e5c890",
		green = "#a6d189",
		teal = "#81c8be",
		sky = "#99d1db",
		sapphire = "#85c1dc",
		blue = "#8caaee",
		lavender = "#babbf1",
		text = "#c6d0f5",
		subtext1 = "#b5bfe2",
		subtext0 = "#a5adce",
		overlay2 = "#949cbb",
		overlay1 = "#838ba7",
		overlay0 = "#737994",
		surface2 = "#626880",
		surface1 = "#51576d",
		surface0 = "#414559",
		base = "#303446",
		mantle = "#292c3c",
		crust = "#232634",
	},
	macchiato = {
		rosewater = "#f4dbd6",
		flamingo = "#f0c6c6",
		pink = "#f5bde6",
		mauve = "#c6a0f6",
		red = "#ed8796",
		maroon = "#ee99a0",
		peach = "#f5a97f",
		yellow = "#eed49f",
		green = "#a6da95",
		teal = "#8bd5ca",
		sky = "#91d7e3",
		sapphire = "#7dc4e4",
		blue = "#8aadf4",
		lavender = "#b7bdf8",
		text = "#cad3f5",
		subtext1 = "#b8c0e0",
		subtext0 = "#a5adcb",
		overlay2 = "#939ab7",
		overlay1 = "#8087a2",
		overlay0 = "#6e738d",
		surface2 = "#5b6078",
		surface1 = "#494d64",
		surface0 = "#363a4f",
		base = "#24273a",
		mantle = "#1e2030",
		crust = "#181926",
	},
	mocha = {
		rosewater = "#f5e0dc",
		flamingo = "#f2cdcd",
		pink = "#f5c2e7",
		mauve = "#cba6f7",
		red = "#f38ba8",
		maroon = "#eba0ac",
		peach = "#fab387",
		yellow = "#f9e2af",
		green = "#a6e3a1",
		teal = "#94e2d5",
		sky = "#89dceb",
		sapphire = "#74c7ec",
		blue = "#89b4fa",
		lavender = "#b4befe",
		text = "#cdd6f4",
		subtext1 = "#bac2de",
		subtext0 = "#a6adc8",
		overlay2 = "#9399b2",
		overlay1 = "#7f849c",
		overlay0 = "#6c7086",
		surface2 = "#585b70",
		surface1 = "#45475a",
		surface0 = "#313244",
		base = "#1e1e2e",
		mantle = "#181825",
		crust = "#11111b",
	},
}

local mappings = {
	mocha = "Catppuccin Mocha",
	macchiato = "Catppuccin Macchiato",
	frappe = "Catppuccin Frappe",
	latte = "Catppuccin Latte",
}

function M.select(palette, flavor, accent)
	local c = palette[flavor]
	-- shorthand to check for the Latte flavor
	local isLatte = palette == "latte"

	return {
		foreground = c.text,
		background = c.base,

		cursor_fg = isLatte and c.base or c.crust,
		cursor_bg = c.rosewater,
		cursor_border = c.rosewater,

		selection_fg = c.text,
		selection_bg = c.surface2,

		scrollbar_thumb = c.surface2,

		split = c.overlay0,

		ansi = {
			isLatte and c.subtext1 or c.surface1,
			c.red,
			c.green,
			c.yellow,
			c.blue,
			c.pink,
			c.teal,
			isLatte and c.surface2 or c.subtext1,
		},

		brights = {
			isLatte and c.subtext0 or c.surface2,
			c.red,
			c.green,
			c.yellow,
			c.blue,
			c.pink,
			c.teal,
			isLatte and c.surface1 or c.subtext0,
		},

		indexed = { [16] = c.peach, [17] = c.rosewater },

		-- nightbuild only
		compose_cursor = c.flamingo,

		tab_bar = {
			background = c.mantle,
			active_tab = {
				bg_color = c.mantle,
				fg_color = c[accent],
			},
			inactive_tab = {
				bg_color = c.crust,
				fg_color = c.surface1,
			},
			inactive_tab_hover = {
				bg_color = c.base,
				fg_color = c.text,
			},
			new_tab = {
				bg_color = c.mantle,
				fg_color = c.text,
			},
			new_tab_hover = {
				bg_color = c.surface1,
				fg_color = c[accent],
			},
			-- fancy tab bar
			inactive_tab_edge = c.surface0,
		},

		visual_bell = c.surface0,
	}
end

local function select_for_appearance(appearance, options)
	if appearance:find("Dark") then
		return options.dark
	else
		return options.light
	end
end

local function tableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

function M.apply_to_config(c, opts)
	if not opts then
		opts = {}
	end

	-- default options
	local defaults = {
		flavor = "mocha",
		accent = "sapphire",
		sync = false,
		sync_flavors = { light = "latte", dark = "mocha" },
		color_overrides = { mocha = {}, macchiato = {}, frappe = {}, latte = {} },
		token_overrides = { mocha = {}, macchiato = {}, frappe = {}, latte = {} },
	}

	local o = tableMerge(defaults, opts)

	-- insert all flavors
	local color_schemes = {}
	local palette = tableMerge(colors, o.color_overrides)
	for flavor, name in pairs(mappings) do
		local spec = M.select(palette, flavor, o.accent)
    local overrides = o.token_overrides[flavor]
		color_schemes[name] = tableMerge(spec, overrides)
	end
	if c.color_schemes == nil then
		c.color_schemes = {}
	end
	c.color_schemes = tableMerge(c.color_schemes, color_schemes)

	if opts.sync then
		c.color_scheme = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = mappings[o.sync_flavors.dark],
			light = mappings[o.sync_flavors.light],
		})
		c.command_palette_bg_color = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = colors[o.sync_flavors.dark].crust,
			light = colors[o.sync_flavors.light].crust,
		})
		c.command_palette_fg_color = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = colors[o.sync_flavors.dark].text,
			light = colors[o.sync_flavors.light].text,
		})
	else
		c.color_scheme = mappings[o.flavor]
		c.command_palette_bg_color = colors[o.flavor].crust
		c.command_palette_fg_color = colors[o.flavor].text
	end

	local window_frame = {
		active_titlebar_bg = colors[o.flavor].crust,
		active_titlebar_fg = colors[o.flavor].text,
		inactive_titlebar_bg = colors[o.flavor].crust,
		inactive_titlebar_fg = colors[o.flavor].text,
		button_fg = colors[o.flavor].base,
		button_bg = colors[o.flavor].base,
	}

	if c.window_frame == nil then
		c.window_frame = {}
	end
	c.window_frame = tableMerge(c.window_frame, window_frame)
end

return M