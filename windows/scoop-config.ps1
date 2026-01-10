<#
.SYNOPSIS
    Script 2 to Initialize a new machine.
.DESCRIPTION
    Install scoop, install scoop packages and config some packages
.NOTES
    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

$VerbosePreference = "Continue"
$Desktop = $args[0]

# ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░█▀▄░█▀▀░█▀▀░█░░░█▀█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█░░░█░█░█▀▀░█░░░█░░░█▀█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
function Install-ScoopApp {
    param (
        [string]$Package
    )
    Write-Verbose -Message "Preparing to install $Package"
    if (! (scoop info $Package).Installed ) {
        Write-Verbose -Message "Installing $Package"
        scoop install $Package
    } else {
        Write-Verbose -Message "Package $Package already installed! Skipping..."
    }
}

function Enable-Bucket {
    param (
        [string]$Bucket
    )
    if (!($(scoop bucket list).Name -eq "$Bucket")) {
        Write-Verbose -Message "Adding Bucket $Bucket to scoop..."
        scoop bucket add $Bucket
    } else {
        Write-Verbose -Message "Bucket $Bucket already added! Skipping..."
    }
}

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▀░█▀▀░█▀█░█▀█░█▀█
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░▀▀█░█░░░█░█░█░█░█▀▀
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░
# if not already installed
if ( !(Get-Command -Name "scoop" -CommandType Application -ErrorAction SilentlyContinue) ) {
    Write-Verbose -Message "Installing Scoop..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))
} else {
    Write-Verbose -Message "Scoop already installed, continue."
}

# add buckets if not already added
$ScoopBuckets = @(
    "extras",
    "nerd-fonts",
    "games",
    "nirsoft"
)
foreach ($item in $ScoopBuckets) {
    Enable-Bucket "$item"
}

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▀░█▀▀░█▀█░█▀█░█▀█░░░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░▀▀█░█░░░█░█░█░█░█▀▀░░░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀
$Scoop = @(
    "thunderbird",
    "busybox",
    "fzf",
    "ripgrep",
    "bat",
    "nodejs",
    "neovide",
    # "sudo", # Windows 11 has built-in sudo now
    "putty",
    "winscp",
    "filebot",
    "rufus",
    "cpu-z",
    "gpu-z",
    "ssd-z",
    "hwinfo",
    "windirstat",
    "Hack-NF",
    "JetBrainsMono-NF-Mono",
    "JetBrainsMono-NF",
    "FiraCode",
    "driverstoreexplorer",
    "keepass",
    "obsidian",
    "uv",
    "filezilla",
    "inkscape",
    "mobaxterm",
    "ffmpeg",
    "sox",
    "mpv",
    "lame",
    "mp3tag",
    "eac",
    "handbrake",
    "audacity",
    "deluge",
    "nuclear",
    "syncthing",
    "via",
    "turnedontimesview",
    "gitleak",
    "freecad",
    "jq", # Yazi additional features
    "poppler", # Yazi additional features
    "fd", # Yazi additional features
    "zoxide", # Yazi additional features
    "resvg", # Yazi additional features
    "imagemagick", # Yazi additional features
    "ghostscript", # Yazi additional features
    "yazi"
)
foreach ($item in $Scoop) {
    Install-ScoopApp -Package "$item"
}

# Install Scoop Packages, if Desktop
if ($Desktop) {
    Write-Verbose -Message "Installing Home Workstation packages..."
    Remove-Variable -Name "Scoop"
    $Scoop = @(
        # "postgresql",
        "qmk-toolbox",
        "plex-server",
        "battlenet"
        )
    foreach ($item in $Scoop) {
        Install-ScoopApp -Package "$item"
    }
}

