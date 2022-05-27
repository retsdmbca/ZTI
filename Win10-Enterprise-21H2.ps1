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

Write-Host -ForegroundColor Green "Starting OSDCloud Zero Touch Installation"
Start-Sleep -Seconds 5

#Start OSDCloud ZTI
Write-Host -ForegroundColor Green "Start OSDCloud"
Start-OSDCloud -OSBuild "21H2" -OSLanguage en-us -OSEdition Enterprise -ZTI -OSVersion "Windows 10" -Firmware
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
