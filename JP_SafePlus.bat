
@ECHO OFF
chcp 65001
setlocal enabledelayedexpansion
PowerShell -ExecutionPolicy RemoteSigned -File .\src\main.ps1

pause
exit