    #RequireAdmin
    #include <WindowsConstants.au3>
    #include <Constants.au3>
    #include <GUIConstantsEx.au3>
    #include <Misc.au3>
    #include <WinAPI.au3>

   Local $hDLL = DllOpen("user32.dll")

   Global $CenterX =  @DESKTOPWidth / 2
   Global $CenterY =  @DESKTOPHeight / 2
   Global $Switch_G = 0
   Global $ColorGui = 0x0000FF
   Global $HexColor =  0xFF0000
   Global $ColorVariance =  65
   Global $ScanX = $CenterX * 0.07;
   Global $StillPressed = 0
   $hGUIMain = GUICreate("")

   Crosshair()
   Func Crosshair()
	  $hGUIChild4 = GUICreate("", $ScanX, 1, $CenterX - $ScanX, $CenterY + 1, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_LAYERED), $hGUIMain)
	  GUISetBkColor($ColorGui)
	  _WinAPI_SetWindowPos($hGUIChild4, $HWND_TOPMOST, 0, 0, 0, 0, BitOR($SWP_NOACTIVATE, $SWP_NOMOVE, $SWP_NOSIZE, $SWP_NOSENDCHANGING))
	  _WinAPI_SetLayeredWindowAttributes($hGUIChild4, 0x0000E4)
	  GUISetState(@SW_SHOWNOACTIVATE, $hGUIChild4)
   EndFunc
   While True
	  If _IsPressed("69", $hDLL) Then ; Numpad 9
		 If $Switch_G == 1 Then
			$Switch_G = 2
			$ColorGui = 0x00FF00
		 Else
			$Switch_G = 1
			$ColorGui = 0x0000FF
		 EndIf
		 MsgBox(false, "Changed State", "Enabled Auto:" & $Switch_G)
	  EndIf

	  If _IsPressed("12", $hDLL) Then ; ALT
		 If $Switch_G == 1 Then
			$FoundRed_0  = PixelSearch ($CenterX - $ScanX, $CenterY - 1, $CenterX, $CenterY + 1, $HexColor, $ColorVariance)
			If IsArray($FoundRed_0) Then
			   Send("{H}") ; H
			EndIf
		 EndIf
		 While _IsPressed("12", $hDLL)
			$FoundRed_0  = PixelSearch ($CenterX - $ScanX, $CenterY - 1, $CenterX, $CenterY + 1, $HexColor, $ColorVariance)
			If IsArray($FoundRed_0) Then
			   Send("{H}") ; H
			EndIf
		 WEnd
	  EndIf
   WEnd
