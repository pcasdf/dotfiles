local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"
config.font_size = 13
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}
config.keys = {
	{
		key = "s",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{
		key = "r",
		mods = "CTRL|CMD",
		action = wezterm.action.RotatePanes("CounterClockwise"),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = ";",
		mods = "CMD|SHIFT",
		action = wezterm.action.PaneSelect,
	},
	{
		key = "'",
		mods = "CMD|SHIFT",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		key = ",",
		mods = "CMD|SHIFT",
		action = wezterm.action.PaneSelect({
			mode = "MoveToNewTab",
		}),
	},
	{
		key = ".",
		mods = "CMD|SHIFT",
		action = wezterm.action.PaneSelect({
			mode = "MoveToNewWindow",
		}),
	},
	{
		key = "u",
		mods = "CMD|SHIFT",
		action = wezterm.action.ScrollByPage(-1),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.ScrollByPage(1),
	},
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = wezterm.action.ScrollToPrompt(-1),
	},
	{
		key = "n",
		mods = "CMD|SHIFT",
		action = wezterm.action.ScrollToPrompt(1),
	},
}

return config
