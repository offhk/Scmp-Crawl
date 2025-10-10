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
        
        saveToCsv := ""
        saveToCsv .= varRc "," horseNum "," code "," pace "," caller "," gate "," rider
        ; Msgbox % saveToCsv
        FileAppend, %saveToCsv%`n, %A_ScriptDir%\scmpHorseCodeList_%TimeString%.csv

        }
    }

;---------------------------------------------------------------------------------------------------------------------

msgbox, Completed
exitApp
return

;======================================================================================================================================================================================

f2::

testurl01 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1645195912&single=true&output=csv"
testurl02 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1400065573&single=true&output=csv"
testurl03 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=2078346578&single=true&output=csv"
testurl04 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=693120304&single=true&output=csv"
testurl05 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1918743492&single=true&output=csv"
testurl06 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=729273759&single=true&output=csv"
testurl07 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1190431245&single=true&output=csv"
testurl08 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=2119382615&single=true&output=csv"
testurl09 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1139690273&single=true&output=csv"
testurl010 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=112767216&single=true&output=csv"
testurl011 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1672319615&single=true&output=csv"


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

    hcodeurl := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=660322945&single=true&output=csv"

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", hcodeurl, true)
    whr.Send()
    whr.WaitForResponse()
    hseCodeList := ""
    hseCodeList := whr.ResponseText
    ; msgbox,,, % hseCodeList, 

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
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
    StringReplace, data2, data2, % field4_,

    RegExMatch(data2, "s)<td align=""center"">(?P<gate>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
    StringReplace, data2, data2, % field5_, 
    
    RegExMatch(data2, "s)<a href=""/sport/racing/stats/jockey/\d+/(?P<rider>.*?)<", field5_)
    ; msgbox, % field5_rider
    StringReplace, data2, data2, % field5_, 
    StringSplit, namefield, field5_rider, "
    ; msgbox, % namefield1

    RegExMatch(hseCodeList, "s)(" field4_hsCode ")\,(?P<pace>.*?)\s", field6_)
    ; msgbox,,pace, %pace_% `n%A_index% `n%field4_hsCode% `n%pace_2%,

    if (field3_hsenum > 0)
        {
        horseNumAndGateAndJersey[field3_hsenum] := {"gate":field5_gate,"code":field4_hsCode,"rider":namefield1,"pace":field6_pace}
        }        
    }
return horseNumAndGateAndJersey
}

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

alt & esc::reload