#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


global TimeString := A_Now
; FormatTime, TimeString, 20050423220133, dddd MMMM d, yyyy hh:mm:ss tt
; MsgBox %TimeString%.

f1::

Loop, 11
    {
    global varRc := A_Index
    result := getHsNumAndGateAndJersey(varRc)
    FileAppend,`n, %A_ScriptDir%\scmpHorseCodeList_%TimeString%.csv


    for horseNum, details in result
        {
        gate := details.gate
        code := details.code
        rider := details.rider
        pace := details.pace
        ; MsgBox, Horse Number: %horseNum%`nGate: %gate%`nCode: %code%`nRider: %rider%`nPace: %pace%
        ; msgbox % horseNum "  " details.gate " " details.code " " details.rider " " details.pace
        ; msgbox,, line28, % horseNum "  " details.gate " " details.code " " details.rider " " details.pace
        
        if (gate >=1)
            {
            saveToCsv := ""
            saveToCsv .= varRc "," horseNum "," code "," pace "," caller "," gate "," rider
            ; Msgbox % saveToCsv
            FileAppend, %saveToCsv%`n, %A_ScriptDir%\scmpHorseCodeList_%TimeString%.csv
            }
        details.gate := 
        details.code := 
        details.rider := 
        details.pace := 
        gate := 
        code := 
        rider := 
        pace := 
        }
    msgbox,,, Rc %varRc% done,.5
    }

;---------------------------------------------------------------------------------------------------------------------

msgbox, Completed
exitApp
return

;======================================================================================================================================================================================

f2::

testurl01 := "https://script.google.com/macros/s/AKfycbzgDQM4WM6xJz1SYqE5TxDfwyekTVuymLPIcyeyLYU4iiJVjXsQwFBS3O4BilMqs3ELMA/exec"
testurl02 := "https://script.google.com/macros/s/AKfycbz6q_WDw6iiDJkpAuW11cvoF3Mi9FRxSm4BPlU5wm5T8FqxJ0psXPoy9i_u_65c8S8e/exec"
testurl03 := "https://script.google.com/macros/s/AKfycbzPDWKdbGpDJXeHo2frIub1gO7Zv7PzxKQYMilghNehljof3fJT-mAN2tCwndzIgOY1/exec"
testurl04 := "https://script.google.com/macros/s/AKfycbw0osWoyv0dU2R18HwInFPEjXZDBkLUwNiZKlrg58oXxv2DFAb5TsbOPQGd3-c9Nir6/exec"
testurl05 := "https://script.google.com/macros/s/AKfycbz8BC4MIx1eVI_QSXm8l2iFrv3lLiNqgviUG_wM4qaydTzueMq7vlFhNgTP3AlsxCsL/exec"
testurl06 := "https://script.google.com/macros/s/AKfycbw3rCBbar-nAMbe1JQJWkagZ6H_wHfQz9nTTWUu5xN_COiyoUIiNaIaYN6uqTbli89R/exec"
testurl07 := "https://script.google.com/macros/s/AKfycbwO8u5LjMuF71fHIJ53iOEly1wBO-EpvNXtBPpU9XgDGpEfJC5MPMvYnGzFAYlqJUHJXg/exec"
testurl08 := "https://script.google.com/macros/s/AKfycbxvzLIrGgMC0AtVOVaGY21MG3DEECbH0PdD8cfh1EMMyNzHEtP_uxUd_m-pYEaUvEDj9Q/exec"
testurl09 := "https://script.google.com/macros/s/AKfycbx2sce-54PXdAHOsb_k65N8uULuZY23xtJoIXo-Gpu8NL7d69ZBJXwF1Zc4NvS4EXA6/exec"
testurl010 := "https://script.google.com/macros/s/AKfycbyLOZeJKRxkhRtBLpvPgpvJ9V4wwznYfVoRZb6lje5x3SvcPkSxVtkqC0M1C-sGdMAgFg/exec"
testurl011 := "https://script.google.com/macros/s/AKfycbwFu2O_GOfQtj7oBjMsht3CuO1oZcOlBtsNKU7QcXxZWnUZOV-e4j9DDYRx_xJF3O4L/exec"


