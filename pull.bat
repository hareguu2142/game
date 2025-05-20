@echo off
setlocal

REM URL of the Git repository
title Pull or Clone game Repository
set "REPO_URL=https://github.com/hareguu2142/game.git"
set "REPO_DIR=game"

echo Target Repository URL: %REPO_URL%
echo Target Local Directory: %REPO_DIR%
echo.

if not exist "%REPO_DIR%\.git" (
    echo Repository not found in "%CD%\%REPO_DIR%".
    echo Cloning repository...
    git clone "%REPO_URL%" "%REPO_DIR%"
    if errorlevel 1 (
        echo Error: Failed to clone repository.
        pause
        exit /b 1
    )
    echo Repository cloned successfully into "%CD%\%REPO_DIR%".
) else (
    echo Repository found in "%CD%\%REPO_DIR%".
    echo Pulling latest changes...
    pushd "%REPO_DIR%"
    git pull origin main
    if errorlevel 1 (
        echo Error: Failed to pull changes.
        popd
        pause
        exit /b 1
    )
    popd
    echo Successfully pulled latest changes into "%CD%\%REPO_DIR%".
)

echo.
echo Update complete for %REPO_DIR%.
pause
endlocal