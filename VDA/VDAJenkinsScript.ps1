$SrvPassword = ConvertTo-SecureString "$($ENV:Pass)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:User", $SrvPassword)

Write-Host "Trying to copy the files to VDA machine"
if(!(Test-Path "\\$env:VDAName\c$\temp\XD")){
    Copy-Item "\\sharepath\xd" "\\$env:VDAName\c$\temp\XD" -Force -Verbose -Recurse
}
else{
Write-Host "$env:VDAName\c$\temp\XD path present" 
}

Write-Host "Trying to install VDA on $($env:VDAName)"

Invoke-command -computerName $env:VDAName -scriptblock {
write-host "Controller=$($args[0]) ,Port=$($args[1])"
get-service spooler,mpssvc |Set-Service -StartupType Automatic -Status Running -Verbose
& 'c:\Temp\XD\x64\XenDesktop Setup\XenDesktopVDASetup.exe'  /Components vda /controllers $($args[0]) /PORTNUMBER $($args[1]) /Optimize /logpath "c:\temp" /ENABLE_REMOTE_ASSISTANCE /ENABLE_HDX_UDP_PORTS /ENABLE_FRAMEHAWK_PORT /ENABLE_REAL_TIME_TRANSPORT /ENABLE_HDX_PORTS /ENABLE_HDX_UDP_PORTS /Quiet /Passive
} -argumentlist $env:ControllerNames,$env:VDAPort

