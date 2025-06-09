@echo off
setlocal enabledelayedexpansion

:: 初始化計數器
set count=1

:: === 第一階段：先全部改成 tmp 開頭，避免命名衝突 ===
for %%f in (*.jpg *.jpeg *.png *.gif *.bmp *.webp) do (
    set ext=%%~xf
    set num=00!count!
    set num=!num:~-3!
    ren "%%f" tmp!num!!ext!
    set /a count+=1
)

:: 記錄總數
set /a total=count-1

:: === 第二階段：從 tmp 開頭依序改為 frame 開頭 ===
set count=1
for %%f in (tmp*.jpg tmp*.jpeg tmp*.png tmp*.gif tmp*.bmp tmp*.webp) do (
    set ext=%%~xf
    set num=00!count!
    set num=!num:~-2!
    ren "%%f" frame!num!!ext!
    set lastFrame=frame!num!!ext!
    set /a count+=1
)

:: === 第三階段：複製最後一張為 frame01 覆蓋掉 ===
if defined lastFrame (
    copy /Y "!lastFrame!" frame01!ext! >nul
)

echo.
echo ✅ 完成重新命名，frame01 為最後一張的副本（用來循環）
pause
