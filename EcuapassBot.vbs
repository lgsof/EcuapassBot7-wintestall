' Create splash window
Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Show splash message
Set objWshShell = CreateObject("WScript.Shell")
objWshShell.Popup "Iniciando EcuapassBot, espere un momento...", 2, "EcuapassBot", 64

objWshShell.Run "cmd /c cd /d ""C:\Users\LuisG\AppData\Local\Programs\EcuapassBot7-wintest\""&EcuapassBot.bat", 0, True

