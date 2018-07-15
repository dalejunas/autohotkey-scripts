 ; Script saves selected text into file on Ctrl+Shift+A combination click
 ; ^+A::
 ; clipboard := ""
 ; Send ^c
 ; Clipwait
 ; ToolTip % clipboard
 ; sleep 3000
 ; ToolTip
 ; FileAppend,
 ; (
 ; %clipboard%`n
 ; ), C:\DEV\data\autohotkey\interestinginfo.txt
 ; clipboard := ""
 ; Return


; a:="http://erichominick.com/music/I%20Talk%20to%20the%20Trees.mp3"
; fd1=%a_scriptdir%\CURL_Downloaded_TEST
; ifnotexist,%fd1%
;    filecreatedir,%fd1%
; SplitPath,a, name, dir, ext, name_no_ext, drive
;
; c:=fd1 . "\" . name              ;- song
; e:=fd1 . "\trace.txt"
; f:=fd1 . "\libcurl.txt"
; g:=fd1 . "\dumpheader.txt"
; cc:="curl -L -d/-F -o " . c " " . a  " --trace-ascii " . e " --libcurl " . f " -D " . g
;
; RunWait, %comspec% /k %cc%
; ifexist,%fd1%
;     run,%fd1%     ;- open folder
; return


 ; RunGetOutput(program, command) {
 ;     shell := ComObjCreate("WScript.Shell")
 ; 	exec := shell.Exec(program " /c " command)
 ; 	if (A_LastError)
 ; 		return A_LastError
 ; 	return exec.StdOut.ReadAll()
 ; }


req := ComObjCreate("Msxml2.XMLHTTP")
; Open a request with async enabled.
req.open("GET", "https://autohotkey.com/download/1.1/version.txt", true)
; Set our callback function [requires v1.1.17+].
req.onreadystatechange := Func("Ready")
; Send the request.  Ready() will be called when it's complete.
req.send()
/*
; If you're going to wait, there's no need for onreadystatechange.
; Setting async=true and waiting like this allows the script to remain
; responsive while the download is taking place, whereas async=false
; will make the script unresponsive.
while req.readyState != 4
    sleep 100
*/
#Persistent

Ready() {
    global req
    if (req.readyState != 4)  ; Not done yet.
        return
    if (req.status == 200) ; OK.
        MsgBox % "Latest AutoHotkey version: " req.responseText
    else
        MsgBox 16,, % "Status " req.status
    ExitApp
}


