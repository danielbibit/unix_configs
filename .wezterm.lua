local wezterm = require 'wezterm'

local default_prog
local act = wezterm.action

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_windows <const> = wezterm.target_triple:find("x86_64-pc-windows-msvc") ~= nil
local is_linux <const> = wezterm.target_triple:find("x86_64-unknown-linux-gnu") ~= nil

config.window_close_confirmation = 'NeverPrompt'

config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 9.5

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 450
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.window_frame = {
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

config.inactive_pane_hsb = {
  saturation = 0.75,
  brightness = 0.55,
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_background_opacity = 0.95
config.text_background_opacity = 0.90

-- config.color_scheme = "Mashup Colors (terminal.sexy)"
-- config.color_scheme = "Mariana"
-- config.color_scheme = "Macintosh (base16)"
config.color_scheme = "MaterialDark"
-- config.color_scheme = "MaterialDarker"
-- config.color_scheme = "MaterialOcean"

if is_windows then
    config.default_prog = { 'powershell.exe', '-NoLogo' }

    -- fix webGL crash on windows 11 ?
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"
end

if is_darwin then
    -- temp fix for hidpi difference on macos and 1440p display
	config.font_size = 12
end

--config.leader = {
  --key = 'a',
  --mods = 'CTRL',
  --timeout_milliseconds = 3000,
--}

config.keys = {
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'LEADER|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 4 } },
  { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 4 } },
  { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 6 } },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 6 } },

  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  { key = 'n', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'c', mods = 'LEADER', action = act.CloseCurrentTab { confirm = false } },

  { key = 'y', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Disable Ctrl+Tab / Ctrl+Shift+Tab
  { key = 'Tab', mods = 'CTRL', action = act.DisableDefaultAssignment },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },

  -- Leader + 1–9 to switch tabs
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },
}

return config
