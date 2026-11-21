$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Windows.Forms
$folder = Join-Path $env:LOCALAPPDATA 'JohnDeck'
$config = Join-Path $folder 'launcher-apps.json'
$apps = @(Get-StartApps | Sort-Object Name, AppID -Unique)
$selected = @()
if (Test-Path -LiteralPath $config) {
    $selected = @((Get-Content -Raw -LiteralPath $config | ConvertFrom-Json).apps)
}
$form = New-Object Windows.Forms.Form
$form.Text = 'John Deck - Choose up to six applications'
$form.ClientSize = New-Object Drawing.Size(480,510)
$list = New-Object Windows.Forms.CheckedListBox
$list.Dock = 'Fill'
$list.CheckOnClick = $true
$list.DisplayMember = 'Name'
foreach ($app in $apps) {
    [void]$list.Items.Add($app, ($app.AppID -in $selected))
}
$list.Add_ItemCheck({
    param($sender,$eventArgs)
    if ($eventArgs.NewValue -eq 'Checked' -and $list.CheckedItems.Count -ge 6) {
        $eventArgs.NewValue = $eventArgs.CurrentValue
        [void][Windows.Forms.MessageBox]::Show('Remove one application before adding another.')
    }
})
$save = New-Object Windows.Forms.Button
$save.Text = 'Save applications'
$save.Dock = 'Bottom'
$save.Height = 40
$save.Add_Click({
    $ids = @($list.CheckedItems | ForEach-Object { $_.AppID })
    if ($ids.Count -gt 6) { return }
    [void][IO.Directory]::CreateDirectory($folder)
    $temp = Join-Path $folder ([IO.Path]::GetRandomFileName())
    try {
        [IO.File]::WriteAllText($temp, (@{apps=$ids} | ConvertTo-Json))
        if ([IO.File]::Exists($config)) { [IO.File]::Replace($temp,$config,$null) }
        else { [IO.File]::Move($temp,$config) }
        $form.Close()
    } catch { [void][Windows.Forms.MessageBox]::Show($_.Exception.Message) }
    finally { if ([IO.File]::Exists($temp)) { [IO.File]::Delete($temp) } }
})
$form.Controls.Add($list)
$form.Controls.Add($save)
[void]$form.ShowDialog()
$form.Dispose()
