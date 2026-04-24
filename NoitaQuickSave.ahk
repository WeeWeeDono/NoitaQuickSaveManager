#SingleInstance force
#IfWinActive, ahk_exe noita.exe

F5::
    WinGet, exePath, ProcessPath, ahk_exe noita.exe
    exeDir := RegExReplace(exePath, "\\[^\\]+$")
    Send, !{F4}
    Process, WaitClose, noita.exe
    
    EnvGet, localLow, AppData
    localLow := StrReplace(localLow, "Roaming", "LocalLow")
    sourceDir := localLow . "\Nolla_Games_Noita\save00"
    
    FormatTime, timestamp,, yyyy-MM-dd_HH-mm-ss
    historyDir := localLow . "\Nolla_Games_Noita\my_history_saves\save_" . timestamp
    
    FileCreateDir, %historyDir%
    FileCopyDir, %sourceDir%, %historyDir%, 1
    
    Run, %exePath%, %exeDir%
Return

F9::
    EnvGet, localLow, AppData
    localLow := StrReplace(localLow, "Roaming", "LocalLow")
    historyRoot := localLow . "\Nolla_Games_Noita\my_history_saves"
    
    saveList := ""
    FileList := ""
    Loop, Files, %historyRoot%\*, D
        FileList .= A_LoopFileTimeModified . "`t" . A_LoopFileName . "`n"
    
    Sort, FileList, R 
    
    Loop, Parse, FileList, `n
    {
        if (A_LoopField = "")
            continue
        StringSplit, Parts, A_LoopField, %A_Tab%
        saveList .= Parts2 . "|"
    }
    
    if (saveList = "") {
        MsgBox, Сейвов не найдено.
        Return
    }

    Gui, Destroy
    Gui, +AlwaysOnTop
    Gui, Font, s10, Segoe UI
    Gui, Add, Text,, Выбери сейв (двойной клик для загрузки):
    Gui, Add, ListBox, vSelectedSave r15 w350 gGuiLoad, %saveList%
    Gui, Add, Button, gLoadSave Default, Загрузить
    Gui, Show,, Noita Save Manager
Return

GuiLoad:
    if (A_GuiEvent = "DoubleClick")
        gosub, LoadSave
Return

LoadSave:
    Gui, Submit
    if (SelectedSave = "")
        Return

    WinGet, exePath, ProcessPath, ahk_exe noita.exe
    exeDir := RegExReplace(exePath, "\\[^\\]+$")
    
    EnvGet, localLow, AppData
    localLow := StrReplace(localLow, "Roaming", "LocalLow")
    sourcePath := localLow . "\Nolla_Games_Noita\my_history_saves\" . SelectedSave
    targetDir := localLow . "\Nolla_Games_Noita\save00"

    Process, Close, noita.exe
    Process, WaitClose, noita.exe
    
    FileRemoveDir, %targetDir%, 1
    FileCopyDir, %sourcePath%, %targetDir%, 1
    
    Run, %exePath%, %exeDir%
Return
