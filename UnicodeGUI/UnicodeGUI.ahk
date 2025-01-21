#Requires AutoHotkey v2.0
TraySetIcon("UnicodeGUI.png")
tray_menu := A_TrayMenu
tray_menu.Delete()
tray_menu.Add("Toggle GUI", ToggleGUI)
tray_menu.Add()
tray_menu.AddStandard()

; Define configurable values
KEY_FILE_PATH := "key_definitions.ini"  ; Path to the key definitions file
GUI_COLOR_BACK := "331271"  ; Background color (transparent color)
POP_UP_SOUND_LOCATION := EnvGet("WINDIR") "\Media\Windows Pop-up Blocked.wav"
DOUBLE_PRESS_DELAY := 300  ; Delay for double press (in ms)
X := 150  ; X-position of the GUI
Y := 500  ; Y-position of the GUI
W := 298  ; Width of the GUI
H := 124  ; Height of the GUI
KEYS_OFFSET_X := 4 ; Offset in X direction
KEYS_OFFSET_Y := 4 ; Offset in Y direction
MAX_ROWS := 6 ; Maximum number of rows
TRANSPARENCY := 150    ; TRANSPARENCY level (0-255)

; Key parameters
KEY_H := 16 ; Height
KEY_W := 16 ; Width
KEY_GAP_X := 4 ; Gap between keys in X direction
KEY_GAP_Y := 4 ; Gap between keys in Y direction
KEY_FONTSIZE := 10 ; Font size
KEY_TEXT_DEFAULT_OFFSET_X := 4 ; Text offset in X direction
KEY_TEXT_DEFAULT_OFFSET_Y := 0 ; Text offset in Y direction
KEY_TEXT_DEFAULT_COLOR := "a3b9ff" ; Text color

; Load key_definitions.ini
If FileExist(KEY_FILE_PATH) {
    FILE_CONTENT := FileReadLines(KEY_FILE_PATH)
} Else {
    MsgBox(KEY_FILE_PATH " not found")
    ExitApp()
}

; Create objects
GuiShown := False ; Flag to check if the GUI is shown
last_Appskey_timestamp := 0
GuiNone := MakeGuiSection("None") ; None
GuiShift := MakeGuiSection("Shift") ; Shift
GuiAltGr := MakeGuiSection("AltGr") ; AltGr
GuiAppsKey := MakeGuiSection("AppsKey") ; AppsKey
GuiAppsKeyShift := MakeGuiSection("AppsKeyShift") ; AppsKey + Shift
GuiAppsKeyAltGr := MakeGuiSection("AppsKeyAltGr") ; AppsKey + AltGr
GuiAltGrShift := MakeGuiSection("AltGrShift") ; AltGr + Shift
GuiAppsKeyAltGrShift := MakeGuiSection("AppsKeyAltGrShift") ; AppsKey + AltGr + Shift
GuiList := [GuiNone, GuiShift, GuiAltGr, GuiAppsKey, GuiAppsKeyShift, GuiAppsKeyAltGr, GuiAltGrShift, GuiAppsKeyAltGrShift]
; Sleep(5000)
; Gui1.Hide()

; =========== Behaviour ===========
class KeyStateCollection {
    ; class to store the state of relevant keys
    static AppsKey := False ; AppsKey state (RCtrl here)
    static Shift := False ; Shift state
    static AltGr := False ; AltGr state
}
key_states := KeyStateCollection()
key_states.AppsKey := False
key_states.Shift := False
key_states.AltGr := False

; Toggle GUI (double RCtrl)
; AppsKey Down
Hotkey("~*RCtrl", AppsKeyDown)
AppsKeyDown(ThisHotkey) {
    global last_Appskey_timestamp
    global GuiShown
    key_states.AppsKey := True
    
    If (A_TickCount - last_Appskey_timestamp < DOUBLE_PRESS_DELAY) {
        GuiShown := !GuiShown
        If (GuiShown == True) {
            SoundPlay(POP_UP_SOUND_LOCATION)
        } Else {
            ; ShowGUI(0)
        }
    } Else {
        last_Appskey_timestamp := A_TickCount
    }

    global key_states
    BehaviourDown()
}
; AppsKey Up
Hotkey("~*RCtrl Up", AppsKeyUp)
AppsKeyUp(ThisHotkey) {
    global key_states
    key_states.AppsKey := False
    BehaviourUp()
}

