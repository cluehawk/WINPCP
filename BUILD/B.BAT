@echo off

masm /l winobj.asm;
if errorlevel 1 goto fail

masm /l caller.asm;
if errorlevel 1 goto fail

link  caller.obj+winobj.obj, caller.exe, , ;
if errorlevel 1 goto fail

caller
if errorlevel 5 goto ok

echo TEST FAILED (expected ERRORLEVEL 5)
goto end

:ok
echo TEST OK (ERRORLEVEL 5)

goto end

:fail
echo BUILD FAILED

:end
