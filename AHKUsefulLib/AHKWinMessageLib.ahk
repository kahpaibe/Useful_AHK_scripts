#Requires AutoHotkey v2.0

; AHK v2 library to provide interfaces for various Windows Messages

; Nomenclature:
;   CONTROL1_CONTROL2_CONTROL3_..._Description
; Control types:
; - DDL : GuiControl.DropDownList
; - CB : GuiControl.ComboBox
; - LV : GuiControl.ListView

; 0x0153 : CB_SETITEMHEIGHT
/* DDL_CB_SetItemHeight(control, height) : Set height of selection field.
 * Args:
 *   control (GuiControl.DropDownList | GuiControl.ComboBox): The control to set the item height for
 *   height (Integer): The height to set */
DDL_CB_SetItemHeight(control, height) {
    PostMessage(0x0153, -1, height, control)  ; Set height of selection field.
    PostMessage(0x0153, 0, height, control)  ; Set height of list items.
}

; 0x1014 := LVM_SCROLL
/* LV_Scroll(list_view, dx := 0, dy := 0) : Scroll the list view.
 * Args:
 *   list_view (GuiControl.ListView): The list view to scroll
 *   dx (Integer): The horizontal scroll amount in pixel
 *   dy (Integer): The vertical scroll amount  in pixel
 * Note: if abs(dy) smaller than the height of items of the ListView object, vertical scrolling will be ignored.*/
LV_Scroll(list_view, dx := 0, dy := 0) {
    LVM_FIRST := 0x1000,  
    LVM_SCROLL := (LVM_FIRST + 20)  
    PostMessage(LVM_SCROLL, dx, dy, list_view)
}