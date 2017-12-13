:: ViPER4Windows Patcher.
:: Version: 1.0
:: Written by Metaspook
:: License: <http://opensource.org/licenses/MIT>
:: Copyright (c) 2017 Metaspook.
:: 
@echo off

::
:: REQUESTING ADMINISTRATIVE PRIVILEGES
::
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
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

mode con: cols=50 lines=24
cls
echo.
echo     ________________________
echo      ViPER4Windows Patcher  \\      __
echo           \  Written by Metaspook  /  \
echo            \\______________________\__/
echo.

>nul 2>&1 reg delete "HKCR\AudioEngine\AudioProcessingObjects" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "FriendlyName" /t REG_SZ /d "ViPER4Windows" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "Copyright" /t REG_SZ /d "Copyright (C) 2013, vipercn.com" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MajorVersion" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinorVersion" /t REG_DWORD /d "0" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "Flags" /t REG_DWORD /d "13" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinInputConnections" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxInputConnections" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MinOutputConnections" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxOutputConnections" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "MaxInstances" /t REG_DWORD /d "4294967295" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "NumAPOInterfaces" /t REG_DWORD /d "1" /f
>nul 2>&1 reg add "HKCR\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}" /v "APOInterface0" /t REG_SZ /d "{FD7F2B29-24D0-4B5C-B177-592C39F9CA10}" /f
echo   [DONE] Registry entry fixes.
echo          Please reboot your PC.
echo.
echo   Press any key to Exit.
pause >nul
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\temp\compatmodel\iconsext.exe" /t REG_SZ /d "WINXPSP3 RUNASADMIN" /f
::[-HKEY_CLASSES_ROOT\AudioEngine\AudioProcessingObjects]

::[HKEY_CLASSES_ROOT\AudioEngine\AudioProcessingObjects\{DA2FB532-3014-4B93-AD05-21B2C620F9C2}]
::"FriendlyName"="ViPER4Windows"
::"Copyright"="Copyright (C) 2013, vipercn.com"
::"MajorVersion"=dword:00000001
::"MinorVersion"=dword:00000000
::"Flags"=dword:0000000d
::"MinInputConnections"=dword:00000001
::"MaxInputConnections"=dword:00000001
::"MinOutputConnections"=dword:00000001
::"MaxOutputConnections"=dword:00000001
::"MaxInstances"=dword:ffffffff
::"NumAPOInterfaces"=dword:00000001
::"APOInterface0"="{FD7F2B29-24D0-4B5C-B177-592C39F9CA10}"

