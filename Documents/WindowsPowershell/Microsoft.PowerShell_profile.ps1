$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"

function Run-DotnetWatchRun {
    dotnet watch run
}

function Run-DotnetRun {
    dotnet run
}

function Run-GitStatus {
    git status
}

function Edit-Hostfile {
    notepad c:\Windows\System32\Drivers\etc\hosts
}

function Run-GhDash {
    gh dash
}

function Search-History {
    <#
    .SYNOPSIS
    Search command history using fzf with most recent first, no duplicates, and editable selection
    
    .DESCRIPTION
    Uses fzf to search through PowerShell command history. Shows most recent commands first,
    removes duplicates, and allows editing the selected command before execution.
    
    .EXAMPLE
    Search-History
    shist  # if you set up the alias
    #>
    
    # Check if fzf is available
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
        Write-Error "fzf is not installed or not in PATH. Please install fzf first."
        return
    }
    
    # Get the PSReadLine history file path
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    
    if (-not (Test-Path $historyPath)) {
        Write-Error "History file not found at: $historyPath"
        return
    }
    
    # Read all history from file, remove duplicates, and sort by most recent
    $history = Get-Content $historyPath |
        Where-Object { $_.Trim() -ne "" } |  # Remove empty lines
        Select-Object -Unique |              # Remove duplicates
        Select-Object -Last 1000             # Limit to last 1000 unique commands for performance
    
    # Reverse array to show most recent first
    [Array]::Reverse($history)
    
    if ($history.Count -eq 0) {
        Write-Host "No command history found."
        return
    }
    
    # Use fzf to select a command
    $selectedCommand = $history | fzf --height=50% --reverse --border --prompt="History > " --preview-window=hidden
    
    if ([string]::IsNullOrEmpty($selectedCommand)) {
        return  # User cancelled selection
    }
    
    # Use ReadLine to allow editing before execution
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selectedCommand)
}

# Set up a convenient alias
Set-Alias -Name shist -Value Search-History

# Optional: Bind to Ctrl+R for familiar bash-like experience
# Add this to your PowerShell profile if desired
# Set-PSReadLineKeyHandler -Key Ctrl+r -Function HistorySearchBackward

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

New-Alias -Name lzg -Value lazygit
New-Alias -Name lzd -Value lazydocker
New-Alias -Name dwr -Value Run-DotnetWatchrun
New-Alias -Name dr -Value Run-DotnetRun
New-Alias -Name o -Value start
New-Alias -Name ghd -Value Run-GhDash
New-Alias -Name fh -Value Invoke-FuzzyHistory

Invoke-Expression (& { (zoxide init powershell | Out-String) })

