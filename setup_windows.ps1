# Requires elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Script is not running as Administrator. Attempting to relaunch with elevated privileges..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

winget install --exact --id alexpasmantier.
winget install -e --id=JesseDuffield.lazygit

New-Item -Path 'C:\Users\danie\.wezterm.lua' -ItemType SymbolicLink -Value C:\Daniel\Code\unix_configs\.wezterm.lua -Force
# New-Item -Path 'C:\Users\danie\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup' -ItemType SymbolicLink -Value C:\Daniel\Code\unix_configs\shortcuts\win.ahk -Force
