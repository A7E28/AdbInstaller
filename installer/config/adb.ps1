function InstallADB {
    Write-Host "ADB not found. Downloading and installing..."

    $sdkDir = "$env:USERPROFILE\AppData\Local\Android\Sdk"
    $platformToolsDir = "$sdkDir"

    if (!(Test-Path $platformToolsDir)) {
        New-Item -ItemType Directory -Force -Path $platformToolsDir | Out-Null
    }

    $url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
    $zipFile = "$sdkDir\platform-tools.zip"
    Invoke-WebRequest -Uri $url -OutFile $zipFile

    Expand-Archive -Path $zipFile -DestinationPath $platformToolsDir -Force

    # Add ADB to the system PATH
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $newPath = "$currentPath;$platformToolsDir\platform-tools"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")

    # Clean up - remove the downloaded zip file
    Remove-Item -Path $zipFile -Force

    Write-Host "ADB has been installed and added to the system PATH."
}

if (!(Test-Path "$env:USERPROFILE\AppData\Local\Android\Sdk\platform-tools\adb.exe")) {
    InstallADB
} else {
    Write-Host "ADB is already installed."
}

Write-Host "Press Enter to exit..."
Read-Host
