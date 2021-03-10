(Get-Content "C:\PulseAudio\etc\pulse\default.pa") -replace "load-module module-native-protocol-tcp auth-ip-acl\b.*", "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1" | Set-Content "C:\PulseAudio\etc\pulse\default.pa"
wscript .\runHidden.vbs "C:\PulseAudio\bin\pulseaudio.exe"
wscript .\runHidden.vbs ".\vim-caps.ahk"
wscript .\runHidden.vbs "C:\Program Files\VcXsrv\vcxsrv.exe" :0 -screen 0 @1 -nodecoration -wgl -dpi 72 -xkbmodel pc105 -xkblayout us -keyhook -ac
wscript .\runHidden.vbs Ubuntu run "cd ~ && source ~/.zshrc && i3" 
