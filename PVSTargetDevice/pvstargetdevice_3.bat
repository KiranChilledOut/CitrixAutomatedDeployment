ECHO "Installing Target Device"
taskkill /IM "StatusTray.exe" /F
"c:\temp\XD\Device\PVS_Device_x64.exe" /S /v/qn" ALLUSERS=TRUE REBOOT=SUPPRESS /l* c:\Temp\CitrixPVSDeviceTarget.log"

