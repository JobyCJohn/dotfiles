local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

return {

	audible_bell = "Disabled",
	check_for_updates = false,
	color_scheme = "tokyonight_night",
	cursor_blink_rate = 0,
	default_cursor_style = "SteadyBlock",
	disable_default_key_bindings = true,
	enable_tab_bar = false,
	exit_behavior = "CloseOnCleanExit",
	font_size = 10.0,
	force_reverse_video_cursor = true,
	hide_tab_bar_if_only_one_tab = true,
	initial_cols = 90,
	initial_rows = 24,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	scrollback_lines = 5000,
	use_dead_keys = false,
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	keys = {
		-- tab navigation
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
		{ key = "Enter", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
		-- splitting
		{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- pane navigation
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		-- zoom in/out
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	},
}
