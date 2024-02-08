# Disable Windows Update via Registry

# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an administrator."
    Exit
}

# Define registry keys and values
$regKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$regValueName = "AUOptions"
$regValueData = 2

# Create WindowsUpdate registry key if it doesn't exist
if (-not (Test-Path $regKeyPath)) {
    New-Item -Path $regKeyPath -Force | Out-Null
}

# Set AUOptions registry value to disable automatic updates
New-ItemProperty -Path $regKeyPath -Name $regValueName -Value $regValueData -PropertyType DWORD -Force | Out-Null

Write-Host "Automatic updates have been disabled successfully."
