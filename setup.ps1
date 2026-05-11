# Setup script for Windows PowerShell to initialize all submodules after cloning

$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Setting up React-Native-decoder project" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Initialize and update all submodules
Write-Host "Initializing submodules..." -ForegroundColor Yellow
git submodule update --init --recursive

# Optional: pull latest from all submodules
Write-Host ""
Write-Host "Fetching latest submodule content..." -ForegroundColor Yellow
git submodule foreach git fetch origin

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "Setup complete! Submodules initialized." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Submodule status:" -ForegroundColor Yellow
git submodule status
