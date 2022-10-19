Install-Module -Name OSD -Force
Import-Module -name OSD -Force

$Generalworkspace = "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace"
$Staffsharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Shared"
$Staffassignedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Assigned"
$FrenchStaffSharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-French-Staff-Shared"


#Run this to generate the Template files - located in C:\Programdata\osdcloud
New-OSDCloudTemplate -WinRE

## MAKE SURE YOU COPY THE WALLPAPER, STAFF ASSIGNED AND STAFF_SHARED JSON FILES TO C:\Programdata\osdcloud\config\AutopilotJSON

# Generates workspace that you would alter/add files.  Pulls files from the template folder C:\Programdata\osdcloud.
New-OSDCloudworkspace -WorkspacePath $Generalworkspace
New-OSDCloudworkspace -WorkspacePath $Staffassignedworkspace
New-OSDCloudworkspace -WorkspacePath $Staffsharedworkspace
New-OSDCloudworkspace -WorkspacePath $FrenchStaffSharedworkspace

# Removes the unneeded config file
Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force

# CloueWinPE - Lenovo not an option yet.  Adds WINPE/RE Drivers

Edit-OSDCloudwinpe -workspacepath $Generalworkspace -CloudDriver Dell, HP -wallpaper "$Generalworkspace\Wallpaper\guiwallpaper.jpg" -Verbose -StartOSDCloudGUI

# Adds the webscript held in github and applies a wallpaper, and Drivers
Edit-OSDCloudwinpe -workspacepath $Staffassignedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/Win10-Enterprise-21H2.ps1 -wallpaper "$Staffassignedworkspace\Wallpaper\Staff-Assigned.jpg" -Verbose
Edit-OSDCloudwinpe -WorkspacePath $Staffsharedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/Win10-Enterprise-21H2.ps1 -wallpaper "$Staffsharedworkspace\Wallpaper\Staff-Shared.jpg" -Verbose
Edit-OSDCloudwinpe -WorkspacePath $FrenchStaffSharedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/Win10-Enterprise-21H2.ps1 -wallpaper "$Staffsharedworkspace\Wallpaper\Staff-Shared.jpg" -Verbose

#create new ISO
New-OSDCloudiso -WorkspacePath $Generalworkspace
New-OSDCloudiso -WorkspacePath $Staffsharedworkspace
New-OSDCloudiso -WorkspacePath $Staffassignedworkspace
New-OSDCloudiso -WorkspacePath $FrenchStaffSharedworkspace

###Create USB Cloud - This will directly create OSDcloud USB drive.
new-osdcloudusb -WorkspacePath $Generalworkspace
new-osdcloudusb -WorkspacePath $Staffsharedworkspace
new-osdcloudusb -WorkspacePath $Staffassignedworkspace
new-osdcloudusb -WorkspacePath $FrenchStaffSharedworkspace

new-osdcloudusb -fromIsoFile "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud.iso"

<# THIS BLOCK OF TEXT IS USED TO EXPORT CONFIG FILES FROM AUTOPILOT
Install-Module azuread -Force
install-module WindowsAutopilotIntune -Force
install-module Microsoft.Graph.Intune -Force

connect-msgraph
$autopilotprofiles = Get-AutopilotProfile
foreach ($autopilotprofile in $autopilotprofiles) {
    $temppath = "D:\profiles\"
    $name = $autopilotprofile.displayname
    $exportpath = $temppath + $name + "_autopilotconfigurationfile.json"
    $autopilotprofile | convertto-autopilotconfigurationJSON | out-file $exportpath -Encoding ASCII
    
}
#>