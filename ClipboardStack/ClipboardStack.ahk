#Requires AutoHotkey v2.0
TraySetIcon("ClipboardStack.png")

; ====== Parameters ======
SOUND_COPIED := EnvGet("WINDIR") "\Media\Windows Message Nudge.wav"
SOUND_PASTED := EnvGet("WINDIR") "\Media\Windows Pop-up Blocked.wav"
SOUND_FINISHED := EnvGet("WINDIR") "\Media\Windows Ding.wav"
CLIPBOARD_TIMEOUT := 2 ; seconds
DEFAULT_DO_NEXT := True
DEFAULT_DO_APPEND_NEWLINE := False
DEFAULT_DO_APPEND_COPY := False
DEFAULT_DO_POPUP := True
X := 0
Y := 0
W := 400
H := 360
W_edit := W - 20
H_edit := 150
Y_list := H_edit + 50
W_list := W_edit
H_list := 150

; ====== Definitions ======
; Clipboard to Edit
ActionCopy(ThisKey) {
    A_Clipboard := "" ; Clear the clipboard
    Send("^c")
    success := ClipWait(CLIPBOARD_TIMEOUT, 1) ; Wait for the clipboard to contain data.
    If (success) {
        If (cs_do_append_copy.Value) { ; Append the text
            cs_edit.Value .= A_Clipboard "`n"
        } Else {
            cs_edit.Value := A_Clipboard
        }
        SoundPlay(SOUND_COPIED)
        DoEditToList() ; Update List from Edit

        If (cs_do_popup.Value) { ; Show GUI
            ShowGUI()
        }
        
    } ; Else: do nothing
}
Hotkey("^+c", ActionCopy)

