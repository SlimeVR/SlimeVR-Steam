@echo off
set "LOG_PATH=%~dp0"
set "LOGFILE=%LOG_PATH%driver_install.log"

:: Driver installation doesn't work w/o admin, slimes will be sad.
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Requesting administrative privileges for USB driver installation!
    :: Temp script to request admin... Works and doesn't leave a mess.
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c cd /d ""%LOG_PATH%"" && %~s0 > ""%LOGFILE%"" 2>&1", "", "runas", 0 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

pnputil /add-driver "slimevr_usb_drivers\*.inf" /install /subdirs
:: Overwrite the exit code so the script doesn't keep running when already installed
if %ERRORLEVEL% == 2 (
    exit /B 0
)
