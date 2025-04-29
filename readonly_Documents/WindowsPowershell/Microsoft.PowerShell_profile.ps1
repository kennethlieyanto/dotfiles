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

New-Alias -Name lzg -Value lazygit
New-Alias -Name lzd -Value lazydocker
New-Alias -Name dwr -Value Run-DotnetWatchrun
New-Alias -Name dr -Value Run-DotnetRun
New-Alias -Name o -Value start
New-Alias -Name ghd -Value Run-GhDash

Invoke-Expression (& { (zoxide init powershell | Out-String) })
