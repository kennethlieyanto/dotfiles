New-Alias -Name lzg -Value lazygit
New-Alias -Name lzd -Value lazydocker
New-Alias -Name dwr -Value Run-DotnetWatchrun
New-Alias -Name dr -Value Run-DotnetRun
New-Alias -Name o -Value start
New-Alias -Name ghd -Value Run-GhDash
New-Alias -Name fh -Value Invoke-FuzzyHistory

Invoke-Expression (& { (zoxide init powershell | Out-String) })

