local wezterm = require 'wezterm'

local default_prog
local act = wezterm.action

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'powershell.exe', '-NoLogo' }
end

return {
    -- fix webGL crash on windows 11 ?
    --front_end = "WebGpu",
    --webgpu_power_preference = "HighPerformance",

    leader = {
        key = 'a',
        mods = 'CTRL',
        timeout_milliseconds = 1000,
    },

    default_prog = default_prog,
    audible_bell = "Disabled",
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font 'JetBrains Mono',
    font_size = 10.0,

    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 450,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",

    window_frame = {
        active_titlebar_bg = '#333333',

        inactive_titlebar_bg = '#333333',
    },

    inactive_pane_hsb = {
      saturation = 0.75,
      brightness = 0.55,
    },

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    window_background_opacity = 0.93,
    text_background_opacity = 0.85,

     color_scheme = "Mashup Colors (terminal.sexy)",
     --color_scheme = "Mariana",
     --color_scheme = "Macintosh (base16)",
     --color_scheme = "MaterialDark",
     --color_scheme = "MaterialDarker",
     --color_scheme = "MaterialOcean",

    keys = {
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

        { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 2 } },
        { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 2 } },
        { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 2 } },
        { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 2 } },


        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },


        { key = 'n', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'x', mods = 'LEADER', action = act.CloseCurrentTab { confirm = false }},
        { key = 'Tab', mods = 'SHIFT', action = act.ActivateTabRelative(1) },

        { key = 'y', mods = 'LEADER', action = act.ActivateCopyMode },

        { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    },
}
