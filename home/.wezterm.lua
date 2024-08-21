local wezterm = require("wezterm")

return {
	font = wezterm.font("IosevkaTermNerdFont", { weight = "Regular", italic = false }),
	font = wezterm.font("IosevkaTermNerdFont", { weight = "Bold", italic = false }),
	font_size = 11.0,

	-- Window padding
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},

	-- Disable window decorations
	window_decorations = "NONE",

	initial_rows = 24,
	initial_cols = 80,

	scrollback_lines = 10000,

	color_scheme = "Dracula",
	colors = {
		foreground = "#D0CFCC",
		background = "#181818",
		cursor_bg = "#ffffff",
		cursor_border = "#ffffff",
		cursor_fg = "#181818",
		selection_bg = "#44475a",
		selection_fg = "#f8f8f2",

		ansi = {
			"#21222c",
			"#ff5555",
			"#50fa7b",
			"#f1fa8c",
			"#bd93f9",
			"#ff79c6",
			"#8be9fd",
			"#f8f8f2",
		},
		brights = {
			"#6272a4",
			"#ff6e6e",
			"#69ff94",
			"#ffffa5",
			"#d6acff",
			"#ff92df",
			"#a4ffff",
			"#ffffff",
		},
	},

	window_frame = {
		active_titlebar_bg = "#282a36",
		inactive_titlebar_bg = "#282a36",
		font = wezterm.font({ family = "IosevkaTermNerdFont", weight = "Bold" }),
		font_size = 11.0,
	},

	bold_brightens_ansi_colors = true,
	enable_tab_bar = false,

	keys = {
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
