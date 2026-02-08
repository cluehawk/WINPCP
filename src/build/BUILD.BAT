@echo off

rem ------------------------------------------------------------
rem DOSBox / COMMAND.COM safe build script for WINPCP
rem Assumes project is mounted as E:\WINPCP
rem ------------------------------------------------------------

set PROJ=E:\SRC
set DRV=E:\SRC\DRV

rem Ensure we can see sources
if not exist %DRV%\WINPCP.ASM goto NOFILES

cd %DRV%

echo Assembling WINPCP.ASM...dir

masm /l WINPCP.ASM;

if errorlevel 1 goto FAIL

echo Linking WINPCP...
link /NOD /NOE @WINPCP.LNK 

if errorlevel 1 goto FAIL

echo.
echo BUILD OK.
goto END

:NOFILES
echo ERROR: Can't find %DRV%\WINPCP.ASM
goto END

:FAIL
echo.
echo BUILD FAILED.
cd ..\build
goto END

:END
