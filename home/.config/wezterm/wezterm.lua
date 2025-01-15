local wezterm = require("wezterm")

local config = {}

config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.bold_brightens_ansi_colors = true
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 5000

config.font = wezterm.font("Iosevka Medium")
config.font_size = 12.5
config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Normal"
config.front_end = "OpenGL"
config.line_height = 1.06
config.window_padding = {
	left = 3,
	right = 3,
	top = 5,
	bottom = 5,
}

config.colors = {
	foreground = "#D0CFCC",
	background = "#171717",
	cursor_bg = "#D0CFCC",
	selection_fg = "#D0CFCC",
	selection_bg = "#44475a",

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
	tab_bar = {
		active_tab = {
			bg_color = "#2f313f",
			fg_color = "#f8f8f2",
			intensity = "Bold",
			italic = true,
		},
		inactive_tab = {
			bg_color = "#1e1f28",
			fg_color = "#D0CFCC",
			intensity = "Normal",
		},
	},
}

config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},

	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Navigate panes
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
}

-- Convenient Tab switching
for i = 1, 4 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
