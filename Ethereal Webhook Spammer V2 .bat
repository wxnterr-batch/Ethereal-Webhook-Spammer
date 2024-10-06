@echo off
chcp 65001
title made by wxnterr
color 1

:: Define the users file
set users_file=users.txt

:: Initialize logged_in variable
set logged_in=0

:menu
cls
echo.
echo.
echo ███████╗████████╗██╗  ██╗███████╗██████╗ ███████╗ █████╗ ██╗     
echo ██╔════╝╚══██╔══╝██║  ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██║     
echo █████╗     ██║   ███████║█████╗  ██████╔╝█████╗  ███████║██║     
echo ██╔══╝     ██║   ██╔══██║██╔══╝  ██╔══██╗██╔══╝  ██╔══██║██║     
echo ███████╗   ██║   ██║  ██║███████╗██║  ██║███████╗██║  ██║███████╗
echo ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝
echo.
echo.                                                                 


if %logged_in%==0 (
    echo ┌────────────────────────────────┐
    echo │            SPAMMER             │
    echo ├────────────────────────────────┤
    echo │ 1. Exit                        │
    echo │ 2. Register                    │
    echo │ 3. Login                       │
    echo └────────────────────────────────┘
) else (
    echo ┌────────────────────────────────┐
    echo │            SPAMMER             │
    echo ├────────────────────────────────┤
    echo │ 1. Exit                        │
    echo │ 2. Discord webhook spammer     │
    echo │ 3. IP Geolocator
    echo └────────────────────────────────┘
)

set /p choice=Enter your choice: 

if "%choice%"=="1" goto :eof
if "%choice%"=="2" if %logged_in%==0 goto register
if "%choice%"=="3" if %logged_in%==0 goto login
if "%choice%"=="2" if %logged_in%==1 goto messagesender
if "%choice%"=="3" if %logged_in%==1 goto ipgeolocator
goto menu

:register
cls
echo ┌────────────────────────────────┐
echo │            Register            │
echo ├────────────────────────────────┤
set /p "username=│ Enter a username: "
set /p "password=│ Enter a password: "

:: Check if the username already exists
findstr /C:"%username%" %users_file% >nul
if %errorlevel%==0 (
    echo User already exists! Please choose a different username.
    pause
    goto menu
)

:: Register the user
echo %username% %password% >> %users_file%
echo Registration successful!
pause
goto menu

:login
cls
echo ┌────────────────────────────────┐
echo │             Login              │
echo ├────────────────────────────────┤
set /p "username=│ Enter your username: "
set /p "password=│ Enter your password: "

:: Check for the username and password
findstr /C:"%username% %password%" %users_file% >nul
if %errorlevel%==0 (
    echo Login successful! Welcome, %username%.
    set logged_in=1
    pause
) else (
    echo Invalid username or password.
    pause
)
goto menu

:messagesender
:messagesender_loop
cls
echo ┌────────────────────────────────┐
echo │     Discord webhook spammer    │
echo ├────────────────────────────────┤
set /p "webhook=│ Enter Discord webhook URL for Message Sender: "
set /p "message=│ Enter the message to send: "
set /p "num_times=│ Enter the number of times to send the message: "

for /l %%n in (1,1,%num_times%) do (
    :: Send message to Discord webhook
    curl -X POST -H "Content-Type: application/json" -d "{\"content\": \"%message%\"}" %webhook%
)
echo Messages sent successfully.
pause
goto menu

:ipgeolocator
:ipgeolocator_loop
cls
echo ███████╗███╗   ██╗████████╗███████╗██████╗     ██╗██████╗ 
echo ██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔══██╗    ██║██╔══██╗
echo █████╗  ██╔██╗ ██║   ██║   █████╗  ██████╔╝    ██║██████╔╝
echo ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗    ██║██╔═══╝ 
echo ███████╗██║ ╚████║   ██║   ███████╗██║  ██║    ██║██║     
echo ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝
echo. ================================================
echo Enter An IP address to lookup (or type back to return to the main menu):
set /p ip=
if "%ip%"=="back" goto menu

curl "https://ipinfo.io/%ip%/json" -o geolocation.json
if %errorlevel% neq 0 (
    echo Error: Could not retrieve geolocation data.
    pause
    goto menu
)

echo ==================================
echo IP Geolocation for %ip%:
type geolocation.json
del geolocation.json
echo =================================
pause
goto menu



