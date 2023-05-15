Install-Module -Name OSD -Force
Import-Module -name OSD -Force

$Generalworkspace = "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace"
$Staffsharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Shared"
$Staffassignedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Assigned"
$FrenchStaffSharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-French-Staff-Shared"
$StudentSharedWorkspace = "D:\OSDCloud Workspaces\OSDCloud-WinRE-Student-Shared"

#Run this to generate the Template files - located in C:\Programdata\osdcloud
New-OSDCloudTemplate -WinRE

## MAKE SURE YOU COPY THE WALLPAPER, STAFF ASSIGNED AND STAFF_SHARED JSON FILES TO C:\Programdata\osdcloud\config\AutopilotJSON
# Generates workspace that you would alter/add files.  Pulls files from the template folder C:\Programdata\osdcloud.

### Student Shared ###
New-OSDCloudworkspace -WorkspacePath $StudentSharedWorkspace
Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
Edit-OSDCloudwinpe -WorkspacePath $StudentSharedWorkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1 -wallpaper "$StudentSharedWorkspace\Wallpaper\Student-Shared.jpg" -Verbose
New-OSDCloudiso -WorkspacePath $StudentSharedWorkspace
rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Student-Shared\OSDCloud.iso" -NewName "OSDCloud - Student-Shared.iso"
copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Student-Shared\OSDCloud - Student-Shared.iso" -Destination 'D:\OSDCloud Workspaces'


### Staff Shared ###
New-OSDCloudworkspace -WorkspacePath $Staffsharedworkspace
Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
Edit-OSDCloudwinpe -WorkspacePath $Staffsharedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1 -wallpaper "$Staffsharedworkspace\Wallpaper\Staff-Shared.jpg" -Verbose
New-OSDCloudiso -WorkspacePath $Staffsharedworkspace
rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Shared\OSDCloud.iso" -NewName "OSDCloud - Staff-Shared.iso"
copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Shared\OSDCloud - Staff-Shared.iso" -Destination 'D:\OSDCloud Workspaces'


### Staff Assigned ###
New-OSDCloudworkspace -WorkspacePath $Staffassignedworkspace
Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
Edit-OSDCloudwinpe -workspacepath $Staffassignedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1 -wallpaper "$Staffassignedworkspace\Wallpaper\Staff-Assigned.jpg" -Verbose
New-OSDCloudiso -WorkspacePath $Staffassignedworkspace
rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Assigned\OSDCloud.iso" -NewName "OSDCloud - Staff-Assigned.iso"
copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-Staff-Assigned\OSDCloud - Staff-Assigned.iso" -Destination 'D:\OSDCloud Workspaces'


### French Staff Shared ###
New-OSDCloudworkspace -WorkspacePath $FrenchStaffSharedworkspace
Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
Edit-OSDCloudwinpe -WorkspacePath $FrenchStaffSharedworkspace -CloudDriver Dell, HP, Wifi -StartURL https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1 -wallpaper "$FrenchStaffSharedworkspace\Wallpaper\French-Staff-Shared.jpg" -Verbose
New-OSDCloudiso -WorkspacePath $FrenchStaffSharedworkspace
rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-French-Staff-Shared\OSDCloud.iso" -NewName "OSDCloud - French Staff-Shared.iso"
copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-WinRE-French-Staff-Shared\OSDCloud - French Staff-Shared.iso" -Destination 'D:\OSDCloud Workspaces'


### General ###
New-OSDCloudworkspace -WorkspacePath $Generalworkspace
Edit-OSDCloudwinpe -workspacepath $Generalworkspace -CloudDriver Dell, HP -wallpaper "$Generalworkspace\Wallpaper\guiwallpaper.jpg" -Verbose -StartOSDCloudGUI
New-OSDCloudiso -WorkspacePath $Generalworkspace
rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud.iso" -NewName "OSDCloud - General.iso"
copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud - General.iso" -Destination 'D:\OSDCloud Workspaces'

#Update-OSDCloudUSB -DriverPack Lenovo
#Update-OSDCloudUSB -osname 'Windows 11 22H2' -OSActivation Retail
###Create USB Cloud - This will directly create OSDcloud USB drive.
<#
new-osdcloudusb -WorkspacePath $Generalworkspace
new-osdcloudusb -WorkspacePath $Staffsharedworkspace
new-osdcloudusb -WorkspacePath $Staffassignedworkspace
new-osdcloudusb -WorkspacePath $FrenchStaffSharedworkspace

new-osdcloudusb -fromIsoFile "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud.iso"
#>



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