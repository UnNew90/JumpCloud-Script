# ==============================
# Wallpaper Configuration Script
# ==============================

$WallpaperURL = "https://rspo.org/wp-content/uploads/Wallpaper-CB-Gradient-2880x1800-1-scaled.png"
$WallpaperDir = "C:\RSPO"
$WallpaperPath = "$WallpaperDir\wallpaper.png"

# Create directory if not exists
if (!(Test-Path $WallpaperDir)) {
    New-Item -ItemType Directory -Path $WallpaperDir -Force | Out-Null
}

# Download wallpaper
Invoke-WebRequest -Uri $WallpaperURL -OutFile $WallpaperPath -UseBasicParsing

# Registry path
$RegPath = "HKCU:\Control Panel\Desktop"

# Set wallpaper path
Set-ItemProperty -Path $RegPath -Name Wallpaper -Value $WallpaperPath

# Set Stretch layout
# 2 = Stretch
Set-ItemProperty -Path $RegPath -Name WallpaperStyle -Value "2"
Set-ItemProperty -Path $RegPath -Name TileWallpaper -Value "0"

# Lock wallpaper (user cannot change)
$PolicyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"

if (!(Test-Path $PolicyPath)) {
    New-Item -Path $PolicyPath -Force | Out-Null
}

Set-ItemProperty -Path $PolicyPath -Name NoChangingWallPaper -Value 1 -Type DWord

# Refresh wallpaper without reboot
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters