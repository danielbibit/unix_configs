local wezterm = require 'wezterm'

local default_prog

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'powershell.exe', '-NoLogo' }
end

return {
    default_prog = default_prog,
    audible_bell = "Disabled",
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font 'JetBrains Mono',
    font_size = 10.0,

    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 450,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    -- color_scheme = "Mashup Colors (terminal.sexy)",
    -- color_scheme = "Mariana",
    -- color_scheme = "Macintosh (base16)",
    -- color_scheme = "Materia (base16)",
    color_scheme = "MaterialDark",
    -- color_scheme = "MaterialDarker",
    -- color_scheme = "MaterialOcean",
}
