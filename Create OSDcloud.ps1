Install-Module -Name OSD -Force
Import-Module -name OSD -Force

#Run this to generate the Template files - located in C:\Programdata\osdcloud
New-OSDCloudTemplate -WinRE

## MAKE SURE YOU COPY THE WALLPAPER, STAFF ASSIGNED AND STAFF_SHARED JSON FILES TO C:\Programdata\osdcloud\config\AutopilotJSON
# Generates workspace that you would alter/add files.  Pulls files from the template folder C:\Programdata\osdcloud.

### Student Shared ###
Function StudentShared {
    param([String]$OSVer,[String]$Configfile)
    $StudentSharedWorkspace = "D:\OSDCloud Workspaces\OSDCloud-Student-Shared - $OSver"
    New-OSDCloudworkspace -WorkspacePath $StudentSharedWorkspace
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $StudentSharedWorkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$StudentSharedWorkspace\Wallpaper\Student-Shared.jpg" -Verbose
    New-OSDCloudiso -WorkspacePath $StudentSharedWorkspace
    $isoname = "OSDCloud - Student-Shared - $OSVer.iso"
    rename-item -Path "$StudentSharedWorkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$StudentSharedWorkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### Staff Shared ###
Function StaffShared {
    param([String]$OSVer,[String]$Configfile)
    $Staffsharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-Staff-Shared - $OSver"
    New-OSDCloudworkspace -WorkspacePath $Staffsharedworkspace
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $Staffsharedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$Staffsharedworkspace\Wallpaper\Staff-Shared.jpg" -Verbose
    New-OSDCloudiso -WorkspacePath $Staffsharedworkspace
    $isoname = "OSDCloud - Staff-Shared - $OSVer.iso"
    rename-item -Path "$Staffsharedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$Staffsharedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### Staff Assigned ###
Function StaffAssigned {
    param([String]$OSVer,[String]$Configfile)
    $Staffassignedworkspace = "D:\OSDCloud Workspaces\OSDCloud-Staff-Assigned - $OSver"
    New-OSDCloudworkspace -WorkspacePath $Staffassignedworkspace
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -workspacepath $Staffassignedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$Staffassignedworkspace\Wallpaper\Staff-Assigned.jpg" -Verbose
    New-OSDCloudiso -WorkspacePath $Staffassignedworkspace
    $isoname = "OSDCloud - Staff-Assigned - $OSVer.iso"
    rename-item -Path "$Staffassignedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$Staffassignedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### French Staff Shared ###
Function FrenchStaffShared {
    param([String]$OSVer,[String]$Configfile)
    $FrenchStaffSharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-French-Staff-Shared - $OSver"
    New-OSDCloudworkspace -WorkspacePath $FrenchStaffSharedworkspace
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $FrenchStaffSharedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$FrenchStaffSharedworkspace\Wallpaper\French-Staff-Shared.jpg" -Verbose
    New-OSDCloudiso -WorkspacePath $FrenchStaffSharedworkspace
    $isoname = "OSDCloud - French-Staff-Shared - $OSVer.iso"
    rename-item -Path "$FrenchStaffSharedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$FrenchStaffSharedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### General ###
Function General {
    $Generalworkspace = "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace"
    New-OSDCloudworkspace -WorkspacePath $Generalworkspace
    Edit-OSDCloudwinpe -workspacepath $Generalworkspace -CloudDriver Dell, HP, WiFi -wallpaper "$Generalworkspace\Wallpaper\guiwallpaper.jpg" -Verbose -StartOSDCloudGUI
    New-OSDCloudiso -WorkspacePath $Generalworkspace
    rename-item -Path "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud.iso" -NewName "OSDCloud - General.iso"
    copy-item -Path "D:\OSDCloud Workspaces\OSDCloud-Generalworkspace\OSDCloud - General.iso" -Destination 'D:\OSDCloud Workspaces'
}

StudentShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StudentShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

StaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

StaffAssigned -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StaffAssigned -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

FrenchStaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
FrenchStaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

General #good

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



