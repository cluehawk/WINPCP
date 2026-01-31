@echo off
setlocal

set MASM=masm
set LINK=link

REM Go to the driver build directory
cd /d %~dp0\..\drv

REM Assemble core driver module
%MASM% winpcp.asm;
if errorlevel 1 goto fail

REM Assemble common export stubs (lifecycle, BitBlt stubs, cursor stubs, etc.)
%MASM% ..\stubs.asm;
if errorlevel 1 goto fail

REM Assemble text modules
%MASM% ..\text\text_entry.asm;
if errorlevel 1 goto fail

%MASM% ..\text\text_core.asm;
if errorlevel 1 goto fail

REM Link using response file
%LINK% @winpcp.lnk
if errorlevel 1 goto fail

echo Build OK: ..\..\bin\WINPCP.DRV
goto :eof

:fail
echo Build FAILED
exit /b 1