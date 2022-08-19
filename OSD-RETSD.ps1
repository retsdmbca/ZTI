#New-PSDrive -Name "X" -PSProvider "FileSystem" -Root "\\ao-sccm\Source"

Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='OSD RETSD'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true


$Label = New-Object System.Windows.Forms.Label
$Label.Text = "AP Profile"
$Label.Location  = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 300
$autopilotfiles = get-childitem -path 'X:\OSDCloud\Config\AutopilotJSON'
Foreach ($file in $autopilotfiles) {$ComboBox.Items.Add($file.name);}
$ComboBox.Location  = New-Object System.Drawing.Point(60,10)
$main_form.Controls.Add($ComboBox)

$main_form.ShowDialog()









<#


#Replaces faulty Function
Remove-Item -path Function:\Test-MicrosoftUpdateCatalog
function Test-MicrosoftUpdateCatalog {
    [CmdletBinding()]
    param ()

    $StatusCode = (Invoke-WebRequest -uri 'https://www.catalog.update.microsoft.com' -UseBasicParsing -Method Head -ErrorAction Ignore).StatusCode 

    if ($StatusCode -eq 200) {
        Return $true
    } else {
        Return $false
    }
}

Write-Host -ForegroundColor Green "Testing GUI changes"
Start-Sleep -Seconds 5

#Start OSDCloud ZTI
Write-Host -ForegroundColor Green "Start OSDCloud"
Start-OSDCloud -OSBuild "21H2" -OSLanguage en-us -OSEdition Pro -OSLicense Retail -OSVersion "Windows 10" -Firmware -SkipODT
Write-Host " "
Write-Host -ForegroundColor Red "                          ########################################################"
Write-Host -ForegroundColor Blue "                          ########################################################"
Write-Host -ForegroundColor Green "                          *****  REMOVE USB KEY... PRESS ANY KEY TO CONTINUE *****"
Write-Host -ForegroundColor Blue "                          ########################################################"
Write-Host -ForegroundColor Red "                          ########################################################"
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

#Restart from WinPE
Write-Host -ForegroundColor Green "Restarting in 10 seconds!"
Start-Sleep -Seconds 10
wpeutil reboot
#>