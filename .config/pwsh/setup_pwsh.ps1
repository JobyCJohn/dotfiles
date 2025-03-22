Write-Host "🔧 Starting PowerShell environment setup..."

$HOME_DIR = $env:USERPROFILE
$OMP_CONFIG_DIR = "$HOME_DIR\.oh-my-posh"
$OMP_THEME = "spaceship.omp.json"
$OMP_THEME_URL = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/spaceship.omp.json"

# Install PSReadLine (autocomplete, syntax highlighting, history search)
if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
    Write-Host "Installing PSReadLine module..."
    Install-Module -Name PSReadLine -Scope CurrentUser -Force
} else {
    Write-Host "✅ PSReadLine already installed."
}

# Install oh-my-posh CLI if missing
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installing oh-my-posh..."
    Invoke-Expression (Invoke-WebRequest https://ohmyposh.dev/install.ps1).Content
} else {
    Write-Host "✅ oh-my-posh already installed."
}

# 3. Download spaceship theme config for oh-my-posh if missing
if (-not (Test-Path $OMP_CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $OMP_CONFIG_DIR | Out-Null
}
$themePath = "$OMP_CONFIG_DIR\$OMP_THEME"
if (-not (Test-Path $themePath)) {
    Write-Host "📥 Downloading oh-my-posh theme: $OMP_THEME"
    Invoke-WebRequest -Uri $OMP_THEME_URL -OutFile $themePath
} else {
    Write-Host "✅ oh-my-posh theme already exists."
}

Write-Host "Reload your shell or run: . $PROFILE"

