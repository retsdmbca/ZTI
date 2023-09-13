Install-Module -Name OSD -Force
Import-Module -name OSD -Force

#Run this to generate the Template files - located in C:\Programdata\osdcloud
New-OSDCloudTemplate -WinRE

## MAKE SURE YOU COPY THE WALLPAPER, STAFF ASSIGNED AND STAFF_SHARED JSON FILES TO C:\Programdata\osdcloud\config\AutopilotJSON
# Generates workspace that you would alter/add files.  Pulls files from the template folder C:\Programdata\osdcloud.

### Copy wim file ###
Function CopyWim {
    $Destination = "$(Get-OSDCloudWorkspace)\Media\OSDCloud\OS"
    $driversroot = "$(Get-OSDCloudWorkspace)\Media\OSDCloud\DriverPacks"
    New-Item -Path $Destination -ItemType Directory -Force
    New-Item -Path $driversroot -ItemType Directory -Force
    New-Item -Path $driversroot\Dell -ItemType Directory -Force
    New-Item -Path $driversroot\HP -ItemType Directory -Force
    New-Item -Path $driversroot\Lenovo -ItemType Directory -Force
    Copy-Item -Path "D:\Project Files\$WindowsImage" -Destination "$Destination\$windowsimage" -Force
   }
### Student Shared ###
Function StudentShared {
    param([String]$OSVer,[String]$Configfile,[String]$WindowsImage)
    $StudentSharedWorkspace = "D:\OSDCloud Workspaces\OSDCloud-Student-Shared - $OSver"
    Set-OSDCloudTemplate -Name 'OSDCloud-Student-Shared - $OSver'
    New-OSDCloudworkspace -WorkspacePath $StudentSharedWorkspace
    #Cleanup Languages
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force

    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$StudentSharedWorkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $StudentSharedWorkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$StudentSharedWorkspace\Wallpaper\Student-Shared.jpg" -Verbose
    CopyWim
    New-OSDCloudiso -WorkspacePath $StudentSharedWorkspace
    $isoname = "OSDCloud - Student-Shared - $OSVer.iso"
    rename-item -Path "$StudentSharedWorkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$StudentSharedWorkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### Staff Shared ###
Function StaffShared {
    param([String]$OSVer,[String]$Configfile,[String]$WindowsImage)
    $Staffsharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-Staff-Shared - $OSver"
    Set-OSDCloudTemplate -Name 'OSDCloud-Staff-Shared - $OSver'
    New-OSDCloudworkspace -WorkspacePath $Staffsharedworkspace
    #Cleanup Languages
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force

    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$Staffsharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $Staffsharedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$Staffsharedworkspace\Wallpaper\Staff-Shared.jpg" -Verbose
      
    copywim
    New-OSDCloudiso -WorkspacePath $Staffsharedworkspace
    $isoname = "OSDCloud - Staff-Shared - $OSVer.iso"
    rename-item -Path "$Staffsharedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$Staffsharedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### Staff Assigned ###
Function StaffAssigned {
    param([String]$OSVer,[String]$Configfile,[String]$WindowsImage)
    $Staffassignedworkspace = "D:\OSDCloud Workspaces\OSDCloud-Staff-Assigned - $OSver"
    Set-OSDCloudTemplate -Name 'OSDCloud-Staff-Assigned - $OSver'
    New-OSDCloudworkspace -WorkspacePath $Staffassignedworkspace
    #Cleanup Languages
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force

    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$Staffassignedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -workspacepath $Staffassignedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$Staffassignedworkspace\Wallpaper\Staff-Assigned.jpg" -Verbose
    CopyWim
    New-OSDCloudiso -WorkspacePath $Staffassignedworkspace
    $isoname = "OSDCloud - Staff-Assigned - $OSVer.iso"
    rename-item -Path "$Staffassignedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$Staffassignedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}
### PROD Staff Assigned ###
Function PRODStaffAssigned {
    param([String]$OSVer,[String]$Configfile)
    $prodStaffassignedworkspace = "D:\OSDCloud Workspaces\OSDCloud-PROD-Staff-Assigned - $OSver"
    Set-OSDCloudTemplate -Name 'OSDCloud-PROD-Staff-Assigned - $OSver'
    New-OSDCloudworkspace -WorkspacePath $prodStaffassignedworkspace
    #Cleanup Languages
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force

    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\French_Staff_Shared.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\PROD_IT_Assigned.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\PROD_Staff_Shared.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\PROD_Student_Assigned.json" -Force
    Remove-Item "$prodStaffassignedworkspace\Config\AutopilotJSON\PROD_Student_Shared.json" -Force
    
    Edit-OSDCloudwinpe -workspacepath $prodStaffassignedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$prodStaffassignedworkspace\Wallpaper\Staff-Assigned.jpg" -Verbose
    CopyWim
    New-OSDCloudiso -WorkspacePath $prodStaffassignedworkspace
    $isoname = "OSDCloud - PROD-Staff-Assigned - $OSVer.iso"
    rename-item -Path "$prodStaffassignedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$prodStaffassignedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### French Staff Shared ###
Function FrenchStaffShared {
    param([String]$OSVer,[String]$Configfile,[String]$WindowsImage)
    $FrenchStaffSharedworkspace = "D:\OSDCloud Workspaces\OSDCloud-French-Staff-Shared - $OSver"
    Set-OSDCloudTemplate -Name 'OSDCloud-French-Staff-Shared - $OSver'
    New-OSDCloudworkspace -WorkspacePath $FrenchStaffSharedworkspace
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\IT_Devices.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_Assigned.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Staff_shared.json" -Force
    Remove-Item "$FrenchStaffSharedworkspace\Config\AutopilotJSON\NoAdmin_Student_Shared.json" -Force
    Edit-OSDCloudwinpe -WorkspacePath $FrenchStaffSharedworkspace -CloudDriver Dell, HP, Wifi -StartURL $Configfile -wallpaper "$FrenchStaffSharedworkspace\Wallpaper\French-Staff-Shared.jpg" -Verbose
    CopyWim
    New-OSDCloudiso -WorkspacePath $FrenchStaffSharedworkspace
    $isoname = "OSDCloud - French-Staff-Shared - $OSVer.iso"
    rename-item -Path "$FrenchStaffSharedworkspace\OSDCloud.iso" -NewName $isoname
    copy-item -Path "$FrenchStaffSharedworkspace\$isoname" -Destination 'D:\OSDCloud Workspaces'
}

### General ###
Function General {
    $Generalworkspace = "D:\OSDCloud Workspaces\OSDCloud-General"
    Set-OSDCloudTemplate -Name 'OSDCloud-General'
    New-OSDCloudworkspace -WorkspacePath $Generalworkspace
    $KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Get-ChildItem "$(Get-OSDCloudWorkspace)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
    Edit-OSDCloudwinpe -workspacepath $Generalworkspace -CloudDriver Dell, HP, WiFi -wallpaper "$Generalworkspace\Wallpaper\guiwallpaper.jpg" -Verbose -StartOSDCloudGUI
    $Destination = "$(Get-OSDCloudWorkspace)\Media\OSDCloud\OS"
    $driversroot = "$(Get-OSDCloudWorkspace)\Media\OSDCloud\DriverPacks"
    New-Item -Path $Destination -ItemType Directory -Force
    New-Item -Path $driversroot -ItemType Directory -Force
    New-Item -Path $driversroot\Dell -ItemType Directory -Force
    New-Item -Path $driversroot\HP -ItemType Directory -Force
    New-Item -Path $driversroot\Lenovo -ItemType Directory -Force
    New-OSDCloudiso -WorkspacePath $Generalworkspace
    rename-item -Path "$Generalworkspace\OSDCloud.iso" -NewName "OSDCloud - General.iso"
    copy-item -Path "$Generalworkspace\OSDCloud - General.iso" -Destination 'D:\OSDCloud Workspaces'
}

StudentShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows10.wim"
StaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows10.wim"
StaffAssigned -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows10.wim"
FrenchStaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows10.wim"

StudentShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows11.wim"
StaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows11.wim"
StaffAssigned -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows11.wim"
FrenchStaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows11.wim"

PRODStaffAssigned -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows10.wim"
PRODStaffAssigned -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/OSD-Local-Image.ps1" -WindowsImage "Windows11.wim"


StudentShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StudentShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

StaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

StaffAssigned -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
StaffAssigned -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"
PRODStaffAssigned -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

FrenchStaffShared -OSVer "Win10" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config.ps1"
FrenchStaffShared -OSVer "Win11" -Configfile "https://raw.githubusercontent.com/retsdmbca/ZTI/master/RETSD-OSD-Git-Config-Win-11.ps1"

General #good




<#
#   https://www.wintips.org/how-to-extract-install-esd-to-install-wim-windows-10-8/
Mount-diskImage -ImagePath "D:\Windows11.iso"
dism /Get-WimInfo /WimFile:install.esd
dism /export-image /SourceImageFile:install.esd /SourceIndex:6 /DestinationImageFile:Windows11.wim /Compress:max /CheckIntegrity

#Update-OSDCloudUSB -DriverPack Lenovo
#Update-OSDCloudUSB -osname 'Windows 11 22H2' -OSActivation Retail
###Create USB Cloud - This will directly create OSDcloud USB drive.
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