#SingleInstance Force
CoordMode, Pixel, Relative
SetKeyDelay, 0

PixY := 7
MsgPixel() {
	PixelGetColor, curColor1, 0, 007, RGB ; Color1 0xFF0000 ; Program
	PixelGetColor, curColor2, 1, 007, RGB ; Color2 0x00FF00 ; Queue
	PixelGetColor, curColor3, 2, 007, RGB ; Color3 0x0000FF ; Command
	MsgBox % "PixY: " . 007 . " curColor1: " . curColor1 . " curColor2: " . curColor2 . " curColor3: " . curColor3
}

Press(key, duration:=200) {
	Send, {%key% down}
	Sleep duration
	Send, {%key% up}
	Return true
}

Loop {
	WinWaitActive Elder Scrolls Online
	PixelGetColor, curColor1, 0, 007, RGB ; Color1 0xFF0000 ; Program
	; MsgBox % "curColor1: " . curColor1 . " sub: " . SubStr(curColor1, 3, 2)
	If (curColor1 = "0x010101") {
		PixelGetColor, curColor2, 1, 007, RGB ; Color2 0x00FF00 ; Queue
		If (SubStr(curColor2, 3, 2) = "01") {
			; PixelGetColor, curColor2, 0, 007, RGB ; Color1 0xFF0000 ; Program
			curColor2 := SubStr(curColor2, 5, 2)
			curColor3 := SubStr(curColor2, 7, 2)
			; PixelGetColor, curColor2, 1, 007, RGB ; Color2 0x00FF00 ; Queue
			; PixelGetColor, curColor3, 2, 007, RGB ; Color3 0x0000FF ; Command
			;MsgBox % "2 curColor2: " . curColor2
			If (curColor2 != prvColor2) {
				;PixelGetColor, curColor3, 2, 007, RGB ; Color3 0x0000FF ; Command
				;MsgBox % "3 curColor2: " . curColor2
				If (curColor3 = "01") {
					Press("e")
				}
				If (curColor3 = "02") {
					Press("x")
				}
			}
			prvColor2 := curColor2
		}
	}
	Sleep, 10
}

; $NumpadDiv:: Send X
; $NumpadDiv:: Press("Q")
^!+,:: Reload  ; Ctrl-Alt-Shift-,
; $NumpadDiv:: ProcessPixel("0xFFFF00")
; $NumpadMult:: ProcessPixel("0xFF0000")
$NumpadDiv:: MsgPixel()
