@echo off
set "batchDir=%~dp0"

rem Set the path to the config folder
set "configFolder=%batchDir%config"

rem Check if the config folder exists
if exist "%configFolder%" (
    rem Check PowerShell version
    echo Checking PowerShell version...
    powershell.exe -Command "$PSVersionTable.PSVersion"

    rem Check for Invoke-WebRequest
    echo Checking for Invoke-WebRequest...
    powershell.exe -Command "if (-not (Get-Command -Name Invoke-WebRequest -ErrorAction SilentlyContinue)) { echo 'Invoke-WebRequest not found. Please update PowerShell to run the ADB installer.' } else { echo 'Invoke-WebRequest is available.' }"

    rem Run the preparation script from the config folder if Invoke-WebRequest is available
    powershell.exe -Command "if (Test-Path variable:/LastError) { echo 'Please update PowerShell to run the ADB installer.' } else { echo 'Running ADB installer script...'; pause; Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""%configFolder%\adb.ps1""' -Verb RunAs }"

) else (
    echo "Config folder not found!"
)

echo Press Enter to exit...
pause > nul
