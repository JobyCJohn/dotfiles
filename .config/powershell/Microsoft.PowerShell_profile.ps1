# https://github.com/craftzdog/dotfiles-public

# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Remove default alias
#Get-Alias | Where-Object { $_.Options -NE "Constant" } | Remove-Alias -Force

# Theme
Import-Module -Name Terminal-Icons
Import-Module -Name posh-git
oh-my-posh init pwsh --config C:\users\ing10284\.config\.spaceship.omp.json | Invoke-Expression

# Z location
Import-Module -Name Z

# PSReadLine
Import-Module -Name PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+u -Function DeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+y -Function Yank
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'

# Functions and Alias
function ll {
    eza --group-directories-first -al --header --hyperlink --git --icons --time-style=long-iso $args
}

function ls { eza --group-directories-first -a --icons $args }

function tree { tre -a $args }

function Git-Root {
  $p = git rev-parse --show-toplevel
  if ($LASTEXITCODE -ne 0) {
    return ''
  }
  return $p
}
function Set-GitRoot {
    $root = git rev-parse --show-toplevel 2>$null
    if (-not $root) {
        Write-Error "Not in a Git repository!"
        return
    }
    Set-Location -Path $root
}
Set-Alias grep rg
Set-Alias find fd
