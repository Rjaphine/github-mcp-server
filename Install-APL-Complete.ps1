# Install-APL-Complete.ps1

# Constants
$LogFile = "Install-APL-Complete.log"
$StartTime = Get-Date

# Function to log messages
function Log-Message {
    param(
        [string]$Message
    )
    $Timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $LogFile -Value "$Timestamp - $Message"
}


# Function to install Dyalog APL
function Install-DyalogAPL {
    Log-Message "Starting Dyalog APL installation..."
    $InstallerPath = "https://www.dyalog.com/Download/Dyalog-APL-Installer.msi"
    $LocalInstaller = "Dyalog-APL-Installer.msi"

    try {
        Invoke-WebRequest -Uri $InstallerPath -OutFile $LocalInstaller
        Start-Process -FilePath msiexec.exe -ArgumentList "/i $LocalInstaller /quiet /norestart" -Wait
        Log-Message "Dyalog APL installed successfully."
    } catch {
        Log-Message "Error during Dyalog APL installation: $_"
        Exit 1
    } finally {
        Remove-Item -Path $LocalInstaller -ErrorAction SilentlyContinue
    }
}

# Function to install GNU APL
function Install-GNUAPL {
    Log-Message "Starting GNU APL installation..."
    $InstallerPath = "https://ftpmirror.gnu.org/apl/gnu-apl-1.6.1-win64.zip"
    $LocalInstaller = "gnu-apl.zip"

    try {
        Invoke-WebRequest -Uri $InstallerPath -OutFile $LocalInstaller
        Expand-Archive -Path $LocalInstaller -DestinationPath "C:\GNUAPL" -Force
        Log-Message "GNU APL installed successfully."
    } catch {
        Log-Message "Error during GNU APL installation: $_"
        Exit 1
    } finally {
        Remove-Item -Path $LocalInstaller -ErrorAction SilentlyContinue
    }
}

# Main script execution
Log-Message "Installation started at $StartTime"
Install-DyalogAPL
Install-GNUAPL
Log-Message "Installation completed at $(Get-Date)"