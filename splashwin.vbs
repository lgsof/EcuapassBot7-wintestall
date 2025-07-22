Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' === Show splash dialog using a temp HTA ===
splashPath = fso.GetSpecialFolder(2) & "\ecuapass_splash.hta"

Set splashFile = fso.CreateTextFile(splashPath, True)
splashFile.WriteLine "<html><head><title>Starting...</title>"
splashFile.WriteLine "<hta:application windowstate='minimize' showintaskbar='yes'></hta:application>"
splashFile.WriteLine "</head><body style='font-family:sans-serif;text-align:center;padding-top:30px;'>"
splashFile.WriteLine "<h3>EcuapassBot is starting, please wait...</h3>"
splashFile.WriteLine "</body></html>"
splashFile.Close

' Start splash (non-blocking)
shell.Run "mshta.exe """ & splashPath & """", 1, False

' === Start the batch file (non-blocking) ===
Set proc = shell.Exec("cmd /c cd /d C:\path\to\EcuapassBot && EcuapassBot.bat")

' === Wait for it to finish (Java window may take time to show) ===
Do While proc.Status = 0
    WScript.Sleep 500
Loop

' === Clean up: Close splash window ===
' Kill mshta process (we assume only one running)
shell.Run "taskkill /f /im mshta.exe", 0, True

' Optional: delete splash file
fso.DeleteFile splashPath, True

