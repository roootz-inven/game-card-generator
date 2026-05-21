@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM  Game Info Card Generator - GitHub Upload Script (Windows)
REM ============================================================
REM
REM  Before running:
REM   1. Log in to https://github.com
REM   2. Click + (top right) -^> New repository
REM   3. Enter a name (e.g. game-card-generator)
REM   4. Select Public
REM   5. DO NOT check "Add a README", ".gitignore", or "license"
REM      (the repo must be empty)
REM   6. Click "Create repository"
REM   7. Copy the HTTPS URL shown on the next page
REM      example: https://github.com/yourname/game-card-generator.git
REM
REM  Then double-click this file.
REM ============================================================

echo.
echo ========================================
echo  Game Info Card Generator - GitHub Upload
echo ========================================
echo.

REM --- Check git is installed ---
where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git is not installed.
    echo         Install from: https://git-scm.com/download/win
    echo         Then run this script again.
    pause
    exit /b 1
)

REM --- Move to script's folder ---
cd /d "%~dp0"
echo Working folder: %CD%
echo.

REM --- Already a git repo? ---
if exist ".git" (
    echo [INFO] This folder is already a git repository.
    echo        To push later changes, use:
    echo          git add .
    echo          git commit -m "your message"
    echo          git push
    pause
    exit /b 0
)

REM --- Ask for repository URL ---
echo Paste your GitHub repository URL.
echo Example: https://github.com/yourname/game-card-generator.git
echo.
set /p REPO_URL=URL:

if "%REPO_URL%"=="" (
    echo [ERROR] No URL entered. Exiting.
    pause
    exit /b 1
)

REM --- Check git user config ---
for /f "delims=" %%i in ('git config user.name 2^>nul') do set GITUSER=%%i
if "!GITUSER!"=="" (
    echo.
    set /p GITUSER=Enter your name for git (e.g. Kang Minwoo):
    git config --global user.name "!GITUSER!"
)

for /f "delims=" %%i in ('git config user.email 2^>nul') do set GITEMAIL=%%i
if "!GITEMAIL!"=="" (
    set /p GITEMAIL=Enter your email for git (e.g. kangzombie@gmail.com):
    git config --global user.email "!GITEMAIL!"
)

echo.
echo ---- Running git commands ----
echo.

git init
if errorlevel 1 ( echo [ERROR] git init failed & pause & exit /b 1 )

git branch -M main

git add .
if errorlevel 1 ( echo [ERROR] git add failed & pause & exit /b 1 )

git commit -m "Initial commit: Game Info Card Generator"
if errorlevel 1 ( echo [ERROR] git commit failed & pause & exit /b 1 )

git remote add origin %REPO_URL%
if errorlevel 1 ( echo [ERROR] adding remote failed & pause & exit /b 1 )

echo.
echo ---- Pushing to GitHub ----
echo  (If a browser login window opens, sign in to GitHub)
echo.
git push -u origin main
if errorlevel 1 (
    echo.
    echo [ERROR] Push failed. Please check:
    echo   - Is the repository URL correct?
    echo   - Did you authenticate with GitHub?
    echo   - Is the repository really empty?
    echo     (Having a README/license already in it will cause conflicts)
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Done! Check your repository on GitHub:
echo  %REPO_URL%
echo ========================================
echo.
pause
