#Copy the 3 .bat files to the \\SharePath\PVS
$SrvPassword = ConvertTo-SecureString "$($ENV:Pass)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:User", $SrvPassword)

Write-Host "Trying to copy the files to PVS Server"
if((Test-Path "\\$env:PVSServerName\c$\temp\XD") -eq $false){
    Copy-Item "\\Sharepath\XD\PVS" "\\$env:PVSServerName\c$\temp\XD" -Force -Verbose -Recurse
}
else{
Write-Host "\\$env:PVSServerName\c$\temp\XD path already present" 
}

Invoke-command -computerName $env:PVSServerName -scriptblock {write-host "Installing PVS .net on $($Env:ComputerName)";c:\Temp\XD\pvsdependencies.bat} -verbose -credential $Credential 
write-host "Sleeping for 200seconds"
start-sleep 200
restart-computer -computername $env:PVSServerName -Force -Wait

Invoke-command -computerName $env:PVSServerName -scriptblock {write-host "Installing PVS Console on $($Env:ComputerName)";c:\Temp\XD\pvsconsole.bat} -verbose -credential $Credential 

write-host "Sleeping for 200seconds"
start-sleep 200
restart-computer -computername $env:PVSServerName -Force -Wait

Invoke-command -computerName $env:PVSServerName -scriptblock {write-host "Installing PVS Server on $($Env:ComputerName)";c:\Temp\XD\pvsserver.bat} -verbose -credential $Credential 

write-host "Sleeping for 500seconds"
start-sleep 200
restart-computer -computername $env:PVSServerName -Force -Wait
