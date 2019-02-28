
$server = '10.98.32.1'                                 # camera IP address using WIFI
# $server = '192.168.168.1'                            # camera IP address using USB RNDIS

# Set to capture mode /ctrl/mode?action=to_pb, switch to playback mode, =to_cap, switch to still mode, =to_rec, switch to movie mode

$uri = 'http://'+$server+'/ctrl/mode?action=to_cap'   
$uri2 = 'http://'+$server+'/ctrl/mode?action=query' 

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                 # send the URI to the camera to set mode
    $r = Invoke-WebRequest -Uri $uri2 -Method Get           # send the URI to the camera to get mode
    #$mode = $r.AllElements |                                # try to grok the non JSON response to get the mode
       # Where Class -eq "pre" |
        #Select -First 1 -ExpandProperty innerText 
    #Write-Output "mode is ";$mode                                                            
}
catch 
{
throw $_
}

# shoot_mode [Program AE, Aperture priority, Shutter priority, Manual mode] // Capture mode, exposure mode，P/A/S/M

$uri = 'http://'+$server+'/ctrl/set?shoot_mode=Manual mode'    
$uri2 = 'http://'+$server+'/ctrl/get?k=shoot_mode'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $shoot_mode = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $shoot_mode_set = 'Shoot Mode is set to '+$shoot_mode.value
                                 
}
catch 
{

throw $_
}

#set photosize to 16M [16M, 12M, 8M, 5M, 3M] //size of photo

$uri = 'http://'+$server+'/ctrl/set?photosize=16M'    
$uri2 = 'http://'+$server+'/ctrl/get?k=photosize'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $photosize = ConvertFrom-Json -InputObject $r.Content    # convert the JSON content to PS Object 
    $photosize_set = 'Photosize setting is '+$photosize.value  
                              
}
catch 
{
throw $_
}

#set photo_q [Basic, Fine, S.Fine, JPEG + DNG] //Photo quality

#$uri = 'http://'+$server+'/ctrl/set?photo_q=JPEG + DNG' 
$uri = 'http://'+$server+'/ctrl/set?photo_q=S.Fine'   # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=photo_q'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $photo_q = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $photo_q_set = 'Photo Quality is set to '+$photo_q.value
                                 
}
catch 
{

throw $_
}


#set drive mode to single // drive_mode [single, continuous, time_lapse, self-timer]

$uri = 'http://'+$server+'/ctrl/set?drive_mode=single'    # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=drive_mode'


try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $drive_mode = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $drive_mode_set = 'Drive Mode is set to '+$drive_mode.value 
                                
}
catch 
{

throw $_
}

#set focus to MF / focus [AF，MF] // Auto Focus or Manual Focus

$uri = 'http://'+$server+'/ctrl/set?focus=MF'    
$uri2 = 'http://'+$server+'/ctrl/get?k=focus'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $focus = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $focus_set = 'Focus is set to '+$focus.value
                             
}
catch 
{

throw $_
}


#set continuous auto focus to off

$uri = 'http://'+$server+'/ctrl/set?caf=0'    # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=caf'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $caf = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $caf_set ='CAF is set to '+$caf.value
                                 
}
catch 
{

throw $_
}


# shutter_spd to x seconds [Auto, 8", 6", 5", 4", 3.2", 2.5", 2", 1.6", 1.3", 1", 0.8", 0.6", 0.5", 0.4", 0.3", 1/4, 1/5, 1/6, 1/8, 1/10, 1/13, 1/15, 1/20, 1/25, 1/30,
# 1/40, 1/50, 1/60, 1/80, 1/100, 1/125, 1/160, 1/200, 1/250, 1/320, 1/400, 1/500, 1/640, 1/800, 1/1000, 1/1250, 1/1600, 1/2000, 1/2500, 1/3200, 1/4000, 1/5000, 1/6400, 1/8000]
# // shutter speed in seconds

#$uri = 'http://'+$server+'/ctrl/set?shutter_spd=1/100'
$uri = 'http://'+$server+'/ctrl/set?shutter_spd=8"'    
$uri2 = 'http://'+$server+'/ctrl/get?k=shutter_spd'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $shutter_spd = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $shutter_spd_set = 'Exposure is set to '+$shutter_spd.value+ ' seconds'                       
}
catch 
{

throw $_
}

#set iso  / iso [Auto, 100, 125, 160, 200, 250, 320, 400, 500, 640, 800, 1000, 1250, 1600, 2000, 2500, 3200, 4000, 5000, 6400, 8000, 10000, 12800, 16000, 20000, 256000, 51200, 102400]

