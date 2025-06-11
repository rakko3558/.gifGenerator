@echo off
setlocal enabledelayedexpansion

:: === Set target folder inside ./gifs/ ===
set "target=.\gifs\rain"

if not exist "%target%" (
    echo Folder not found: %target%
    pause
    exit /b
)

cd /d "%target%"

:: Initialize counter
set count=1
echo Starting renaming...

:: Step 1: Rename to tmp prefix to avoid name collision
for %%f in (*.jpg *.jpeg *.png *.gif *.bmp *.webp) do (
    set "ext=%%~xf"
    set "num=00!count!"
    set "num=!num:~-3!"
    ren "%%f" "tmp!num!!ext!"
    set /a count+=1
)

:: Store total count
set /a total=count-1

:: Step 2: Rename tmp files to frame prefix
set count=1
for %%f in (tmp*.jpg tmp*.jpeg tmp*.png tmp*.gif tmp*.bmp tmp*.webp) do (
    set "ext=%%~xf"
    set "num=00!count!"
    set "num=!num:~-2!"
    ren "%%f" "frame!num!!ext!"
    set "lastFrame=frame!num!!ext!"
    set /a count+=1
)

:: Step 3: Duplicate last frame as frame01 (for loop continuity)
if defined lastFrame (
    copy /Y "!lastFrame!" "frame01!ext!" >nul
)

echo.
echo Done: frame01 is a copy of the last frame for looping.
pause
