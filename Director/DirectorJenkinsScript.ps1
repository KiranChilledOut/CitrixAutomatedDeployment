$SrvPassword = ConvertTo-SecureString "$($ENV:Pass)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:User", $SrvPassword)

Write-Host "Trying to copy the files on Director"
if(!(Test-Path "\\$env:DirectorName\c$\temp\XD")){
    Copy-Item "\\sharepath\XD" "\\$env:DirectorName\c$\temp\XD" -Force -Verbose -Recurse
}
else{
Write-Host "\\$env:DirectorName\c$\temp\XD1912 path present" 
}
Write-Host "Trying to install Citrix Director on $($env:DirectorName)"

Invoke-command -computerName $env:DirectorName -scriptblock {& 'c:\temp\XD\x64\XenDesktop Setup\XenDesktopServerSetup.exe' /components DESKTOPDIRECTOR /configure_firewall /quiet /no_pending_reboot_check} -verbose -credential $Credential