#$uri = 'http://'+$server+'/ctrl/set?iso=4000'
$uri = 'http://'+$server+'/ctrl/set?iso=800'    # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=iso'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $iso = ConvertFrom-Json -InputObject $r.Content          # convert the JSON content to PS Object 
    $iso_set = 'ISO is set to '+$iso.value
                               
}
catch 
{

throw $_
}

#set wb to manual

$uri = 'http://'+$server+'/ctrl/set?wb=Manual'    # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=wb'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $wb = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $wb_set = 'White Balance is set to '+$wb.value
                                
}
catch 
{

throw $_
}

#set wb level mwb [2300 to 7500] // manual white balance, range type, step 100

$uri = 'http://'+$server+'/ctrl/set?mwb=2800'    # create uri with GET method for select capture mode
$uri2 = 'http://'+$server+'/ctrl/get?k=mwb'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                  # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get            # send the URI to the camera
    $mwb = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $mwb_set='Manual White Balance Level is set to '+$mwb.value 
                                
}
catch 
{

throw $_
}


# sharpness [Weak,  Normal , Strong] // Note: Normal has whitespace on both ends

$uri = 'http://'+$server+'/ctrl/set?sharpness=Strong'
#$uri = 'http://'+$server+'/ctrl/set?sharpness= Normal '    
$uri2 = 'http://'+$server+'/ctrl/get?k=sharpness'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $sharpness = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $sharpness_set='Sharpness is set to '+$sharpness.value
                                 
}
catch 
{

throw $_
}

# saturation [0 to 256] //range type, step 1 

$uri = 'http://'+$server+'/ctrl/set?saturation=64'    
$uri2 = 'http://'+$server+'/ctrl/get?k=saturation'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $saturation = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $saturation_set='Saturation is set to '+$saturation.value 
                                
}
catch 
{

throw $_
}

# tint [-100 to 100] //range type, step 1 

$uri = 'http://'+$server+'/ctrl/set?tint=1'    
$uri2 = 'http://'+$server+'/ctrl/get?k=tint'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $tint = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $tint_set='Tint is set to '+$tint.value 
                                
}
catch 
{

throw $_
}


# contrast [0 to 256] //range type, step 1

$uri = 'http://'+$server+'/ctrl/set?contrast=64'    
$uri2 = 'http://'+$server+'/ctrl/get?k=contrast'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $contrast = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $contrast_set = 'Contrast is set to '+$contrast.value  
                               
}
catch 
{

throw $_
}

# brightness [-256 to 256] // image brightness, range type, step 1

$uri = 'http://'+$server+'/ctrl/set?brightness=0'    
$uri2 = 'http://'+$server+'/ctrl/get?k=brightness'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $brightness = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $brightness_set ='Brightness is set to '+$brightness.value 
                                
}
catch 
{

throw $_
}

# lcd [On, Off] // turn on/off LCD

$uri = 'http://'+$server+'/ctrl/set?lcd=Off'    
$uri2 = 'http://'+$server+'/ctrl/get?k=lcd'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $lcd = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $lcd_set = 'LCD is set to '+$lcd.value  
                               
}
catch 
{

throw $_
}

# led [On, Off] // turn on/off LED

$uri = 'http://'+$server+'/ctrl/set?led=Off'    
$uri2 = 'http://'+$server+'/ctrl/get?k=led'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $led = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $led_set = 'LED is set to '+$led.value 
                                
}
catch 
{

throw $_
}

# beep [On, Off] // turn on/off beep

$uri = 'http://'+$server+'/ctrl/set?beep=On'    
$uri2 = 'http://'+$server+'/ctrl/get?k=beep'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $beep = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $beep_set = 'Beep is set to '+$beep.value 
                           
}
catch 
{

throw $_
}

# dewarp [On, Off]  // Distortion correction

$uri = 'http://'+$server+'/ctrl/set?dewarp=Off'    
$uri2 = 'http://'+$server+'/ctrl/get?k=dewarp'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $dewarp = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $dewarp_set = 'Distortion Correction is set to '+$dewarp.value   
                              
}
catch 
{

throw $_
}

# vignette [On, Off] // Vignette correction

$uri = 'http://'+$server+'/ctrl/set?vignette=Off'    
$uri2 = 'http://'+$server+'/ctrl/get?k=vignette'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $vignette = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $vignette_set = 'Vignette Correction is set to '+$vignette.value 
                                
}
catch 
{

throw $_
}

# noise_reduction [Weak, NormalNoise, Strong] // Noise reduction

