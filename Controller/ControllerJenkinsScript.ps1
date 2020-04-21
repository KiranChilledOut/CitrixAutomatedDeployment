$SrvPassword = ConvertTo-SecureString "$($ENV:Pass)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:User", $SrvPassword)

Write-Host "Trying to copy the files to Controller"
if(!(Test-Path "\\$env:ControllerName\c$\temp\XD")){
    Copy-Item "\\sharepath\XD" "\\$env:ControllerName\c$\temp\XD" -Force -Verbose -Recurse
}
else{
Write-Host "\\$env:ControllerName\c$\temp\XD1912 path present" 
}
Write-Host "Trying to install Delivery Controller on $($env:ControllerName)"

Invoke-command -computerName $env:ControllerName -scriptblock {& 'c:\temp\XD\x64\XenDesktop Setup\XenDesktopServerSetup.exe' /components controller /configure_firewall /disableexperiencemetrics /quiet /no_pending_reboot_check} -verbose -credential $Credential