FileAppend, `n, %A_ScriptDir%\specialCodeVerified_%TimeString%.csv


loop, 11
{
a_count := A_index
urlCsv := "testurl0" . a_count

; msgbox,,, % urlCsv, 1
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", %urlCsv%, true)
whr.Send()
whr.WaitForResponse()
hseSpeedList := ""
hseSpeedList := whr.ResponseText
; msgbox, % hseSpeedList

Loop, parse, hseSpeedList, `n
    {
    RegExMatch(hseSpeedList, "(\d{1,2})`,(\w\d+)`,(\w+)", list_)
    StringReplace, hseSpeedList, hseSpeedList, %list_%
    list_x :=
    list_x .= list_ ",x"
    ; msgbox,,, %list_1%   %list_2%   %list_3%
    FileAppend, `n, %A_ScriptDir%\specialCodeVerified_%TimeString%.csv
    FileAppend, %a_count%`,%list_x%, %A_ScriptDir%\specialCodeVerified_%TimeString%.csv
    }

FileAppend, `n`n, %A_ScriptDir%\specialCodeVerified_%TimeString%.csv
}

msgbox, Completed
exitApp
return

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

getHsNumAndGateAndJersey(rcParam) {

    hcodeurl := "https://script.google.com/macros/s/AKfycbxzj789IiNAG83HB7BefvlR_--eo-7AxW8R_mFmEF0XAfFqdSaUj2nLCoNV8sjuNit0vQ/exec"

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", hcodeurl, true)
    whr.Send()
    whr.WaitForResponse()
    hseCodeList := ""
    hseCodeList := whr.ResponseText

    StringReplace, hseCodeList, hseCodeList, ",, all
    ; msgbox,,hseCodeList, % hseCodeList, 

    ; field4_hsCode := "D075"                                                                                                 ; testing
    ; RegExMatch(hseCodeList, "s)(" field4_hsCode ")\,(?P<pace>.*?])", field6_)                                               ; testing    
    ; StringReplace, field6_pace, field6_pace, ]                                                                              ; testing  
    ; msgbox,,pace, `n`nfield6_ : %field6_% `ncount : %A_index% `nfield4_hsCode : %field4_hsCode% `npace %field6_pace%,       ; testing


    horseNumAndGateAndJersey := {}

    url_get := "https://www.scmp.com/sport/racing/racecard/@"
    StringReplace, url_get, url_get, @ , %rcParam%

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("GET", url_get, false)
    http.Send()

    InOutData :=
    InOutData := http.ResponseText

    if (InOutData = "")
        {
        InOutData := URLDownloadToVar(url_get)
        }

RegExMatch(InOutData, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)

loop, 14
    {
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)            ;get hs numver
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)            ;get hs code
    StringReplace, data2, data2, % field4_,

    RegExMatch(data2, "s)<td align=""center"">(?P<gate>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)            ;get hs gate
    StringReplace, data2, data2, % field5_, 
    
    RegExMatch(data2, "s)<a href=""/sport/racing/stats/jockey/\d+/(?P<rider>.*?)<", field5_)            ;get hs rider
    ; msgbox, % field5_rider
    StringReplace, data2, data2, % field5_, 
    StringSplit, namefieldA_, field5_rider, "
    ; msgbox, % namefield1

    RegExMatch(hseCodeList, "s)(" field4_hsCode ")\,(?P<pace>.*?])", field6_)                                               
    StringReplace, field6_pace, field6_pace, ]  
    StringSplit, namefieldB_, field6_pace, `,
    ; msgbox,,pace, `n`nfield6_ : %field6_% `ncount : %A_index% `nfield4_hsCode : %field4_hsCode% `npace %namefieldB_1%,  

    if (field3_hsenum > 0)
        {
        horseNumAndGateAndJersey[field3_hsenum] := {"gate":field5_gate,"code":field4_hsCode,"rider":namefieldA_1,"pace":namefieldB_1}
        }        
    }

   

return horseNumAndGateAndJersey
}

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

alt & esc::reload