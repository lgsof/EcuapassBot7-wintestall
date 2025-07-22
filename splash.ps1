
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
$label.Content = "Iniciando EcuapassBot, espere un momento..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment = "Center"
$window.Content = $label

# Launch app without waiting
Start-Process -FilePath ".\EcuapassBot.bat"

# Setup timer to close splash after 3 seconds
$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(3)
$timer.Add_Tick({
    $timer.Stop()
    $window.Close()
})

# Show the splash
$timer.Start()
$window.Show()

# Run the dispatcher loop to keep the window responsive
[System.Windows.Threading.Dispatcher]::Run()
