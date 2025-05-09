-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - LEADER + s: Split the current pane horizontally into two panes.
--    - LEADER + v: Split the current pane vertically into two panes.

-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji (🌊).
--    - toggle the status line using LEADER + t

-- Miscellaneous Configurations:
-- - Tabs are not shown  if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.

-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	weight = "Regular",
	family = "Symbols Nerd Font Mono",
	scale = 1.2,
})
config.font_rules = {
	{
		intensity = "Normal",
		italic = false,
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			-- Disable certain features for icons
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
			scale = 1.0,
		}),
	},
}
config.font_size = 16
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- Add a variable to track tab bar visibility state
local tab_bar_hidden = false
config.cursor_blink_rate = 0
config.max_fps = 60
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
config.scrollback_lines = 3000
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- tmux
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "a",
		mods = "LEADER",
		action = wezterm.action.AttachDomain("unix"),
	},
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "[",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action_callback(function(window, pane)
			tab_bar_hidden = not tab_bar_hidden
			window:set_config_overrides({
				enable_tab_bar = not tab_bar_hidden,
			})
		end),
	},
}
for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end
-- Also add binding for tab 10 with key "0"
table.insert(config.keys, {
	key = "0",
	mods = "LEADER",
	action = wezterm.action.ActivateTab(9),
})
config.colors = {
	foreground = "#ebdbb2", -- text
	background = "#0a0a10", -- base
	cursor_bg = "#ebdbb2",
	cursor_fg = "#0a0a10",
	cursor_border = "#ebdbb2",
	selection_fg = "#0a0a10",
	selection_bg = "#a89984",
	scrollbar_thumb = "#928374",
	split = "#595959",
	ansi = {
		"#292929", -- black
		"#ea6962", -- red
		"#a9b665", -- green
		"#d8a657", -- yellow
		"#7daea3", -- blue
		"#d3869b", -- magenta
		"#89b482", -- cyan
		"#ebdbb2", -- white
	},
	brights = {
		"#595959", -- bright black
		"#ea6962", -- bright red
		"#a9b665", -- bright green
		"#d8a657", -- bright yellow
		"#7daea3", -- bright blue
		"#d3869b", -- bright magenta
		"#89b482", -- bright cyan
		"#ebdbb2", -- bright white
	},
	tab_bar = {
		background = "#0a0a10",
		active_tab = {
			bg_color = "#7daea3",
			fg_color = "#0a0a10",
		},
		inactive_tab = {
			bg_color = "#292929",
			fg_color = "#a89984",
		},
	},
}
-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.show_new_tab_button_in_tab_bar = false
-- Function to get just the process name from a pane
function get_process_name(tab_info)
	local title = tab_info.active_pane.foreground_process_name or ""
	-- Extract just the process name without path
	return title:gsub(".*[/\\]", "")
end

-- Set up the tab formatting with numbers
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local process = get_process_name(tab)
	-- Tab numbers in WezTerm are 0-based, so we add 1 to match your existing config
	local tab_number = tab.tab_index + 1

	-- Use your existing color scheme for consistency
	if tab.is_active then
		return {
			{ Background = { Color = "#7daea3" } },
			{ Foreground = { Color = "#0a0a10" } },
			{ Text = " " .. tab_number .. ":" .. process .. " " },
		}
	else
		return {
			{ Background = { Color = "#292929" } },
			{ Foreground = { Color = "#a89984" } },
			{ Text = " " .. tab_number .. ":" .. process .. " " },
		}
	end
end)

-- Initialize the tab bar based on our variable
config.enable_tab_bar = not tab_bar_hidden
config.enable_kitty_graphics = true

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#7daea3" } }
	local prefix = ""
	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end
	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#7daea3" } }
	end -- arrow color based on if tab is first pane
	window:set_left_status(wezterm.format({
		{ Background = { Color = "#7daea3" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)
-- configure mux
config.unix_domains = {
	{
		name = "unix",
	},
}

-- and finally, return the configuration to wezterm
return config
