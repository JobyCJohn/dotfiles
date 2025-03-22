# https://github.com/craftzdog/dotfiles-public

# Set console encoding to UTF-8 for proper Unicode support
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Theme
Import-Module -Name Terminal-Icons
Import-Module -Name posh-git
oh-my-posh init pwsh --config $env:USERPROFILE\.oh-my-posh\spaceship.omp.json | Invoke-Expression

# Z location
Import-Module -Name Z

# PSReadLine
Import-Module -Name PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History

#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
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
$env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude ".git" --exclude "*.vdi"'
$env:FZF_PREVIEW_COMMAND = 'bat --style=grid,header,numbers,changes --wrap=never --color=always {} 2>$null || Get-Content {}'
$env:FZF_DEFAULT_OPTS = @"
--multi --cycle
--height=80% --layout=reverse --info=inline
--preview-window=right:50%:wrap
--preview='$env:FZF_PREVIEW_COMMAND'
--ansi
"@
$env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
$env:FZF_ALT_C_COMMAND = 'fd --type d --hidden --follow --exclude .git'

# Functions and Alias
function ll {
    eza --group-directories-first -al --header --hyperlink --git --icons --time-style=long-iso $args
}
function ls { eza --group-directories-first -a --icons $args }
#function tree { tre -a $args }

function nvim-min-config() {
    $env:NVIM_APPNAME = 'nvim-min'
    nvim.exe $args
}
function nvim-default-config() {
    $env:NVIM_APPNAME = 'nvim'
    nvim.exe $args
}

# Git
function git-root {
  $p = git rev-parse --show-toplevel
  if ($LASTEXITCODE -ne 0) {
    return ''
  }
  return $p
}
function set-gitroot {
    $root = git rev-parse --show-toplevel 2>$null
    if (-not $root) {
        Write-Error "Not in a Git repository!"
        return
    }
    Set-Location -Path $root
}
#function gs { git status }
#function ga { git add . }
#function gaa { git add --all }
#
#function gll { git log }
#function glo { git log --oneline }
#
#function gcm { git commit -m }
#function gca { git commit -a @args }
#
#function gp { git pull @args }
#function gP { git push @args }
#
#function gco { git checkout @args }
#function gcb { git checkout -b @args }

Set-Alias -Name grep -Value rg
Set-Alias -Name find -Value fd
Set-Alias -Name open -Value explorer
