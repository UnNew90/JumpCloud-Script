# ==============================
# FINAL SYSTEM WALLPAPER SCRIPT
# ==============================

$WallpaperURL  = "https://rspo.org/wp-content/uploads/Wallpaper-CB-Gradient-2880x1800-1-scaled.png"
$BaseDir       = "C:\RSPO"
$WallpaperPath = "$BaseDir\wallpaper.png"

# Ensure directory
if (!(Test-Path $BaseDir)) {
    New-Item -ItemType Directory -Path $BaseDir -Force | Out-Null
}

# Download wallpaper
Invoke-WebRequest -Uri $WallpaperURL -OutFile $WallpaperPath -UseBasicParsing

# ------------------------------
# SYSTEM POLICY (ALL USERS)
# ------------------------------
$SystemPolicy = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ActiveDesk   = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"

foreach ($path in @($SystemPolicy, $ActiveDesk)) {
    if (!(Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }
}

# Apply wallpaper
Set-ItemProperty $SystemPolicy Wallpaper $WallpaperPath

# IMPORTANT:
# 10 = Fill  (best for Windows 11)
# 6  = Fit
Set-ItemProperty $SystemPolicy WallpaperStyle "10"

# Lock wallpaper
Set-ItemProperty $ActiveDesk NoChangingWallPaper 1 -Type DWord