#IfWinActive, ahk_class Xming
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class mintty
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class XLaunch
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class xlaunch
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class "Xming :0.0"
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_exe "Xming.exe"
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class xming
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_exe "XLaunch.exe"
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class cygwin/x
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive
#IfWinActive, ahk_class VcXsrv/x
    Capslock::ESC
    +Enter::Send {Raw}^[0M
#IfWinActive

