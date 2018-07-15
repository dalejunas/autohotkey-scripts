 ; Script saves selected text into file on Ctrl+Shift+A combination click
^+A::
clipboard := ""
Send ^c
Clipwait
ToolTip % clipboard
sleep 3000
ToolTip
FileAppend, 
(
%clipboard%`n
), C:\DEV\data\autohotkey\interestinginfo.txt
clipboard := ""
Return
