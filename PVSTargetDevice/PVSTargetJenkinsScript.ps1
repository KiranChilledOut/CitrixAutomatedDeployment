$SrvPassword = ConvertTo-SecureString "$($ENV:Pass)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:User", $SrvPassword)

Write-Host "Trying to copy the files to Target Device"
if((Test-Path "\\$env:MasterImageName\c$\temp\XD") -eq $false){
    Copy-Item "\\sharepath\PVS" "\\$env:MasterImageName\c$\temp\XD" -Force -Recurse
}
else{
Write-Host "\\$env:MasterImageName\c$\temp\XD path already present" 
}


##########################################################

if((Test-Path "\\$env:MasterImageName\c$\temp\XD") -eq $True){
write-host "Copied the files successfully"
write-host "1.Login to the Master Image"
write-host "2.Launch the file c:\temp\pvstargetdevice_3.bat"
write-host "3.Reboot Server once complete"

}