; Shift hotkey
Hotkey("~*Shift", ShiftDown)
ShiftDown(ThisHotkey) {
    global key_states
    key_states.Shift := True
    BehaviourDown()
}
; Shift Up
Hotkey("~*Shift Up", ShiftUp)
ShiftUp(ThisHotkey) {
    global key_states
    key_states.Shift := False
    BehaviourUp()
}
; AltGr hotkey
Hotkey("~LControl & ~RAlt", AltGrDown)
AltGrDown(ThisHotkey) {
    global key_states
    key_states.AltGr := True
    BehaviourDown()
}
Hotkey("~LControl & ~RAlt Up", AltGrUp)
AltGrUp(ThisHotkey) {
    global key_states
    key_states.AltGr := False
    BehaviourUp()
}
BehaviourUp() {
    global key_states
    BehaviourDown()
}
ToggleGUI(*) { ; For Tray Menu
    global GuiShown
    GuiShown := !GuiShown
    BehaviourDown()
}

BehaviourDown() {
    ; TODO: use HotIf ?
    global key_states
    global GuiShown
; GuiList : [1=GuiNone 2=GuiShift 3=GuiAltGr 4=GuiAppsKey 5=GuiAppsKeyShift 6=GuiAppsKeyAltGr 7=GuiAltGrShift 8=GuiAppsKeyAltGrShift]
    If (GuiShown == True) { ; If GUI is shown
        If (key_states.AppsKey AND key_states.AltGr AND key_states.Shift) {
            ShowGUI(8) ; AppsKey + AltGr + Shift
        } Else If (key_states.AppsKey AND key_states.AltGr) { ; AND key_states.Shift == False
            ShowGUI(6) ; AppsKey + AltGr
        } Else If (key_states.AppsKey AND key_states.Shift) { ; AND key_states.AltGr == False
            ShowGUI(5) ; AppsKey + Shift
        } Else If (key_states.AppsKey) { ; AND key_states.AltGr == False AND key_states.Shift == False
            ShowGUI(4) ; AppsKey
        } Else If (key_states.AltGr AND key_states.Shift) { ; AND key_states.AppsKey == False
            ShowGUI(7) ; AltGr + Shift
        } Else If (key_states.AltGr) { ; AND key_states.AppsKey == False AND key_states.Shift == False
            ShowGUI(3) ; AltGr
        } Else If (key_states.Shift) { ; AND key_states.AppsKey == False AND key_states.AltGr == False
            ShowGUI(2) ; Shift
        } Else { ; If none of the keys are pressed
            ShowGUI(1) ; None
        }
    } Else { ; If GUI is not shown
        ShowGUI(0)
    }
}


; Show given GUI
ShowGUI(index) {
    For i, Gui in GuiList {
        If (i == index) {
            Gui.Show("x" X " y" Y " w" W " h" H " NoActivate")
        } Else {
            Gui.Hide()
        }
    }
}

; =========== GUI definitions ===========
; GUI generation per section
MakeGuiSection(section := "Main") {
    GuiSection := MakeGenericGui()
    section_content := SectionParse(FILE_CONTENT, section)
    DrawKeyboard(GuiSection, section_content, KEYS_OFFSET_X, KEYS_OFFSET_Y)
    return GuiSection
}

; =========== Helper functions ===========

; Create and configure a base Gui
MakeGenericGui() { 
    NewGui := Gui()
    NewGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
    WinSetExStyle("+0x00000020", NewGui) ; Make CLick Though
    NewGui.BackColor := GUI_COLOR_BACK  ; Set the background color.
    WinSetTransColor(" " TRANSPARENCY, NewGui)
    ; NewGui.SetFont("s" 32)   ; Set the font size.
    return NewGui
}

