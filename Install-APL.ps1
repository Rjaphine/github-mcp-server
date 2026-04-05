# Install-APL.ps1

# This PowerShell script installs APL (Dyalog APL and GNU APL options) on Windows.

# Set logging path
$logFile = "APLInstallLog.txt"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $logEntry = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logEntry
}

# Function to check if a program is installed
function Check-Program {
    param (
        [string]$program
    )
    $installed = Get-Command $program -ErrorAction SilentlyContinue
    return $installed -ne $null
}

# Install Dyalog APL
try {
    if (-not (Check-Program "dyalog")) {
        Log-Message "Installing Dyalog APL..."
        Start-Process -FilePath "msiexec.exe" -ArgumentList '/i https://www.dyalog.com/download/dyalog-apl-setup.msi /quiet' -Wait
        Log-Message "Dyalog APL installation completed."
    } else {
        Log-Message "Dyalog APL is already installed."
    }
} catch {
    Log-Message "Error installing Dyalog APL: $_"
}

# Install GNU APL
try {
    if (-not (Check-Program "gnu-apl")) {
        Log-Message "Installing GNU APL..."
        Start-Process -FilePath "choco" -ArgumentList 'install gnu-apl -y' -Wait
        Log-Message "GNU APL installation completed."
    } else {
        Log-Message "GNU APL is already installed."
    }
} catch {
    Log-Message "Error installing GNU APL: $_"
}

# Verification steps
if (Check-Program "dyalog") {
    Log-Message "Dyalog APL is installed successfully."
} else {
    Log-Message "Dyalog APL installation failed."
}

if (Check-Program "gnu-apl") {
    Log-Message "GNU APL is installed successfully."
} else {
    Log-Message "GNU APL installation failed."
}
