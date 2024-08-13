local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

return {
	audible_bell = "Disabled",
	check_for_updates = false,
	color_scheme = "tokyonight_night",
	disable_default_key_bindings = true,
	enable_tab_bar = false,
	exit_behavior = "CloseOnCleanExit",
	hide_tab_bar_if_only_one_tab = true,
	initial_cols = 120,
	initial_rows = 30,
	scrollback_lines = 5000,
	use_dead_keys = false,
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	leader = { key = "Space", mods = "CTRL" },
	keys = {
		{ key = "-", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	},
}
