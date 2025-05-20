@echo off
setlocal
REM ========================================================
REM upload_game.bat
REM Automate adding, committing, and pushing to main branch
REM for the 'game' repository.
REM IMPORTANT: This script should be placed in the root
REM            of your 'game' local repository.
REM ========================================================
title Upload changes for game Repository

REM Change to the directory of this script (i.e. your repo root)
cd /d %~dp0

REM Check if it's a git repository
if not exist ".git" (
    echo ERROR: This script must be run from the root of the 'game' git repository.
    echo Current directory: %CD%
    echo '.git' folder not found here.
    pause
    exit /b 1
)

REM Stage all changes
echo Staging all changes for 'game' repository...
git add .

REM Prompt for a commit message
set /p COMMIT_MSG="Enter commit message for 'game' (leave blank for 'Auto-update game'): "
if "%COMMIT_MSG%"=="" (
    set "COMMIT_MSG=Auto-update game"
)

REM Commit
echo Committing with message: "%COMMIT_MSG%"
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    if "%ERRORLEVEL%"=="1" (
        REM git commit returns 1 if there's nothing to commit OR if there's an actual error
        REM We can't easily distinguish "nothing to commit" from other errors here without parsing output.
        REM For now, we'll just inform the user. A push might still be attempted or might be for other reasons.
        echo.
        echo NOTE: Commit command returned with errorlevel 1.
        echo This might mean there are no changes to commit, or an error occurred.
        echo Continuing to attempt push...
        echo.
    )
)


REM Push to main branch on origin
echo Pushing to origin/main for 'game' repository...
git push origin main

REM Check for errors
if errorlevel 1 (
    echo.
    echo ERROR: Something went wrong during push to 'game' repository.
    echo Possible reasons:
    echo   - No internet connection.
    echo   - Repository URL or permissions issue (check GitHub).
    echo   - Conflicts that need to be resolved manually.
    echo   - No new commits to push (if commit step found nothing to commit).
    pause
    exit /b 1
)

echo.
echo ✅ Successfully pushed to main for 'game' repository!
pause
endlocal