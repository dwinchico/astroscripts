# trigger a ZCam E1 CMOS camera, download the file from the SD card to local drive, move the file to a network share folder being monitored by SharpCap
# set number of captures at line 13 $captures = 150
# The move after download is need because SharpCap live stacking detects files that are moved not downloaded


Unregister-Event FileCreated                              # unregister to prevent error msg already registered

$server = '10.98.32.1'                                    # camera IP address using WIFI
# $server = '192.168.168.1'                               # camera IP address using USB RNDIS
$folder = 'C:\astro\'                                     # path of the folder to watch for files downloaded from SD card of camera
# $destination = '\\192.168.xx.xx\xxxx\astro\astro_2'     # path of the destination folder to move files to so SharpCap will Live Stack them
$destination = '\\192.168.xx.xx\xxxx\astro\astro_2'       # path of the destination folder to move files to so SharpCap will Live Stack them
$captures = 150                                           # number of captures to take before exiting

$uri2 = 'http://'+$server+'/ctrl/still?action=single'     # capture single exposure
$uri = 'http://'+$server+'/ctrl/get?k=last_file_name'     # latest file name created on SD card
$webclient = New-Object System.Net.WebClient

# watch folder for newly downloaded files and move them to another folder - Sharpcap won't Live Stack downloaded files, files must be moved for Live Stack to work
 
$filter = '*.*'                                           # set this filter according to your requirements
$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
  NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
}

$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
 $path = $Event.SourceEventArgs.FullPath
 $name = $Event.SourceEventArgs.Name
 $changeType = $Event.SourceEventArgs.ChangeType
 $timeStamp = $Event.TimeGenerated
 Write-Host "The file $name was $changeType at $timeStamp"
 Move-Item $path -Destination $destination -Force -Verbose # Force will overwrite files with same name
}

# Loop & Capture images, trim filename, and download them from SD card - Write out name of file and battery level

$i = 0

foreach($i in 1..$captures)
{
    If($i-ne$captures+1) {
    try 
    {
    
    Invoke-WebRequest -Uri $uri2 -Method Get                # take a single capture
    #   Start-Sleep -Seconds 10                             # wait 10 seconds
    $r = Invoke-WebRequest -Uri $uri -Method Get            # get last filename
    $result = ConvertFrom-Json -InputObject $r.Content      # convert the JSON content to PS Object 
    $dl = 'http://'+$server+''+$result.value+''             # create the URI for downloading the file using .value (last file)
    $filename = $result.value
    $filename_trim = $filename.Substring(18)                # trim off DCIM/MEDIA100/EYE in front of filename
    $bleh = 'Image '+$i+' of '+$captures                    # string for number of capture taken 
    Write-Output $bleh
    $webclient.DownloadFile($dl,$folder+$filename_trim)     # download the last filename from the SD card
    }
    catch 
    {
    throw $_
    }
    }
    
    # Get Camera Battery Level and Write Out
   
    $uri3 = 'http://'+$server+'/ctrl/get?k=battery'           # get battery charge percentage

    try 
    {
    
    $r = Invoke-WebRequest -Uri $uri3 -Method Get             # send the URI to the camera
    $battery = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $blob = 'Battery level is '+$battery.value+' %'           # string for battery percentage 
    Write-Output $blob                            
    }
    catch 
    {

    throw $_
    }
}
