@echo off
:: =====================================================================
:: Program      : Advanced Network Stats Monitor
:: Author       : Hafist Afrizal
:: =====================================================================

:: Meminta hak akses Administrator otomatis
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :admin_ok
) else (
    echo [!] Meminta hak akses Administrator...
    powershell -Command "Start-Process -FilePath '%~dpnx0' -Verb RunAs"
    exit /b
)

:admin_ok
mode 50,30
color 0B
title Advanced Network Stats Monitor

:: Layar loading 
cls
echo.
echo   ==============================================
echo      N E T W O R K   S T A T S   M O N I T O R
echo   ==============================================
echo.
echo   [*] Sedang mengambil data, mohon tunggu...

:loop
:: 1. Reset Variabel
set "ssid=Tidak Ada"
set "adapter=N/A"
set "state=Disconnected"
set "signal=0%%"
set "receive=0"
set "ping=RTO"
set "ploss=100"
set "perloss=100%% loss"
set "rbytes=0"
set "sbytes=0"
set "pubip=Mencari..."

:: 2. Mengambil IP Publik
for /f %%a in ('curl -s --max-time 2 ifconfig.me') do set pubip=%%a

:: 3. Mengambil Data Wi-Fi Lokal
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface 2^>nul ^| find "SSID" ^| findstr /v "BSSID"') do set ssid=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface 2^>nul ^| find "Description"') do set adapter=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface 2^>nul ^| find "State"') do set state=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface 2^>nul ^| find "Signal"') do set signal=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface 2^>nul ^| find "Receive rate"') do set receive=%%a

:: 4. Melakukan Test Ping
ping -n 2 8.8.8.8 > %temp%\ping.txt
for /f "tokens=4 delims==" %%a in ('type %temp%\ping.txt ^| find "Average"') do set ping=%%a
for /f "tokens=10 delims= " %%a in ('type %temp%\ping.txt ^| find "Lost"') do set ploss=%%a
for /f "tokens=11 delims= " %%a in ('type %temp%\ping.txt ^| find "Lost"') do set perloss=%%a

:: 5. Mengambil Data Netstat Transmisi
for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes"') do set rbytes=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes"') do set sbytes=%%a

:: ====================
:: 6. TAMPILAN UTAMA 
:: ====================
cls
echo.
echo   ==============================================
echo      N E T W O R K   S T A T S   M O N I T O R
echo   ==============================================
echo.
echo   [ LOCAL NETWORK ]
echo   ----------------------------------------------
echo   Public IP    : %pubip%
echo   SSID         :%ssid%
echo   Adapter      :%adapter%
echo   Status       :%state%
echo   Signal       :%signal%
echo   Link Speed   :%receive% Mbps
echo.
echo   [ CONNECTION SPEED ^& DATA ]
echo   ----------------------------------------------
echo   Ping Latency :%ping%
echo   Packet Loss  : %ploss% %perloss%)
echo   Data Received: %rbytes% Bytes 
echo   Data Sent    : %sbytes% Bytes
echo.
echo   ==============================================
echo   Diperbarui otomatis. Tekan CTRL+C untuk keluar.

:: Jeda 2 detik sebelum mengulang
timeout /t 2 >nul

goto loop