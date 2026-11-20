@echo off
setlocal
cd /d "%~dp0"
echo Running DTU Course Registrar Audit & Reliability Tests...
call npm test
pause
