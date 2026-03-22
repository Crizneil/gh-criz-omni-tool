# CRIZ TOOLS Installer
# Professional Deployment Script for PISCES Workstation

Write-Host "--- CRIZ TOOLS INSTALLER ---" -ForegroundColor Green

# Check for Python
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[-] Python not found. Please install Python 3.10+." -ForegroundColor Red
    exit 1
}

Write-Host "[+] Python detected." -ForegroundColor Cyan

# Check for Git Repository
if (!(Test-Path ".git")) {
    Write-Host "[!] WARNING: You are NOT in a Git repository." -ForegroundColor Yellow
    Write-Host "[!] The Auto-Streak and Push tools will not work until you run 'git init' or move this script into a repository." -ForegroundColor Yellow
    $confirm = Read-Host "Do you want to continue anyway? (y/n)"
    if ($confirm -ne 'y') { exit 0 }
}
Write-Host "[*] Installing dependencies..." -ForegroundColor Yellow
python -m pip install PyGithub rich psutil python-dotenv pyperclip requests speedtest-cli pyautogui --quiet

if ($LASTEXITCODE -ne 0) {
    Write-Host "[-] Failed to install requirements." -ForegroundColor Red
    exit 1
}

Write-Host "[+] Dependencies installed." -ForegroundColor Cyan

# Always force download the absolute newest main.py update
Write-Host "[*] Syncing latest main.py core from GitHub..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Crizneil/gh-criz-omni-tool/main/main.py" -OutFile "main.py" -UseBasicParsing

Write-Host "[*] Launching CRIZ TOOLS..." -ForegroundColor Green
python main.py
