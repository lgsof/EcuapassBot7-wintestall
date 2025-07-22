Set shell = CreateObject("WScript.Shell")
'shell.CurrentDirectory = "C:\Users\LuisG\AppData\Local\Programs\EcuapassBot7-wintest"

splashScript = """C:\Users\LuisG\AppData\Local\Programs\EcuapassBot7-wintest\splash.ps1"""
cmd = "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File " & splashScript
shell.Run cmd, 0, False

