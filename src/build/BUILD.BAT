@echo off
setlocal

REM Adjust these paths to your DDK toolchain layout
set MASM=masm
set LINK=link

cd /d %~dp0\..\drv

%MASM% winpcp.asm;
if errorlevel 1 goto fail

%LINK% winpcp.obj, ..\..\bin\WINPCP.DRV, , , WINPCP.DEF
if errorlevel 1 goto fail

echo Build OK: bin\WINPCP.DRV
goto :eof

:fail
echo Build FAILED
exit /b 1
