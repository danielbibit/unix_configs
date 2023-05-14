; https://wiki.archlinux.org/title/Xbindkeys

; Ctrl + alt + c => Launch calculator
^!c::
{
    Run "C:\Program Files\Qalculate\qalc.exe"
    Return
}

; Ctrl + alt + t => Launch terminal
^!t::
{
    Run "C:\Program Files\WezTerm\wezterm-gui.exe"
    Return
}

; Ctrl + alt + o => Launch VSCode
^!o::
{
    Run "C:\Users\danie\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    Return
}

; Ctrl + alt + w => Launch obsidian
^!w::
{
    Run "C:\Users\danie\AppData\Local\Obsidian\Obsidian.exe"
    Return
}

; Ctrl + alt + f1 => Switch Audio Output

; Ctrl + alt + m => Toggle microphone
