#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

f1::

hcodeurl := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=660322945&single=true&output=csv"

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", hcodeurl, true)
whr.Send()
whr.WaitForResponse()
hseCodeList := ""
hseCodeList := whr.ResponseText

; MsgBox, , , %hseCodeList%, 
; return

;---------------------------------------------------------------------------------------------------------------------

loop, 11
    {
    rc_ := A_Index
    raceCardUrl := "https://www.scmp.com/sport/racing/racecard/@"
    StringReplace, raceCardUrl, raceCardUrl, @, %rc_%
    ; MsgBox,,, %raceCardUrl%, 2

    outputFile := A_Temp "\horse_info.html"
    RunWait, %ComSpec% /c curl -o "%outputFile%" "%raceCardUrl%", , Hide
    URLDownloadToFile, %url%, %outputFile%

    outputContent := 
    FileRead, outputContent, %outputFile%
    ; FileAppend, %outputContent%, %A_ScriptDir%\outputContentView.txt ; save content for viewing

    FileAppend, `n, %A_ScriptDir%\horseCodeList.csv

    loop,14
        { 
        found1 = ""
        ; matchFound := ""
        ; Output_1 := ""
        ; Output_2 := ""

        RegExMatch(outputContent, "s)https://api\.racing\.scmp\.com/StatImg/Photo/JocColor/svg/([A-Z]\d\d\d)\.svg", found)
        ; msgbox,,found, %found%,0.5
        ; msgbox,,found1, found := %found%`n`n%rc_%,%A_index%, `n`nfound1 :=  %found1%
        if found1 != ""
            {
            StringReplace, outputContent, outputContent, %found%

            matchFound := ""
            Output_1 := ""
            Output_2 := ""
            RegExMatch(hseCodeList, "s)(" found1 ").*?\s", matchFound)
            ; msgbox,,matchFound, _%A_index% `n_%found1% `n_%matchFound%,

            StringSplit, Output_, matchFound, `,
            ; msgbox,,, %Output_1%`n%Output_2%

            ; msgbox,,found1, found : %found% `n`n%rc_%,%A_index%,%found1% `n`nMatch Found : %matchFound% `n`n%Output_1%`n%Output_2%

            if (Output_2 != "")
                {
                ; msgbox,,, %matchFound%,.5
                FileAppend, %rc_%`,%A_index%`,%matchFound%, %A_ScriptDir%\horseCodeList.csv
                }
            else if (Output_2 = "")
                {
                ; msgbox,,, nodata  %rc_%`,%A_index%`,%found1%, .5
                FileAppend, %rc_%`,%A_index%`,%found1%`n, %A_ScriptDir%\horseCodeList.csv
                }
            }
        Else
            {
            msgbox, done    
            }
        }
    }

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


FileAppend, `n, %A_ScriptDir%\horseCodeCsvDone.csv

loop, 11
{
urlCsv := "testurl0" . A_index

; msgbox,,, % urlCsv, 1
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", %urlCsv%, true)
whr.Send()
whr.WaitForResponse()
hseSpeedList := ""
hseSpeedList := whr.ResponseText

; msgbox, % hseSpeedList
FileAppend, %hseSpeedList%, %A_ScriptDir%\horseCodeCsvDone.csv
FileAppend, `n`n, %A_ScriptDir%\horseCodeCsvDone.csv
}

msgbox, Completed
exitApp
return

;======================================================================================================================================================================================

esc::reload