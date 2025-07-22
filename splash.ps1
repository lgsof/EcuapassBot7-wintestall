Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 1. Jump into the script’s own folder
Set-Location (Split-Path $MyInvocation.MyCommand.Definition)

# 2. Build a simple Form
$form = New-Object System.Windows.Forms.Form
$form.Text              = "EcuapassBot"
$form.FormBorderStyle   = 'FixedDialog'
$form.StartPosition     = 'CenterScreen'
$form.Width             = 300
$form.Height            = 100
$form.TopMost           = $true

# 3. Add a Label
$label = New-Object System.Windows.Forms.Label
$label.Text      = "EcuapassBot is starting, please wait..."
$label.AutoSize  = $true
$label.Font      = New-Object System.Drawing.Font('Segoe UI',10)
$label.Location  = New-Object System.Drawing.Point( ( $form.ClientSize.Width - $label.PreferredWidth )/2,  ( $form.ClientSize.Height - $label.PreferredHeight )/2 )
$form.Controls.Add($label)

# 4. Launch your batch immediately (non‑blocking)
Start-Process -FilePath ".\EcuapassBot.bat"

# 5. Set up a WinForms Timer to close after 3 seconds
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 3000
$timer.Add_Tick({
    $timer.Stop()
    $form.Close()
})
$timer.Start()

# 6. Run the form (this blocks until .Close())
[void][System.Windows.Forms.Application]::Run($form)

