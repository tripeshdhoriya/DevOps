@echo off
title "Starting HMI"
REM Wait until other apps have started (ie Viewopower)
REM And then make sure the browsers are closed
:: PowerShell -nop "& sleep 10" 
tasklist /fi "imagename eq msedge.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "msedge.exe"
tasklist /fi "imagename eq chrome.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "chrome.exe"

REM Start Hummingbird
set EDGE="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set CHROME="C:\Program Files\Google\Chrome\Application\chrome.exe"
set URL=http://192.168.1.67:/#/hblogin/eTrue/c3Mtc3VwcG9ydC9TISpnUVhiZVl6W3QkbSpeOzhvZD93ZWxsbmFtZT1ERU1PX1dFTEwmcGF0aD1kaXNwbGF5ZGFzaGJvYXJkL21haW4vMTAwMDA0NC82MmQ3NTc3ZS01MTc3LTQ2Y2QtOTRmNC03ZmY5ZjMxOTY3OTAvSE1JLU5ldy1EYXNoYm9hcmQmdG9vbGJhcj1mYWxzZSZ1b21wcm9maWxlPUltcGVyaWFs
::%EDGE% --kiosk %URL% --edge-kiosk-type=fullscreen --no-first-run
%CHROME% --kiosk %URL% --chrome-frame=fullscreen