#$uri = 'http://'+$server+'/ctrl/set?noise_reduction=Weak'    
#$uri2 = 'http://'+$server+'/ctrl/get?k=noise_reduction'

#try 
#{
    #Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    #$r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    #$noise_reduction = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    #$noise_reduction_set = 'noise reduction is set to '+$noise_reduction.value 
                                
#}
#catch 
#{

#throw $_
#}

# max_iso [100, 125, 160, 200, 250, 320, 400, 500, 640, 800, 1000, 1250, 1600, 2000, 2500, 3200, 4000, 5000, 6400] / Only used in Auto ISO mode

#$uri = 'http://'+$server+'/ctrl/set?max_iso=6400'    
#$uri2 = 'http://'+$server+'/ctrl/get?k=max_iso'

#try 
#{
   # Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
   # $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
   # $max_iso = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
   # $max_iso_set = 'max iso is set to '+$max_iso.value
                                
#}
#catch 
#{

#throw $_
#}

# auto_off ["0","30","60","120","240","480","900"] //turn off camera

$uri = 'http://'+$server+'/ctrl/set?auto_off=0'    
$uri2 = 'http://'+$server+'/ctrl/get?k=auto_off'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $auto_off = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $auto_off_set = 'Auto Off is set to '+$auto_off.value  
                               
}
catch
{

throw $_
}

#lut [sRGB, Z-LOG] // Look Up Table

$uri = 'http://'+$server+'/ctrl/set?lut=sRGB'  
#$uri = 'http://'+$server+'/ctrl/set?lut=Z-LOG'  
$uri2 = 'http://'+$server+'/ctrl/get?k=lut'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $lut = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $lut_set = 'Look Up Table is set to '+$lut.value
                                 
}
catch 
{

throw $_
}

# camera_rot [0\u00b0, 90\u00b0, 180\u00b0, 270\u00b0] // rotate camera image in degrees 

$uri = 'http://'+$server+'/ctrl/set?camera_rot=0\u00b0'    
$uri2 = 'http://'+$server+'/ctrl/get?k=camera_rot'

try 
{
    Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $camera_rot = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $camera_rot_set = 'Camera Rotation is set to '+$camera_rot.value  
                               
}
catch 
{

throw $_
}

#ev [-96 to 96] // exposure value, range type, step 1 // only available in Program AE mode

#$uri = 'http://'+$server+'/ctrl/set?ev=0'    
#$uri2 = 'http://'+$server+'/ctrl/get?k=ev'

#try 
#{
    #Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
    #$r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    #$ev = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    #$ev_set = 'exposure value is set to '+$ev.value 
                                
#}
#catch 
#{

#throw $_
#}

#battery [0 to 100] // read only, battery charge percentage
   
$uri2 = 'http://'+$server+'/ctrl/get?k=battery'

try 
{
    
    $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
    $battery = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
    $battery_set = 'Battery Level is '+$battery.value+' percent'
                            
}
catch 
{

throw $_
}

# grid_display [0,3,5] // display 3x3 or 5x5 grid on LCD screen

#$uri = 'http://'+$server+'/ctrl/set?grid_display=0'    
#$uri2 = 'http://'+$server+'/ctrl/get?k=grid_display'

#try 
#{
   # Invoke-WebRequest -Uri $uri -Method Get                   # send the URI to the camera
   # $r = Invoke-WebRequest -Uri $uri2 -Method Get             # send the URI to the camera
   # $grid_display = ConvertFrom-Json -InputObject $r.Content       # convert the JSON content to PS Object 
   # $grid_display_set ='Grid Display is set to '+$grid_display.value 
                                
#}
#catch 
#{

#throw $_
#}

Write-Output $shoot_mode_set
Write-Output $drive_mode_set
Write-Output $focus_set
Write-Output $caf_set
Write-Output $photosize_set 
Write-Output $photo_q_set
Write-Output $shutter_spd_set
Write-Output $iso_set 
Write-Output $wb_set 
Write-Output $mwb_set
Write-Output $sharpness_set
Write-Output $saturation_set
Write-Output $tint_set
Write-Output $contrast_set
Write-Output $brightness_set
Write-Output $lcd_set
Write-Output $led_set
Write-Output $beep_set
Write-Output $dewarp_set
Write-Output $vignette_set
#Write-Output $noise_reduction_set
#Write-Output $max_iso_set
Write-Output $auto_off_set
Write-Output $lut_set
Write-Output $camera_rot_set
#Write-Output $ev_set
Write-Output $battery_set
#Write-Output $grid_display_set
