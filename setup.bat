@echo off
setlocal
cd /d "%~dp0"
echo ===================================================
echo   DTU Course Registrar - Windows Setup
echo ===================================================
echo.

where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [WARNING] Node.js is not detected on PATH.
    echo Attempting to install Node.js LTS via winget...
    winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Automatic installation could not complete.
        echo Please manually download and install Node.js from https://nodejs.org/
        pause
        exit /b 1
    )
    echo [INFO] Node.js installed. Please restart this script in a new terminal.
    pause
    exit /b 0
)

for /f "tokens=*" %%v in ('node -v') do set NODE_VERSION=%%v
for /f "tokens=*" %%v in ('npm -v') do set NPM_VERSION=%%v
echo [OK] Node.js version: %NODE_VERSION%
echo [OK] npm version:     %NPM_VERSION%
echo.

echo [INFO] Installing / updating dependencies...
call npm install
if %ERRORLEVEL% equ 0 (
    echo.
    echo ===================================================
    echo   Setup Completed Successfully!
    echo   Run "start.bat" or "npm start" to launch the app.
    echo ===================================================
) else (
    echo.
    echo [ERROR] Installation encountered errors.
)
pause
