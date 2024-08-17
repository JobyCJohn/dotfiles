local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local default_prog = nil
if string.find(wezterm.target_triple, "windows") then
	default_prog = { "pwsh.exe", "-NoLogo" }
end

return {
	audible_bell = "Disabled",
	color_scheme = "tokyonight_night",

    default_prog = default_prog,

	font_size = 10.0,

	initial_cols = 120,
	initial_rows = 30,

	scrollback_lines = 5000,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,

	use_dead_keys = false,
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	disable_default_key_bindings = true,

    animation_fps = 1,
    cursor_blink_ease_in = 'Constant',
    cursor_blink_ease_out = 'Constant',
    default_cursor_style = "BlinkingBar",
	-- force_reverse_video_cursor = true,

    window_close_confirmation = 'NeverPrompt',
	window_background_opacity = 0.95,
	window_padding = { left = 2, right = 2, top = 2, bottom = 2 },

	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "v", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

		{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },

		{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
		{
			key = "/",
			mods = "LEADER",
			action = act.Multiple({ act.CopyMode("ClearPattern"), act.Search({ CaseInSensitiveString = "" }) }),
		},
		{ key = "Escape", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "Enter", mods = "LEADER", action = act.ToggleFullScreen },

		{ key = "h", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Left", 2 } }) },
		{ key = "j", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Down", 2 } }) },
		{ key = "k", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Up", 2 } }) },
		{ key = "l", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Right", 2 } }) },
	},
}
