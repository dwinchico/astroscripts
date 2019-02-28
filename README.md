# astroscripts
scripts for controlling astronomy equipment

zcam.ps1 is a script to use a ZcamE1 for astrophotography with SharpCap in folder monitor camera mode.
The script will take an image, download the file from the SD card, trim the filename, and move it to a network share.
Moving after downloading is required because SharpCap will not live stack files downloaded into the monitored folder.
SharpCap will only detect files moved into the monitor folder - files downloaded into the monitored folder are not Live Stacked

zcamsettings.ps1 will configure the settings on a Zcam E1 using HTTP Get.
The Settings are then queried and converted from JSON and displayed at end of script.
Settings do not persist on a ZcamE1 after it is turned off (Firmware .30) 
