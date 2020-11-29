:: ViPER4Windows Patcher.
:: Version: 2.0
:: Written by Metaspook
:: License: <http://opensource.org/licenses/MIT>
:: Copyright (c) 2019-2020 Metaspook.
:: 
@echo off

::
:: REQUESTING ADMINISTRATIVE PRIVILEGES
::
>nul 2>&1 reg query "HKU\S-1-5-19\Environment"
if '%errorlevel%' NEQ '0' (
	(echo.Set UAC = CreateObject^("Shell.Application"^)&echo.UAC.ShellExecute "%~s0", "", "", "runas", 1)>"%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
) else ( >nul 2>&1 del "%temp%\getadmin.vbs" )

::
:: MAIN SCRIPT STARTS BELOW
::
title "ViPER4Windows Patcher"
color 0B
pushd "%~dp0"
set APPVAR=2.0
for /f "tokens=2*" %%X in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\ViPER4Windows" /v ConfigPath') do set PAPPDIR=%%Y
set APPDIR=%PAPPDIR:\DriverComm=%
mode con: cols=46 lines=20

:CHOICE_MENU
call:BANNER
echo      +--[ OPTION MENU ]-----------+
echo      ^|                            ^|
echo      ^|  1. Registry Patch.        ^|
echo      ^|  2. Launch Configurator.   ^|
echo      ^|  3. Restart Audio Service  ^|
echo      ^|  0. Exit.                  ^|
echo      +----------------------------+
echo.
echo  # Type a number below and press Enter key.
echo  # Stop all audio output before option 3.
echo.
set CMVAR=
set /p "CMVAR=Enter Option: "
if "%CMVAR%"=="0" exit
if not exist "%APPDIR%" (
	call:BANNER
	echo [FAIL!] ViPER4Windows isn't installed.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="1" (
	call:BANNER
	for %%a in (HKLM\SOFTWARE\Classes HKCR) do (
		>nul 2>&1 reg delete "%%a\AudioEngine\AudioProcessingObjects" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "FriendlyName" /t REG_SZ /d "ViPER4Windows" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "Copyright" /t REG_SZ /d "Copyright (C) 2013, vipercn.com" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MajorVersion" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinorVersion" /t REG_DWORD /d "0" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "Flags" /t REG_DWORD /d "13" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinInputConnections" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxInputConnections" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinOutputConnections" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxOutputConnections" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxInstances" /t REG_DWORD /d "4294967295" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "NumAPOInterfaces" /t REG_DWORD /d "1" /f
		>nul 2>&1 reg add "%%a\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "APOInterface0" /t REG_SZ /d "{FD7F2B29-24D0-4B5C-B177-592C39F9CA10}" /f
	)
	>nul 2>&1 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%APPDIR%\ViPER4WindowsCtrlPanel.exe" /t REG_SZ /d "RUNASADMIN" /f
	echo [DONE] Registry patch applied.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="2" (
	if exist "%APPDIR%\Configurator.exe" (
		start "" "%APPDIR%\Configurator.exe"
		goto:CHOICE_MENU
	) else (
		call:BANNER
		echo [FAIL!] ViPER4Windows Configurator not found.
		>nul 2>&1 timeout /t 2
		goto:CHOICE_MENU
	)
)
if "%CMVAR%"=="3" (
	call:BANNER
	powershell -command "Restart-Service -Name Audiosrv -Confirm:$false"
	echo [DONE] Audio Service Restarted.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)

:BANNER
cls                                   
echo                 ______________
echo         ViPER4Windows Patcher \__ 
echo       \\     version %APPVAR%      /  \ 
echo        \\_____________________\__/
echo.&echo.
goto:eof
