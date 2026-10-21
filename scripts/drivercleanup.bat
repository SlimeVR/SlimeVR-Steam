@echo off
set "LOG_PATH=%~dp0"
set "LOGFILE=%LOG_PATH%driver_cleanup.log"

:: Driver cleanup doesn't work w/o admin, slimes will be sad.
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Requesting administrative privileges for driver cleanup!
    :: Temp script to request admin... Works and doesn't leave a mess.
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c cd /d ""%LOG_PATH%"" && %~s0 > ""%LOGFILE%"" 2>&1", "", "runas", 0 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

:: Fixup SteamVR installation, since the standalone installer copies the driver
:: into the SteamVR drivers folder instead of using vrpathreg.
set "DRIVERPATH=%STEAMPATH%\steamapps\common\SteamVR\drivers\slimevr"
if exist %DRIVERPATH% (
    rd /s /q %DRIVERPATH%
)