; Send items from list
ActionPaste(ThisKey) {
    If (cs_list.GetCount() > 0) AND (cs_list.GetNext() > 0) {

        If (cs_do_appendnewline.Value) { ; Send the text
            SendText(cs_list.GetText(cs_list.GetNext(), 2) "`n")
        } Else {
            SendText(cs_list.GetText(cs_list.GetNext(), 2))
        }
        SoundPlay(SOUND_PASTED) ; Play sound

        If (cs_do_next.Value) { ; Go next item
            current_index := cs_list.GetNext()
            If (current_index < cs_list.GetCount()) {
                SelectItem(cs_list, current_index + 1)
            } Else {
                SelectItem(cs_list, 1)

                SoundPlay(SOUND_FINISHED) ; Play sound
            }
            UpdateItemSelected()
        }
    }
}
Hotkey("^+v", ActionPaste)
; Build GUI
    cs_gui := Gui(, "ClipboardStack AHK")
    cs_gui.Opt("")

    cs_edit := cs_gui.Add("Edit", "x0 y0" " w" W_edit " h" H_edit " x" (W-W_edit)//2 " y" 10 " vEdit")
    cs_list := cs_gui.Add("ListView", "x10 y" Y_list " w" W_list " h" H_list " vList" "+NoSort -WantF2", ["n°","Item"])
    cs_list.OnEvent("ItemSelect", UpdateItemSelectedEvent)
    
    cs_item_count := cs_gui.Add("Text", "x" 60 " y" (H_edit+13) " w" 80 " vItemCount")
    UpdateItemCount()

    cs_item_selected := cs_gui.Add("Text", "x" 60 " y" (H_edit+33) " w" 80 " vItemSelected")


    cs_gui.SetFont("s" 16)
    cs_listtoedit := cs_gui.Add("Button", "x" 10 " y" (H_edit+20) " w" 20 " h" 20 " vListToEdit", "🠕")
    cs_listtoedit.OnEvent("Click", DoListToEdit)
    cs_edittolist := cs_gui.Add("Button", "x" 30 " y" (H_edit+20) " w" 20 " h" 20 " vEditToList", "🠗")
    cs_edittolist.OnEvent("Click", DoEditToList)
    cs_gui.SetFont("s" 8)
    
    cs_do_append_copy_label := cs_gui.Add("Text", "x" 160 " y" (H_edit+13) " w" 80 " vDoAppendCopyLabel", "Append ^+c ?")
    cs_do_append_copy := cs_gui.Add("CheckBox", "x" 230 " y" (H_edit+10) " w" 20 " h" 20 " vDoAppendCopy")
    cs_do_append_copy.Value := DEFAULT_DO_APPEND_COPY

    cs_do_appendnewline_label := cs_gui.Add("Text", "x" 160 " y" (H_edit+33) " w" 70 " vDoAppendNewLineLabel", "Append ``n ?")
    cs_do_appendnewline := cs_gui.Add("CheckBox", "x" 230 " y" (H_edit+30) " w" 20 " h" 20 " vDoAppendNewLine")
    cs_do_appendnewline.Value := DEFAULT_DO_APPEND_NEWLINE

    cs_do_next_label := cs_gui.Add("Text", "x" W-121 " y" (H_edit+13) " w" 60 " vDoNextLabel", "Go next ?")
    cs_do_next := cs_gui.Add("CheckBox", "x" W-70 " y" (H_edit+10) " w" 20 " h" 20 " vDoNext")
    cs_do_next.Value := DEFAULT_DO_NEXT

    cs_do_popup_label := cs_gui.Add("Text", "x" W-136 " y" (H_edit+33) " w" 70 " vDoPopupLabel", "GUI on ^+c ?")
    cs_do_popup := cs_gui.Add("CheckBox", "x" W-70 " y" (H_edit+30) " w" 20 " h" 20 " vDoPopup")
    cs_do_popup.Value := DEFAULT_DO_POPUP


    cs_gui.SetFont("s" 16)
    cs_clear_button := cs_gui.Add("Button", "x" W-40 " y" (H_edit+20) " w" 20 " h" 20 " vClearButton", "♻")
    cs_clear_button.OnEvent("Click", DoClear)
    cs_gui.SetFont("s" 8)

; Clear 
DoClear(*) {
    cs_list.Delete()
    cs_edit.Value := ""
    UpdateItemCount()
    UpdateItemSelected()
}

; Update Edit from List 
DoListToEdit(*) {
    list_item_count := cs_list.GetCount()
    new_text := ""
    Loop list_item_count
        {
            new_text .= cs_list.GetText(A_Index, 2) "`n"
        }
    cs_edit.Value := new_text
}

; Update List from Edit
DoEditToList(*) {
    cs_list.Delete()
    split_list := StrSplit(cs_edit.Value, "`n")
    loop split_list.Length
    {
        item_trimmed := Trim(split_list[A_Index], "`t`n")
        If (StrLen(item_trimmed) > 0) {
            AddItemToList(cs_list, item_trimmed)
        }
    }
    If (cs_list.GetCount() > 0) {
        SelectItem(cs_list, 1)
    }
    UpdateItemCount()
    UpdateItemSelected()
}

; Add item to a the ListView item
AddItemToList(list_view_object, item) {
    list_view_object.Add(,list_view_object.GetCount() + 1, item)
}

; Select given index in the ListView
SelectItem(list_view_object, index) {
    list_view_object.Modify(list_view_object.GetNext(), "-Select")
    list_view_object.Modify(index, "+Select")
}

; Update item count label
UpdateItemCount() {
    item_count := cs_list.GetCount()
    If (item_count > 0) {
        text_ := "Item count: " item_count
    } Else {
        text_ := "No item !"
    }
    cs_item_count.Text := text_
}
; Update item selected label
UpdateItemSelected() {
    item_selected := cs_list.GetNext()
    If (item_selected) {
        text_ := "Current item: " item_selected
    } Else {
        text_ := ""
    }
    cs_item_selected.Text := text_
}
UpdateItemSelectedEvent(*) {
    UpdateItemSelected()
}

; Show gui
ShowGUI(*) {
    cs_gui.Show("w" W " h" H)
}

; ==== Custom context menu ====
cs_menu := Menu()
; cs_menu.AddStandard()
cs_menu := A_TrayMenu
cs_menu.Add()
cs_menu.Add("Show GUI", ShowGUI)
