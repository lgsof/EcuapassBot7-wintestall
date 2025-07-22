Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName WindowsBase

# 1. Ensure we run in the script's own folder
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition)

# 2. Build the splash Window
$window = New-Object Windows.Window
$window.Title                    = "EcuapassBot"
$window.Width                    = 300
$window.Height                   = 100
$window.Topmost                  = $true
$window.WindowStartupLocation    = "CenterScreen"
$window.ResizeMode               = "NoResize"

# 3. Add a centered label
$label = New-Object Windows.Controls.Label
$label.Content             = "EcuapassBot is starting, please wait..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment   = "Center"
$window.Content            = $label

# 4. Kick off your batch right away (non‑blocking)
Start-Process -FilePath ".\EcuapassBot.bat"

# 5. Create a timer on the UI thread to close after 3 seconds
$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(3)
$timer.Add_Tick({
    # Stop the timer so it only fires once
    $timer.Stop()
    # Close the window
    $window.Close()
    # Shut down the dispatcher loop so the script can exit
    [System.Windows.Threading.Dispatcher]::CurrentDispatcher.InvokeShutdown()
})

# 6. Show the window and start processing events
$timer.Start()
$window.Show()
[System.Windows.Threading.Dispatcher]::Run()

