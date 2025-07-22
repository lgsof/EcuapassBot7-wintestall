
Add-Type -AssemblyName PresentationFramework

# Set working directory
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition)

# Create the window
$window = New-Object Windows.Window
$window.Title = "EcuapassBot"
$window.Width = 300
$window.Height = 100
$window.Topmost = $true
$window.WindowStartupLocation = "CenterScreen"
$window.ResizeMode = "NoResize"

# Add message
$label = New-Object Windows.Controls.Label
$label.Content = "Iniciando EcuapassBot..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment = "Center"
$window.Content = $label

# Start background job to launch your app and close splash after it exits
Start-Job {
    Start-Sleep -Seconds 5
    Start-Process -FilePath ".\EcuapassBot.bat" -Wait
    [System.Windows.Application]::Current.Dispatcher.Invoke({ $window.Close() })
} | Out-Null

# Show the window and keep it alive
$null = $window.ShowDialog()

