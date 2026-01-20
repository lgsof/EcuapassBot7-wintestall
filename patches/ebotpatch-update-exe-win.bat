REM ===============================================================
REM Script for patching the original exe and create the new exe
REM ===============================================================

@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ===============================================================
REM Paths
set "BASE_DIR=%~dp0"
set "LOG_FILE=%BASE_DIR%patches.log"
set "ORIGINAL_EXE=%BASE_DIR%..\ecuapass_commander\ecuapass_commander_original.exe"
set "CURRENT_EXE=%BASE_DIR%..\ecuapass_commander\ecuapass_commander.exe"

cd /d "%BASE_DIR%"

REM ===============================================================
REM Ensure log exists
if not exist "%LOG_FILE%" type nul > "%LOG_FILE%"

REM ===============================================================
REM Find patch file (expect exactly one)
set "PATCH_FILE="
for %%F in (patch_*.vcdiff) do (
    set "PATCH_FILE=%%F"
    goto :found_patch
)

echo !!! ERROR: No patch file found (patch_*.vcdiff)
goto :end

:found_patch

REM ===============================================================
REM Extract patch version: patch_XXX.vcdiff → XXX
for /f "tokens=2 delims=_" %%A in ("%PATCH_FILE%") do (
    for /f "tokens=1 delims=." %%B in ("%%A") do set "PATCH_VERSION=%%B"
)

if not defined PATCH_VERSION (
    echo !!! ERROR: Cannot parse patch version from %PATCH_FILE%
    goto :end
)

REM ===============================================================
REM Check if patch already applied
findstr /x /c:"%PATCH_VERSION%" "%LOG_FILE%" >nul && (
    echo --- Patch %PATCH_VERSION% already applied
    goto :end
)

REM ===============================================================
REM Apply patch
echo Applying patch %PATCH_VERSION%...
xdelta3.exe -f -d ^
    -s "%ORIGINAL_EXE%" ^
    "%PATCH_FILE%" ^
    "%CURRENT_EXE%"

if errorlevel 1 (
    echo !!! ERROR: Patch failed
    goto :end
)

REM ===============================================================
REM Cleanup
del /q "%PATCH_FILE%"

REM ===============================================================
REM Update log (prepend newest)
(
    echo %PATCH_VERSION%
    type "%LOG_FILE%"
) > "%LOG_FILE%.tmp"

move /y "%LOG_FILE%.tmp" "%LOG_FILE%" >nul

echo +++ Patch %PATCH_VERSION% applied successfully

:end
endlocal

