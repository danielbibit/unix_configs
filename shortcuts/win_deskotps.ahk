; Globals
DesktopCount := 4       ; Windows starts with 4 desktops at boot
CurrentDesktop := 1     ; Desktop count is 1-indexed

;
; This function examines the registry to build an accurate list of the
; current virtual desktops and which one we're currently on.
;
mapDesktopsFromRegistry() {
    global CurrentDesktop, DesktopCount

    IdLength := 32
    CurrentDesktopId := ""
    SessionId := getSessionId()

    if (SessionId) {
        try {
            CurrentDesktopId := RegRead(
                "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\" SessionId "\VirtualDesktops",
                "CurrentVirtualDesktop"
            )
            if (CurrentDesktopId)
                IdLength := StrLen(CurrentDesktopId)
        }
    }

    try {
        DesktopList := RegRead(
            "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops",
            "VirtualDesktopIDs"
        )
    } catch {
        DesktopList := ""
    }

    if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        DesktopCount := DesktopListLength // IdLength
    } else {
        DesktopCount := 1
    }

    i := 0
    while (CurrentDesktopId && i < DesktopCount + 1) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug("Iterator: " DesktopIter " Index: " i)

        if (DesktopIter = CurrentDesktopId) {
            CurrentDesktop := i + 1
            OutputDebug("Current desktop: " CurrentDesktop " ID: " DesktopIter)
            break
        }
        i++
    }
}

;
; Finds the ID of the current session
;
getSessionId() {
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    OutputDebug("Current Process Id: " ProcessId)

    SessionId := 0
    if !DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", &SessionId) {
        OutputDebug("Error getting session id")
        return
    }

    OutputDebug("Current Session Id: " SessionId)
    return SessionId
}

;
; Switches to the specified desktop number
;
switchDesktopByNumber(targetDesktop) {
    OutputDebug("[desktop-switch][switch] target: " targetDesktop)
    global CurrentDesktop, DesktopCount

    ; Refresh desktop state
    mapDesktopsFromRegistry()

    ; Create missing desktops if needed
    while (DesktopCount < targetDesktop) {
        Sleep 150             ; small delay to let Windows catch up
        Send("#^d")          ; Win + Ctrl + D
        DesktopCount++
        CurrentDesktop := DesktopCount
        OutputDebug("[desktop-switch][auto-create] desktops: " DesktopCount)
    }

    ; Move right
    while (CurrentDesktop < targetDesktop) {
        Sleep 250
        Send("^#{Right}")
        CurrentDesktop++
        OutputDebug("[right] target: " targetDesktop " current: " CurrentDesktop)
    }

    ; Move left
    while (CurrentDesktop > targetDesktop) {
        Sleep 250
        Send("^#{Left}")
        CurrentDesktop--
        OutputDebug("[desktop-switch][left] target: " targetDesktop " current: " CurrentDesktop)
    }
}

;
; Creates a new virtual desktop
;
createVirtualDesktop() {
    global CurrentDesktop, DesktopCount
    Send("#^d")
    DesktopCount++
    CurrentDesktop := DesktopCount
    OutputDebug("[create] desktops: " DesktopCount " current: " CurrentDesktop)
}

;
; Deletes the current virtual desktop
;
deleteVirtualDesktop() {
    global CurrentDesktop, DesktopCount
    Send("#^{F4}")
    DesktopCount--
    CurrentDesktop--
    OutputDebug("[desktop-switch][delete] desktops: " DesktopCount " current: " CurrentDesktop)
}

; Main
SetKeyDelay 75
mapDesktopsFromRegistry()
OutputDebug("[desktop-switch][loading] desktops: " DesktopCount " current: " CurrentDesktop)

; Hotkeys
^!1::switchDesktopByNumber(1)
^!2::switchDesktopByNumber(2)
^!3::switchDesktopByNumber(3)
^!4::switchDesktopByNumber(4)
