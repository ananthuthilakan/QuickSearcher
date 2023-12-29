;@Ahk2Exe-SetName       	VlcNotesQuickSearcher.exe
;@Ahk2Exe-SetVersion    	0.1.4.0 	
;@Ahk2Exe-SetDescription  	VlcNotesQuickSearcher.App
;@Ahk2Exe-SetCopyright    	discretecourage#0179
;@Ahk2Exe-SetCompanyName  	discretecourage#0179
;@Ahk2Exe-SetOrigFilename 	VlcNotesQuickSearcher.App
;@Ahk2Exe-SetMainIcon     	search.ico

;=============== CURRENT VERSION ==================================

Current_version:="v0.1.4.0"  ; In github always create new release tag with same name

;==================================================================

Changelog =  
(
[ v0.1.3.0 ] ========================================

- Minor bug fix
- Added Random image downloader
- adjusted the position of browser popup

[ v0.1.4.0 ] ========================================

- added Left ALT + G / T / I / A / B hotkeys instead of clicking on the buttons
- Error fix and minor bug fixes 

==================================================================
) 

#SingleInstance, Force
#NoEnv
#MaxThreadsBuffer on
#WarnContinuableException OFF
SetTitleMatchMode, 2
SetBatchLines -1
CoordMode,Pixel,Screen
CoordMode,Mouse,Screen
CoordMode, Tooltip, screen
#MaxHotkeysPerInterval 99999999
#HotkeyInterval 99999999
#KeyHistory 0
ListLines Off
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, 0
SendMode Input


#Include, <AppFactory>
#Include, <SettingsGUI1>
#Include, <ImageButton>
#Include, <Vis2Sub>
#Include, <GoogleTranslate>
#Include, <ImagePut>




global QuickGUIID
global DarkModeStyle :=[ [3, 0xFF565656, 0xFF000000 , 0xFFA1A1A1, 5, 0xFF000000 , 0xFF000000, 1]
					  , [2,  0xFF1C1C1C, 0xFF1C1C1C , 0xFFA1A1A1, 5, 0xFF000000 , 0x80E6E6E6, -1]
                      , [2, 0xFF1C1C1C, 0xFF1C1C1C , 0xFFA1A1A1, 5, 0xFF000000 , 0xFF000000, 1]
                      , [3, 0xFF000000, 0xFF3D3D3D , 0xffA1A1A1, 8, 0xFF000000 , 0xFF000000, 3] ]



global QS_Var_Latest_var

OnMessage( 0x200, "WM_MOUSEMOVE" )



GuiButtons:=["G","W","T","I","Ai","B"]



Menu,Tray, NoStandard
Menu, Tray, Add,  Show, lbl_Show_Quick_Searcher
Menu, Tray, Add,  Settings, SettingShow
Menu, Tray, Add,  Restart, Reloadlbl
Menu, Tray, Add,  close, Terminatelbl


