    #RequireAdmin
    #include <WindowsConstants.au3>
    #include <Constants.au3>
	#include <AutoItConstants.au3>
    #include <GUIConstantsEx.au3>
    #include <Misc.au3>
    #include <WinAPI.au3>

   Local $hDLL = DllOpen("user32.dll")
   Global $CenterX =  @DESKTOPWidth / 2
   Global $CenterY =  @DESKTOPHeight / 2
   Global $Switch_G = 0
   Global $switched_color = 0
   Global $ColorGui = 0x0000FF
   Global $ScanX = $CenterX * 0.07;
   Global $StillPressed = 0
   Global $hGUIChild4
   Global $hGUIMain
   Global $EXIT = true
   $hGUIMain = GUICreate("")

   Crosshair()
   Func Crosshair()
	  $hGUIChild4 = GUICreate("", $ScanX, 1, $CenterX - $ScanX, $CenterY + 1, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_LAYERED), $hGUIMain)
	  GUISetBkColor($ColorGui)
	  _WinAPI_SetWindowPos($hGUIChild4, $HWND_TOPMOST, 0, 0, 0, 0, BitOR($SWP_NOACTIVATE, $SWP_NOMOVE, $SWP_NOSIZE, $SWP_NOSENDCHANGING))
	  _WinAPI_SetLayeredWindowAttributes($hGUIChild4, 0x0000E4)
	  GUISetState(@SW_SHOWNOACTIVATE, $hGUIChild4)
   EndFunc

   Func UpdateColors()
	  If $switched_color == 0 Then
		 GUISetBkColor($ColorGui, $hGUIChild4)
		 $switched_color = 1
	  EndIf
   EndFunc

   Func CheckKeyPressed()
	  If $Switch_G == 0 Then ; prevention to not check IsPressed all the time only if for proper value change (only one ispressed scan at a time)
		 If _IsPressed("69", $hDLL) Then
			$Switch_G = 1
			$ColorGui = 0x00FF00
			$switched_color = 0
		 EndIf
	  EndIf
	  If _IsPressed("6B", $hDLL) Then ; Close Application
		 $EXIT = False
	  EndIf
   EndFunc

   While $EXIT
	  UpdateColors()
	  CheckKeyPressed()
	  If $Switch_G == 1 Then ; 12 = ALT
		 If _IsPressed("68", $hDLL) Then
			   $Switch_G = 0
			   $ColorGui = 0x0000FF
			   $switched_color = 0
		 EndIf
		 $FoundRed_0  = PixelSearch ($CenterX - $ScanX, $CenterY - 1, $CenterX, $CenterY + 1, 0xFF0000, 100)
		 If IsArray($FoundRed_0) Then
			MouseClick($MOUSE_CLICK_LEFT)
			Sleep(15)
		 EndIf
		 Sleep(1)
	  EndIf

   WEnd
