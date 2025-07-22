Set-Location "C:\Users\LuisG\AppData\Local\Programs\EcuapassBot7-wintest"

Add-Type -AssemblyName PresentationFramework

# Create the window
$window = New-Object Windows.Window
$window.Title = "EcuapassBot"
$window.Width = 300
$window.Height = 100
$window.Topmost = $true
$window.WindowStartupLocation = "CenterScreen"
$window.ResizeMode = "NoResize"

# Add label
$label = New-Object Windows.Controls.Label
$label.Content = "EcuapassBot is starting, please wait..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment = "Center"
$window.Content = $label

# Start background job to launch your app and close splash after it exits
Start-Job {
    Start-Sleep -Milliseconds 500
    Start-Process -FilePath "C:\Users\LuisG\AppData\Local\Programs\EcuapassBot7-wintest\EcuapassBot.bat" -Wait
    [System.Windows.Application]::Current.Dispatcher.Invoke({ $window.Close() })
} | Out-Null

# Show the window and keep it alive
$null = $window.ShowDialog()

