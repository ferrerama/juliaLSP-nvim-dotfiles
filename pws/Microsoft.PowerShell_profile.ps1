function v {
   param([Parameter(ValueFromRemainingArguments = $true)] $args)
    $env:XDG_CONFIG_HOME = "C:\Users\USUARIO\ws\editor\config"
    $env:XDG_DATA_HOME = "C:\Users\USUARIO\ws\editor\config\plugins"
    & "C:\Users\USUARIO\ws\editor\bin\nvim.exe" -u "$env:XDG_CONFIG_HOME\init.lua" -- @args
}

#julia
$env:Path = "C:\Users\USUARIO\ws\julia\bin;" + $env:Path

#git
$env:Path = "C:\Users\USUARIO\ws\git\bin;" + $env:Path

#c++
$env:Path = "C:\Users\USUARIO\ws\cc\bin;" + $env:Path

function prompt {
    $user = "mf"
    $path = (Get-Location).Path
    $userHome = [Environment]::GetFolderPath("UserProfile")
    $blue  = "`e[34m"
    $reset = "`e[0m"
    $dir_name = Split-Path $path -Leaf
    $colored_path_part = ""
    if ($path -ne $userHome) {
        $colored_path_part = " $blue$dir_name$reset"
    }
    return "$user$colored_path_part " 
}
prompt | Out-Null

Set-PSReadLineOption -Colors @{
    Default   = '#808080'
    Command   = 'DarkYellow'
    Parameter = 'DarkGreen'
}

# function time { $cmd = $args -join ' '; Measure-Command { Invoke-Expression $cmd } }