Updatechecker=
(
; #Persistent
#NoTrayIcon
#SingleInstance, Force
#WarnContinuableException OFF
; #include <cJSON>
AhkExe := AhkExported()  ; ahkExe.AhkGetVar.variable

repoOwner := "ananthuthilakan"
repoName := "QuickSearcher"

try
{
url := "https://api.github.com/repos/" repoOwner "/" repoName "/releases/latest"
WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttpReq.Open("GET", url)
WinHttpReq.Send()
data:=JsonToAHK(WinHttpReq.ResponseText)

Current_version:=ahkExe.AhkGetVar.Current_version

latest_version := StrSplit(data["html_url"],"/")[8]

}



if (Current_version!=latest_version) && (latest_version)
    {
MsgBox 0x40044, New Update Available  `%repoName`% , Your current version   : `%Current_version`% ``nNew version available   : `%latest_version`%``n``nDo you want to update `%repoName`% ?

IfMsgBox Yes, {
    Try 
    Run, https://ananthuthilakan.com/quicksearcher-best-multifunctional-quick-searcher-to-get-what-you-need-from-internet-without-breaking-the-flow-of-note-taking/

} Else IfMsgBox No, {

}
    }
ExitApp

AhkExported(){
  static init,functions
  If !init{
    init:=Object(),functions:="ahkFunction:s==sssssssssss|ahkPostFunction:s==sssssssssss|ahkassign:ui==ss|ahkExecuteLine:t==tuiui|ahkFindFunc:t==s|ahkFindLabel:t==s|ahkgetvar:s==sui|ahkLabel:ui==sui|ahkPause:i==s"
    If (DllCall((exe:=!A_AhkPath?A_ScriptFullPath:A_AhkPath) "\ahkgetvar","Str","A_AhkPath","UInt",0,"CDecl Str"))
      functions.="|addFile:t==si|addScript:t==si|ahkExec:ui==s"
    Loop,Parse,functions,|
		{v:=StrSplit(A_LoopField,":"),init[v.1]:=DynaCall(exe "\" v.1,v.2)
		If (v.1="ahkFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"s==stttttttttt")
		else if (v.1="ahkPostFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"i==stttttttttt")
		}
  }
  return init
}


JsonToAHK(json, rec := false) {
    static doc := ComObjCreate("htmlfile")
          , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
          , JS := doc.parentWindow
    if !rec
       obj := `%A_ThisFunc`%(JS.eval("(" . json . ")"), true)
    else if !IsObject(json)
       obj := json
    else if JS.Object.prototype.toString.call(json) == "[object Array]" {
       obj := []
       Loop `% json.length
          obj.Push( `%A_ThisFunc`%(json[A_Index - 1], true) )
    }
    else {
       obj := {}
       keys := JS.Object.keys(json)
       Loop `% keys.length {
          k := keys[A_Index - 1]
          obj[k] := `%A_ThisFunc`%(json[k], true)
       }
    }
    Return obj
 }
;  return

)

dll:=AhkThread(Updatechecker)








FileCreateDir, %A_MyDocuments%\QuickSercher\
FileCreateDir, %A_MyDocuments%\QuickSercher\assets\
SetWorkingDir, %A_MyDocuments%\QuickSercher\



Global Credits := "Credits : `n evilC - AppFactory  `n iseahound - ImagePut `n just me - Imagebutton `n Geek - cJSON `n teadrinker - Google translate"
;[Settings ] ==================================================================================================

Global HotkeyNames:=["Show_Quick_Searcher","Quick_Google_Search","Quick_Bing_Search","Wiki_Grab_1st_paragraph","Google_tranlsate","Search_for_image_put_to_clipboard","Ask_ChatGPT","Exit"]

; Global Modules:=["Basic_Settings","Wiki","Translate","Image_Downloader","Chat_GPT"]

Global UserVariables:= {"b":{"Dark_Mode":1
                            ,"Reduce_Flicker":1
                            ,"Hide_TaskBar_icon":0
                            ,"Show_Dark_Mode_Button_on_UI":1
                            ,"Show_Overlay_Notification":1
                            ,"Start_On_windows_Start_Up":0
                            ,"Dont_show_start_up_message":0}
                        ,"p":{"ChatGPT_API_KEY":"null"}
                        ,"n":{"ChatGPT_max_tokens":200
                            ,"Image_downloader_default_image_width":500}
                        ,"t":{"Google_translate_Language_code":"en"}}



;

FileInstall, assets\skbfklsfkionu_1.png , %A_WorkingDir%\assets\skbfklsfkionu_1.png , 1
FileInstall, assets\skbfklsfkionu_2.png , %A_WorkingDir%\assets\skbfklsfkionu_2.png , 1
FileInstall, assets\skbfklsfkionu_3.png , %A_WorkingDir%\assets\skbfklsfkionu_3.png , 1
FileInstall, assets\skbfklsfkionu_4.png , %A_WorkingDir%\assets\skbfklsfkionu_4.png , 1
FileInstall, assets\skbfklsfkionu_5.png , %A_WorkingDir%\assets\skbfklsfkionu_5.png , 1
FileInstall, assets\skbfklsfkionu_6.png , %A_WorkingDir%\assets\skbfklsfkionu_6.png , 1
FileInstall, assets\skbfklsfkionu_7.png , %A_WorkingDir%\assets\skbfklsfkionu_7.png , 1
FileInstall, assets\skbfklsfkionu_8.png , %A_WorkingDir%\assets\skbfklsfkionu_8.png , 1
FileInstall, assets\skbfklsfkionu_9.png , %A_WorkingDir%\assets\skbfklsfkionu_9.png , 1
FileInstall, assets\skbfklsfkionu_10.png , %A_WorkingDir%\assets\skbfklsfkionu_10.png , 1


settingfile:=RegExReplace(A_ScriptName, ".ahk|.exe", ".ini")                                         
FileInstall, QuickSearcher.ini, %settingfile%, 0

; loop, 10
; {
;     Base64ImageDec(Base64ImageData_%A_Index%, "assets\skbfklsfkionu_" . A_index . ".png")
;     ; pBitmap := Gdip_BitmapFromBase64(Base64ImageData_%A_Index%)
;     ; skbfklsfkionu_%A_index% := Gdip_CreateHBITMAPFromBitmap(pBitmap)
; }

; Global UserVariables:= {"Basic_Settings"   :{"b":{"Dark_Mode":0,"Reduce_Flicker":1,"Hide_TaskBar_icon":0,"Show_Dark_Mode_Button_on_UI":0,"Show_Overlay_Notification":0},"p":{},"n":{}}
;                         ,"Wiki"            :{"b":{},"n":{},"p":{},"t":{}} 
;                         ,"Translate"       :{"b":{},"n":{},"p":{},"t":{}}
;                         ,"Image_Downloader":{"b":{},"n":{"Image_downloader_default_image_width":500},"p":{},"t":{}}
;                         ,"Chat_GPT"        :{"b":{},"n":{"ChatGPT_max_tokens":200},"p":{"ChatGPT_API_KEY":"null"},"t":{}}}                                                    
    
                        
; ===============================================================================================================


SettingsGUI(HotkeyNames,"QSettingsGUI",0,1,1,1,Changelog)
Gui,QSettingsGUI: Tab, 1
; Gui,SettingsGUI: Margin , 75
Gui,QSettingsGUI: Add, Button, xm y85 w40 h40 +Center +0x200  BackgroundTrans , G
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick google Seach
Gui,QSettingsGUI: Add, Button, xm y+5 w40 h40 +Center +0x200  BackgroundTrans , W
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick Grab 1st Paragraph of wiki
Gui,QSettingsGUI: Add, Button, xm y+5 w40 h40 +Center +0x200  BackgroundTrans , T
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick google Translate ( https://cloud.google.com/translate/docs/languages )
Gui,QSettingsGUI: Add, Button, xm y+5 w40 h40 +Center +0x200  BackgroundTrans , I
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick Random image Seach and put into clipboard
Gui,QSettingsGUI: Add, Button, xm y+5 w40 h40 +Center +0x200  BackgroundTrans , Ai
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick Completion / ask Question to ChatGPT
Gui,QSettingsGUI: Add, Button, xm y+5 w40 h40 +Center +0x200  BackgroundTrans , B
Gui,QSettingsGUI: Add, Progress, x+10 yp w804 h40 BackgroundBABABA         
Gui,QSettingsGUI: Add, Text, xp+15 yp w804 h40  +0x200  BackgroundTrans, Quick Bing Search / Chat to Bing ChatGPT 4


; Gui,SettingsGUI: Margin , 75

sleep, 100




FontScaling := Round(96/A_ScreenDPI*10) + 5
FontLarge := FontScaling + 10

Gui,QuickGUI: Font, s%FontScaling%  q5, Arial
Gui,QuickGUI: +HwndQuickGUIID
Gui,QuickGUI: +AlwaysOnTop  -DPIScale -Caption  +MinSize480x150 +MaxSize480x150  +Resize ; +toolwindow ; +Border
Gui,QuickGUI: Margin , 40 , 40

Gui,QuickGUI:Add, Edit, % "xm ym w400  vQS_Var_Latest_var Center -E0X200 gGuiSubmitAll"


Gui,QuickGUI:Add,text,xp y+5 w1 h40 BackgroundTrans,

loop,% GuiButtons.MaxIndex()
    {
Gui,QuickGUI:Add,Button,% "x+1 yp w40 h40 HwnddBTN0 vdBTN0_" . A_Index . " glbl_" . GuiButtons[A_Index] , %  GuiButtons[A_Index]
Gui,QuickGUI:Add,Button,% "xp yp w40 h40 vlBTN0_" . A_Index . " glbl_" . GuiButtons[A_Index] , %  GuiButtons[A_Index]
ImageButton.Create(dBTN0, DarkModeStyle*)
    }
Gui,QuickGUI: Add, Picture,x312 yp+10 w20 h20 vPicture1 glbl_th_fr_cfe,%A_WorkingDir%\assets\skbfklsfkionu_1.png
Gui,QuickGUI:Add,Button,% "x398 yp-10 w40 h40 HwnddBTN0 vdBTN0_Esc glbl_Esc" , Esc
Gui,QuickGUI:Add,Button,% "xp yp w40 h40 vlBTN0_Esc glbl_Esc"  , Esc
ImageButton.Create(dBTN0, DarkModeStyle*)
; Gui,QuickGUI: Font, s%FontLarge%
; if (UserVariables.b["Show_Dark_Mode_Button_on_UI"]) {
Gui,QuickGUI:Add,Button,% "x357 yp w40 h40 HwnddBTN0 vdBTN0_d glbl_Dark_Mode_direct Hidden" , oO
Gui,QuickGUI:Add,Button,% "xp yp w40 h40 vlBTN0_d glbl_Dark_Mode_direct Hidden "  , zZ

ImageButton.Create(dBTN0, DarkModeStyle*)
; }
Gosub,  lbl_Dark_Mode
Gui,QuickGUI: show, % " w480 h150" , QuicSearcherkGUI

; msgbox, % QuickGUIID 
if (UserVariables.b["Dont_show_start_up_message"]!=1) {
Gui +OwnDialogs
MsgBox 0x40040, Hiding to Tray, Hiding to tray `nHit hotkey to show, 2
IfMsgBox Timeout, {

}
}
Gui,QuickGUI: Hide

return


; t::
; WinMove,ahk_id %my_id%,,0,0
; return



lbl_Show_Quick_Searcher:
OutputDebug,% "`n" A_ThisLabel " | "
; guitogle:=!guitogle
; if (guitogle) {

    Save_Clipboard := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait, .5
    if !ErrorLevel
        {
    Query := Clipboard
    QS_Var_Latest_var:= Query
    GuiControl,QuickGUI:,QS_Var_Latest_var, %Query%
        }
   Clipboard := Save_Clipboard
   Save_Clipboard := ""
GuiShowOnActiveMon("QuickGUI",480,150)
GuiControl,QuickGUI: Focus, QS_Var_Latest_var
Send, ^a
; }
; Else {
; GuiHide("QuickGUI")
; }
gosub, picture_pulsing_timer
return

GuiSubmitAll:
Gui,QuickGUI: Submit, Nohide
return

Grab_selected_text:
Save_Clipboard := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait, .5
    if !ErrorLevel
        {
    Query := Clipboard
    QS_Var_Latest_var:= Query
    ; GuiControl,QuickGUI:,QS_Var_Latest_var, %Query%
        }
   Clipboard := Save_Clipboard
   Save_Clipboard := ""

return





lbl_Wiki_Grab_1st_paragraph:
; Gosub, lbl_Show_Quick_Searcher
Gosub, Grab_selected_text

lbl_W:
if (!QS_Var_Latest_var)
return
GuiHide("QuickGUI")
url := "https://en.wikipedia.org/w/api.php?format=xml&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=" . QS_Var_Latest_var
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("POST", url, false)
whr.Send()
try
html := whr.ResponseText
Catch, e
    {
MsgBox 0x40030, Check internet connection, Check internet connection
return
    }
RegExMatch(html, "<extract.*?>(.*?)<\/extract>", Match)
; Match1:=RegExReplace(Match1, "\\n" ,"`n")
Clipboard:= Match1

showSub(Match1)
GuiHide("QuickGUI")
return




lbl_Esc:
OutputDebug, % A_ThisLabel "`n"
GuiHide("QuickGUI")
return

lbl_Quick_google_Search:
Gosub, Grab_selected_text
lbl_G:
GuiHide("QuickGUI")
Query1:=QS_Var_Latest_var
StringReplace, Query1, Query1, `r`n, %A_Space%, All 
StringReplace, Query1, Query1, %A_Space%, `%20, All
StringReplace, Query1, Query1, #, `%23, All
Query1 := Trim(Query1)

Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --app=http://www.google.com/search?hl=en&q=%Query1%
; Run,  
; WinGet, WinStatus, MinMax, ahk_exe chrome.exe
; if (WinStatus != 0)
;  WinRestore, ahk_exe chrome.exe
; WinMove, ahk_exe chrome.exe,, 12, 438, 1190, 594 ; x,y,width,height
sleep, 500
WinMove, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe,, 0, A_ScreenHeight//3.5, A_ScreenWidth//3, (A_ScreenHeight//3)+100 ; x,y,width,height
return


lbl_Quick_Bing_Search:
Gosub, Grab_selected_text
lbl_B:
GuiHide("QuickGUI")
Query1:=QS_Var_Latest_var
StringReplace, Query1, Query1, `r`n, %A_Space%, All 
StringReplace, Query1, Query1, %A_Space%, `%20, All
StringReplace, Query1, Query1, #, `%23, All
Query1 := Trim(Query1)
Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --app=https://www.bing.com/search?q=%Query1%
sleep, 500
WinMove, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe,, 0, A_ScreenHeight//3.5, A_ScreenWidth//3, (A_ScreenHeight//3)+100 ; x,y,width,height
return


#if (WinActive("Ahk_id " . QuickGUIID))
!G::
Gosub, lbl_G
return
!W::
Gosub, lbl_W
return
!T::
Gosub, lbl_T
return
!I::
Gosub, lbl_I
return
!A::
Gosub, lbl_Ai
return
!B::
Gosub, lbl_B
return

#If

lbl_Search_for_image_put_to_clipboard:
Gosub, Grab_selected_text
lbl_I:
if (!QS_Var_Latest_var)
    return
GuiHide("QuickGUI")
OutputDebug, % A_ThisLabel "`n"
Random , randomnumber, 1, 5
; msgbox , % r
; msgbox , % GoogleImageSearchExtractImageURL(QS_Var_Latest_var, randomnumber)
imgurl:= GoogleImageSearchExtractImageURL(QS_Var_Latest_var, randomnumber)
; ImagePutClipboard(imgurl)
try
ImagePutClipboard({image: imgurl, scale: [UserVariables.n["Image_downloader_default_image_width"], ""]})
GuiHide("QuickGUI")
showSub(imgurl)
return


lbl_Google_tranlsate:
Gosub, Grab_selected_text
lbl_T:
if (!QS_Var_Latest_var)
    return
GuiHide("QuickGUI")
gtresponse:= GoogleTranslate(QS_Var_Latest_var, , UserVariables.t["Google_translate_Language_code"])
Clipboard:=gtresponse
GuiHide("QuickGUI")
showSub(gtresponse)
return



lbl_D:
GuiHide("QuickGUI")
url:="https://api.dictionaryapi.dev/api/v2/entries/en/" QS_Var_Latest_var
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", url, false)
whr.Send()
DresponseArr:=JSON.Load(whr.ResponseText)
Clipboard:= DresponseArr[1].meanings[1].definitions[1].definition
GuiHide("QuickGUI")
;  MsgBox, % dicahk[QS_Var_Latest_var]
showSub(whr.ResponseText)
return


lbl_Ask_ChatGPT:
Gosub, Grab_selected_text
lbl_Ai:
if (!QS_Var_Latest_var)
    return
GuiHide("QuickGUI")
OutputDebug, % A_ThisLabel "`n"
max_tokens:=UserVariables.n["ChatGPT_max_tokens"]
url := "https://api.openai.com/v1/engines/text-davinci-003/completions"
headers := "Content-Type: application/json`nAuthorization: Bearer" UserVariables.p["ChatGPT_API_KEY"]
body = {"prompt":" %QS_Var_Latest_var% ","max_tokens":%max_tokens%,"temperature":0.8}
WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("POST", url, false)
WinHttp.SetRequestHeader("Content-Type", "application/json")
WinHttp.SetRequestHeader("Authorization", "Bearer " UserVariables.p["ChatGPT_API_KEY"])
WinHttp.Send(body)
GuiHide("QuickGUI")
; MsgBox, % WinHttp.ResponseText
GPTresponseArr := JSON.Load(WinHttp.ResponseText)
Clipboard := GPTresponseArr.choices[1].text
; Clipboard := WinHttp.ResponseText
; showSub(GPTresponseArr.choices[1].text)
(GPTresponseArr.choices[1].text) ? showSub(GPTresponseArr.choices[1].text) : showSub(WinHttp.ResponseText)
return




;{ [booleans labels]============================================================================


lbl_Show_Dark_Mode_Button_on_UI:
if (UserVariables.b["Show_Dark_Mode_Button_on_UI"]){
    GuiControl,QuickGUI: Show, dBTN0_d
    GuiControl,QuickGUI: Show, lBTN0_d
    if (UserVariables.b["Dark_Mode"])
        GuiControl,QuickGUI: Hide, lBTN0_d 
    Else
        GuiControl,QuickGUI: Show, dBTN0_d
}
Else
    {
        GuiControl,QuickGUI: Hide, dBTN0_d
        GuiControl,QuickGUI: Hide, lBTN0_d
    }
return



lbl_Dark_Mode_direct:
UserVariables.b["Dark_Mode"] := !UserVariables.b["Dark_Mode"]
lbl_Dark_Mode:
if (UserVariables.b["Dark_Mode"]) {
    dark_tmp_var:=1
    Gui,QuickGUI: Color,c191919,c2C2C2C
    Gui,QuickGUI: Font, c858585
    GuiControl,QuickGUI: +c858585, QS_Var_Latest_var
    loop, % GuiButtons.MaxIndex() {
    GuiControl,QuickGUI: Show, dBTN0_%A_index%
    GuiControl,QuickGUI: Hide, lBTN0_%A_index%
    }
    GuiControl,QuickGUI: Show, dBTN0_Esc
    GuiControl,QuickGUI: Hide, lBTN0_Esc
    if (UserVariables.b["Show_Dark_Mode_Button_on_UI"]) {
    GuiControl,QuickGUI: Show, dBTN0_d
    GuiControl,QuickGUI: Hide, lBTN0_d
    }
    }
    Else
        {
    dark_tmp_var:=0
    Gui,QuickGUI: Color,cF0F0F0,cFFFFFF
    Gui,QuickGUI: Font, c000000
    GuiControl,QuickGUI: +c000000, QS_Var_Latest_var
    loop, % GuiButtons.MaxIndex() {
    GuiControl,QuickGUI: Hide, dBTN0_%A_index%
    GuiControl,QuickGUI: Show, lBTN0_%A_index%
        }
        GuiControl,QuickGUI: Hide, dBTN0_Esc
        GuiControl,QuickGUI: Show, lBTN0_Esc
        if (UserVariables.b["Show_Dark_Mode_Button_on_UI"]){
        GuiControl,QuickGUI: Hide, dBTN0_d
        GuiControl,QuickGUI: Show, lBTN0_d
        }
    }
return

lbl_Reduce_flicker:
if (UserVariables.b["Reduce_Flicker"])
Gui,QuickGUI: +E0x02000000 +E0x00080000
Else
Gui,QuickGUI: -E0x02000000 -E0x00080000
return

lbl_Start_On_windows_Start_Up:
if (UserVariables.b["Start_On_windows_Start_Up"]) {
; FileDelete, %A_Startup%\Quicksercher.lnk
FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\Quicksercher.lnk
}
Else
{
FileDelete, %A_Startup%\Quicksercher.lnk
}
Return


lbl_Hide_TaskBar_icon:
if (UserVariables.b["Hide_TaskBar_icon"])
Gui,QuickGUI: +ToolWindow
Else
Gui,QuickGUI: -ToolWindow
return

lbl_Image_downloader_default_image_width:
lbl_ChatGPT_max_tokens:
lbl_Show_Overlay_Notification:
lbl_Google_translate_Language_code:
lbl_Dont_show_start_up_message:
return




;}==============================================================================================
















; QS_Var_Latest_fn(ctrlID, value){
    
;     ; msgbox, % ctrlID " " value
;     global QS_Var_Latest_var
;     QS_Var_Latest_var:= value
; }







GuiHide(GuiName){
    Gui,%GuiName% : Hide
}


GetActiveMonitor() ; we didn't actually need the "Monitor = 0"
{
	; get the mouse coordinates first
	Coordmode, Mouse, Screen	; use Screen, so we can compare the coords with the sysget information`
	MouseGetPos, Mx, My

	SysGet, MonitorCount, 80	; monitorcount, so we know how many monitors there are, and the number of loops we need to do
	Loop, %MonitorCount%
	{
		SysGet, mon%A_Index%, Monitor, %A_Index%	; "Monitor" will get the total desktop space of the monitor, including taskbars

		if ( Mx >= mon%A_Index%left ) && ( Mx < mon%A_Index%right ) && ( My >= mon%A_Index%top ) && ( My < mon%A_Index%bottom )
		{
			ActiveMon := A_Index
			break
		}
	}
	return ActiveMon
}


GuiShowOnActiveMon(GuiName:=1,GUI_Width:=480,GUI_Height:=150) {
	ActiveMon:=GetActiveMonitor()
    SysGet, MonitorWorkArea, MonitorWorkArea, %ActiveMon%
	GUI_X:=(( MonitorWorkAreaRight-MonitorWorkAreaLeft - GUI_Width ) // 2) + MonitorWorkAreaLeft
	, GUI_Y:=((MonitorWorkAreaBottom-MonitorWorkAreaTop  - GUI_Height ) // 2) + MonitorWorkAreaTop
    Gui, %GuiName%: Show, % "x" GUI_X " y" GUI_Y



}





~Esc::
GuiHide("QuickGUI")
return



lbl_Exit:
Terminatelbl()
return




Terminatelbl(){
GuiHide("QuickGUI")
sleep, 500
OutputDebug,% "`n" A_ThisFunc " | "
ExitApp
return
}

SettingShow:
gui,QSettingsGUI: Show
return

Reloadlbl:
OutputDebug,% "`n" A_ThisLabel " | "
Reload
return

showSub(text){
if (UserVariables.b["Show_Overlay_Notification"]) {
Vis2.Graphics.Subtitle.Render(SubStr(text, 1 , 70 ) . "`n " . SubStr(text, 70 , 100 ) . "...", {"time":2500, "x":"center", "y":"83%" , "padding":"1.35%", "color":"Black"}, {"q":4, "size":"2%", "font":"Arial", "z":"Arial Narrow", "justify":"left", "color":"BEBEBE"})
sleep, 500
Vis2.Graphics.Subtitle.Render("Saved to Clipboard.", "time: 2000, x: center, y: 75%, p: 1.35%, c: 373737, r: 8", "c: F0D871, s:2%, f:Arial")
}
}



; f1::
; ComObjCreate("SAPI.SpVoice").Speak(Clipboard)
; return





GoogleImageSearchExtractImageURL(keyword, n=1, downloadToFile="") {
	keyword := StrReplace(keyword, " ", "+")
	HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	HTTP.Open("GET", "https://www.google.com/search?q=" keyword "&tbm=isch", true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.67 Safari/537.36 OPR/87.0.4390.45")
	HTTP.SetRequestHeader("Pragma", "no-cache")
	HTTP.SetRequestHeader("Cache-Control", "no-cache, no-store")
	HTTP.SetRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
	HTTP.Send()
	HTTP.WaitForResponse()
	if (HTTP.responsetext="failed" || HTTP.status!=200 || ComObjType(HTTP.responsestream) != 0xd)
		return
	content := HTTP.ResponseText
	;~ MsgBox,% Content
	
	pos := 1, mc := 0
	while pos := RegexMatch(content, "\[""([^""]*?)"",\d+,\d+],null", match, pos+StrLen(match)) {
		if (++mc == n) {
			if downloadToFile { ; by Wicked
				HTTP.Open("GET", match1, true)
				HTTP.Send()
				HTTP.WaitForResponse()
				p:=ComObjQuery(HTTP.responsestream,"{0000000c-0000-0000-C000-000000000046}")
				f:=FileOpen(downloadToFile,"w")
				Loop {
					VarSetCapacity(b,8192)
					r:=DllCall(NumGet(NumGet(p+0)+3*A_PtrSize), "ptr", p, "ptr", &b, "uint", 8192, "ptr*", c)
					f.RawWrite(&b, c)
				} Until (c=0)
				f.Close()
				ObjRelease(p)
			}
			return match1
		}
	}
}



#If (WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe")) 
Esc::
WinClose ,  ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
return
#if


picture_pulsing_timer:
loop, 1
    {
loop, 10
    {
        GuiControl,QuickGUI:, Picture1, %A_WorkingDir%\assets\skbfklsfkionu_%A_Index%.png
        Sleep 50
    }
    loop, 10
        {
            tn:=11-A_Index
            GuiControl,QuickGUI:, Picture1, %A_WorkingDir%\assets\skbfklsfkionu_%tn%.png
            Sleep 50
        }
    ; GuiControl,, Picture1, skbfklsfkionu_1.png
    }
; GuiControl,, Picture1, love_1.png
return

WM_MOUSEMOVE( wparam, lparam, msg, hwnd )
{
    MouseGetPos,,,, OutputVarControl
    if (OutputVarControl="Static2"){
        loop, 3
            {
             MouseGetPos,,,, OutputVarControl
             if (OutputVarControl!="Static2")
                break
        loop, 10
            {
                GuiControl,QuickGUI:, Picture1, %A_WorkingDir%\assets\skbfklsfkionu_%A_Index%.png
              
                Sleep 50
            }
            loop, 10
                {
                    tn:=11-A_Index
                    GuiControl,QuickGUI:, Picture1, %A_WorkingDir%\assets\skbfklsfkionu_%tn%.png
                    
                    Sleep 50
                }
            }
    }
	; if wparam = 1 ; LButton
    ;     {
	; 	PostMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
    ;     }
}

