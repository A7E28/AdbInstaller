@echo off
set "batchDir=%~dp0"
powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""%batchDir%\adb.ps1""' -Verb RunAs"
