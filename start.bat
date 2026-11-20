@echo off
setlocal
cd /d "%~dp0"
echo ===================================================
echo   DTU Course Registrar - Windows Launcher
echo ===================================================
echo.

where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Node.js is not found on your system PATH!
    echo Please install Node.js (version 18 or newer) from:
    echo   https://nodejs.org/
    echo or run in PowerShell:
    echo   winget install OpenJS.NodeJS.LTS
    echo.
    pause
    exit /b 1
)

if not exist "node_modules\" (
    echo [INFO] Dependencies not found. Installing packages...
    call npm install
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] npm install failed. Please check your network connection.
        pause
        exit /b 1
    )
)

echo [INFO] Starting DTU Course Registrar...
call npm start
if %ERRORLEVEL% neq 0 (
    echo.
    echo Application stopped or encountered an error.
    pause
)
