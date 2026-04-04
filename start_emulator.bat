@echo off
REM ========================================
REM Android Emulator - Optimized for RDP
REM ========================================
REM
REM This script starts the Android emulator
REM with settings optimized for Remote Desktop
REM
REM Author: ICD360S e.V.
REM Date: 2026-02-01
REM ========================================

echo.
echo ========================================
echo  Android Emulator - RDP Optimized
echo ========================================
echo.
echo Starting emulator with:
echo  - AVD: Medium_Phone_API_36.1
echo  - GPU: SwiftShader (software rendering)
echo  - No snapshots (avoid corruption)
echo  - Resolution: 1080x2400
echo  - RAM: 8GB, CPU: 8 cores
echo.
echo Please wait 1-2 minutes for boot...
echo.

"C:\Users\androidapp\AppData\Local\Android\Sdk\emulator\emulator.exe" -avd Medium_Phone_API_36.1 -no-snapshot -no-boot-anim

echo.
echo Emulator closed.
pause
