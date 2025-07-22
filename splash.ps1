Add-Type -AssemblyName PresentationFramework

$splash = New-Object Windows.Window
$splash.Title = "EcuapassBot"
$splash.Width = 300
$splash.Height = 100
$splash.Topmost = $true
$splash.WindowStartupLocation = "CenterScreen"
$splash.ResizeMode = "NoResize"

$label = New-Object Windows.Controls.Label
$label.Content = "EcuapassBot is starting, please wait..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment = "Center"
$splash.Content = $label

Start-Job {
    Start-Sleep -Seconds 1
    Start-Process -FilePath "EcuapassBot.bat" -Wait
    [System.Windows.Application]::Current.Dispatcher.Invoke({ $splash.Close() })
} | Out-Null

[System.Windows.Threading.Dispatcher]::Run()