; Function to draw the keyboard layout
DrawKeyboard(GuiObject, section_content, begin_x := KEYS_OFFSET_X, begin_y := KEYS_OFFSET_Y)
{
    current_widths := [] ; Array to store the current widths of each rows
    Loop MAX_ROWS
        current_widths.Push(begin_x)

    For line in section_content {
        line_split := StrSplit(line, "	")
        If (line_split.Length < 3) {
            MsgBox("WARNING : Invalid line format:`r`n" line)
            ExitApp()
        }
        row := line_split[1]
        text := line_split[2]
        If (line_split.Length >= 6) { ; If custom width
            this_key_w := line_split[6]
        } Else { 
            this_key_w := KEY_W ; Default width otherwise
        }

        ; Calculate the position of the key
        x := current_widths[row] + KEY_GAP_X
        y := (row-1) * (KEY_H + KEY_GAP_Y) + begin_y
        current_widths[row] := current_widths[row] + KEY_GAP_X + this_key_w ; update the current width

        If line_split.Length == 3 {
            DrawKey(GuiObject, text, x, y)
        } Else If (line_split.Length == 3) {
            DrawKey(GuiObject, text, x, y, this_key_w, KEY_H, line_split[3]) ; With offset X
        } Else If (line_split.Length == 4) {
            DrawKey(GuiObject, text, x, y, this_key_w, KEY_H, line_split[3], line_split[4]) ; With offset X and Y
        } Else If (line_split.Length == 5) {
            DrawKey(GuiObject, text, x, y, this_key_w, KEY_H, line_split[3], line_split[4], line_split[5]) ; With offset X and Y and fontsize
        } Else {
            DrawKey(GuiObject, text, x, y, this_key_w, KEY_H, line_split[3], line_split[4], line_split[5]) ; With offset X and Y and fontsize and width
        }
    }
}

; Function to add a `Text` object to the GUI
DrawKey(GuiObject, text, x, y, w := KEY_W, h := KEY_H, text_offset_x := KEY_TEXT_DEFAULT_OFFSET_X, text_offset_y := KEY_TEXT_DEFAULT_OFFSET_Y, fontsize := KEY_FONTSIZE, color := KEY_TEXT_DEFAULT_COLOR)
{
    GuiObject.SetFont("s" fontsize)  ; Set the font size
    DrawBorderBox(GuiObject, x, y, w, h, color, 1)
    GuiObject.Add("Text", "x" (x + text_offset_x) " y" (y + text_offset_y) " c" color, text)
}

; Parse file content, returns an Array of lines of corresponding section
SectionParse(file_content, section := "Main") {
    section_content := [] ; Array to store the lines of the corresponding section
    is_right_section := False ; Flag to check if the current line is in the right section
    For Line in file_content { ; Parse file line by line
        If (Line = "") {
            Continue
        }
        ; Keep only the relevant part of the line / relevant lines
        line_split := StrSplit(Line, ";")
        len := line_split.Length
        line_content := Trim(line_split[1]) ; keep only the relevant part of the line
        If (line_content = "") {
            Continue
        }

        ; Section check
        REGEX_SECTION := "^\[(.+)\]"
        RegExMatch(Line, REGEX_SECTION, &section_match)

        If (section_match != "") AND (section_match.Count > 0) { ; If section
            If (section_match[1] == section) { ; If right section
                is_right_section := True
            } Else { ; If wrong section
                is_right_section := False
            }
        } Else { ; If not section
            If (is_right_section = False) {
                Continue
            }
            section_content.Push(line_content)
        }

    }

    return section_content
}

; Draw Border Box
DrawBorderBox(GuiObject, x, y, w, h, color := "ffffff", border_width := 1) {
    GuiObject.Add("Text", "x" x " y" y " w" w " h" border_width " Background" color) ; Top border
    GuiObject.Add("Text", "x" x " y" (y + border_width) " w" border_width " h" (h - 2*border_width) " Background" color) ; Left border
    GuiObject.Add("Text", "x" x " y" (y + h - border_width) " w" w " h" border_width " Background" color) ; Bottom border
    GuiObject.Add("Text", "x" (x + w - border_width) " y" (y + border_width) " w" border_width " h" (h - 2*border_width) " Background" color) ; Right border
}

; Read file content
FileReadLines(file_to_read)
{
    sText := FileRead(file_to_read, "UTF-8")
    return StrSplit(sText, "`n", "`r")
}