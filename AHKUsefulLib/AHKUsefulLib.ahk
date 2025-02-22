#Requires AutoHotkey v2.0

; AHK v2 library to provide useful functions

#Include AHKWinMessageLib.ahk

; ============== Array ==============
/* ArrayIsIn(array_, value): Check if a value is in an array
 * Args: 
 *   array_ (Array[Any]): The array to check
 *   value (Any): The value to check for
 * Returns (bool): True if the value is in the array, False otherwise*/
ArrayIsIn(array_, value) {
    For item in array_
        If (item = value)
            Return True
    Return False
}

/* ArrayIsInAt(array_, value): Check if a value is in an array and retrieve the index
 * Args: 
 *   array_ (Array[Any]): The array to check
 *   value (Any): The value to check for
 * Returns (Integer): 0 if the value is not in the array, the index of the value otherwise*/
ArrayIsInAt(array_, value) {
    For index, item in array_
        If (item = value)
            Return index
    Return 0
}

/* ArrayCount(array_, value): Get the number items of given value in an array
 * Args:
 *   array_ (Array[Any]): The array to check
 *   value (Any): The value to count
 * Returns (Integer): The number of items of the given value in the array*/
ArrayCount(array_, value) {
    count := 0
    For item in array_
        If (item = value)
            count++
    Return count
}

/* ArrayReverse(array_): Gives a reversed copy of an array
 * Args:
 *   array_ (Array[Any]): The array to reverse
 * Returns (Array[Any]): The reversed array (copy) */
ArrayReverse(array_) {
    new_array := []
    For index, item in array_
        new_array.InsertAt(1, item)
    Return new_array
}

/* ArrayJoin(array_, delimiter): Join the items of an array into a string
 * Args:
 *   array_ (Array[String]): The array to join
 *   delimiter (String): The string to put between items
 * Returns (String): The joined string */
ArrayJoin(array_, delimiter) {
    result := ""
    For index, item in array_ {
        result .= item
        If (index < array_.Length)
            result .= delimiter
    }
    Return result
}

/* ArraySort(array_, options): Sort an array
 * Args:
 *   array_ (Array[Any]): The array to sort
 *   options (String): The options to pass to the Sort function. Typically, use "" (alphabetical) or "N" (numerical), and add "R" for reverse
 * Returns (Array[String]): The sorted array 
 * 
 * Warning: Does not support multiline string elemtent
 * Will return an array of String*/
ArraySort(array_, options := "N") {
    str_ := ArrayJoin(array_, "`r`n")
    str_ := Sort(str_, options)
    sorted_array := StrSplit(str_, "`r`n")
    Return sorted_array
}

/* ArrayInsertArray(array_, index, array_to_insert): Insert an array into another array at a given index
 * Args:
 *   array_ (Array[Any]): The array to insert into
 *   index (Integer): The index to insert at
 *   array_to_insert (Array[Any]): The array to insert
 * Returns (Array[Any]): The array with the inserted array */
ArrayInsertArray(array_, index, array_to_insert) {
    index_to_insert := index
    For item in array_to_insert
        array_.InsertAt(index_to_insert++, item)
    Return array_
}

/* ArrayApply(array_, func, args*): Apply a function to each item in an array
 * Args:
 *   array_ (Array[Any]): The array to apply the function to
 *   func (Func): The function to apply (item as first argument)
 *   args* (Array[Any]): Additional arguments to pass to the function (unpacked)
 * Returns (Array[Any]): An array of the results of applying the function to each item */
ArrayApply(array_, func, args*) {
    new_array := []
    For index, item in array_
        new_array.Push(func(item, args*))
    Return new_array
}

/* ArrayRange(start, end, step := 1): Generate an array of numbers in a range
 * Args:
 *   start (Integer): The start of the range
 *   end (Integer): The end of the range (inclusive)
 *   step (Integer): The step size (default is 1, must be positive)
 * Returns (Array[Integer]): An array of numbers in the range */
ArrayRange(start, end, step := 1) {
    array_ := []
    Loop (end - start)//step + 1
        array_.Push(start + (A_Index - 1) * step)
    Return array_
}

; ============== String ==============
/* StringSlice(string_, start, end): Get a slice of a string
 * Args:
 *   string_ (String): The string to slice
 *   start (Integer): The start index of the slice
 *   end (Integer): The end index of the slice
 * Returns (String): The slice of the string */
StringSlice(string_, start, end) {
    Return SubStr(string_, start, end - start + 1)
}

/* StringRepeat(string_, count): Repeat a string a given number of times
 * Args:
 *   string_ (String): The string to repeat
 *   count (Integer): The number of times to repeat the string
 * Returns (String): The repeated string */
StringRepeat(string_, count) {
    result := ""
    Loop count
        result .= string_
    Return result
}

/* StringPad(string_, length, pad_char := " ", shorten := True): Pad a string to a given length
 * Args:
 *   string_ (String): The string to pad
 *   length (Integer): The length to pad the string to
 *   pad_char (String): The character to pad with (default is space)
 *   shorten (bool): Whether to shorten the string if it's longer than the length (default is True)
 * Returns (String): The padded string */
StringPad(string_, length, pad_char := " ", shorten := True) {
    If (StrLen(string_) > length) {
        If (shorten) {
            Return SubStr(string_, 1, length)
        } Else {
            Return string_
        }
    } Else {
        pad_count := length - StrLen(string_)
        Return string_ . StringRepeat(pad_char, pad_count)
    }
}

/* StringStartsWith(string_, prefix): Check if a string starts with a given prefix
 * Args:
 *   string_ (String): The string to check
 *   prefix (String): The prefix to check for
 * Returns (bool): True if the string starts with the prefix, False otherwise */
StringStartsWith(string_, prefix) {
    Return (SubStr(string_, 1, StrLen(prefix)) = prefix)
}

/* StringEndsWith(string_, suffix): Check if a string ends with a given suffix
 * Args:
 *   string_ (String): The string to check
 *   suffix (String): The suffix to check for
 * Returns (bool): True if the string ends with the suffix, False otherwise */
StringEndsWith(string_, suffix) {
    Return (SubStr(string_, -StrLen(suffix)) = suffix)
}

; ============== Map ==============

/* MapKeys(map_): Get the keys of a map
 * Args:
 *   map_ (Map[String, Any]): The map to get the keys from
 * Returns (Array[String]): An array of the keys of the map */
MapKeys(map_) {
    keys := []
    For key in map_
        keys.Push(key)
    Return keys
}

/* MapValues(map_): Get the values of a map
 * Args:
 *   map_ (Map[String, Any]): The map to get the values from
 * Returns (Array[Any]): An array of the values of the map */
MapValues(map_) {
    values := []
    For key, value in map_
        values.Push(value)
    Return values
}

/* MapToString(map_, key_value_separator := ":", pair_separator := ", "): String representation of a map
 * Args:
 *   map_ (Map[String, Any]): The map to convert
 *   key_value_separator (String): The separator between keys and values (default is ":")
 *   pair_separator (String): The separator between key-value pairs (default is ", ")
 * Returns (String): The map as a string */
MapToString(map_, key_value_separator := ":", pair_separator := ", ") {
    result := ""
    For key, value in map_
        If (result = "")
            result := key . key_value_separator . value
        Else
            result .= pair_separator . key . key_value_separator . value
    Return result
}

/* MapUnion(map1, map2): Union of two maps
 * Args:
 *   map1 (Map[String, Any]): The first map
 *   map2 (Map[String, Any]): The second map
 * Returns (Map[String, Any]): A new map containing the union of the keys and values of the input maps */
MapUnion(map1, map2) {
    new_map := Map()
    For key, value in map1
        new_map[key] := value
    For key, value in map2
        new_map[key] := value
    Return new_map
}

; ============== Function ==============
/* FunctionPartial(func, args*): Partial application of a function
 * Args:
 *   func (Func): The function to partially apply
 *   args* (Array[Any]): The arguments to bind to the function (unpacked)
 * Returns (Func): A new function with the arguments bound */
FunctionPartial(func, args*) {
    Return Func.Bind(args*)
}


; ============== GuiControl.ComboBox ==============
/* ComboBoxClearItems(combo_box): Clear all items in a GuiControl.ComboBox control
 * Args:
 *   combo_box (GuiControl.ComboBox): The ComboBox control to clear */
ComboBoxClearItems(combo_box) {
    Loop ControlGetItems(combo_box).Length
        ControlDeleteItem(1, combo_box)
}

/* ComboBoxSetItems(combo_box, items): Set the items in a GuiControl.ComboBox control
 * Args:
 *   combo_box (GuiControl.ComboBox): The ComboBox control to set items for
 *   items (Array[String ]): The items to set */
ComboBoxSetItems(combo_box, items) {
    ComboBoxClearItems(combo_box)
    For item in items
        ControlAddItem(item, combo_box)
}

; ============== GuiControl.DropDownList ==============

/* DropDownListClearItems(drop_down_list): Clear all items in a GuiControl.DropDownList control
 * Args:
 *   drop_down_list (GuiControl.DropDownList): The DropDownList control to clear */
DropDownListClearItems(drop_down_list) {
    Loop ControlGetItems(drop_down_list).Length
        ControlDeleteItem(1, drop_down_list)
}

/* DropDownListSetItems(drop_down_list, items): Set the items in a GuiControl.DropDownList control
 * Args:
 *   drop_down_list (GuiControl.DropDownList): The DropDownList control to set items for
 *   items (Array[String ]): The items to set */
DropDownListSetItems(drop_down_list, items) {
    DropDownListClearItems(drop_down_list)
    For item in items
        ControlAddItem(item, drop_down_list)
}


; ============== GuiControl.Edit ==============
/* EditSetFromArray(edit_, array_): Set the text of a GuiControl.Edit control from an array
 * Args:
 *   edit_ (GuiControl.Edit): The Edit control to set text for
 *   array_ (Array[String]): The array to set as text */
EditSetFromArray(edit_, array_) {
    edit_.Text := ArrayJoin(array_, "`r`n")
}

/* EditGetAsArray(edit_): Get the text of a GuiControl.Edit control as an array
 * Args:
 *   edit_ (GuiControl.Edit): The Edit control to get text from
 * Returns (Array[String]): The text of the Edit control as an array */
EditGetAsArray(edit_) {
    Return StrSplit(edit_.Text, "`r`n")
}

; ============== GuiControl.ListBox ==============
/* ListBoxClearItems(list_box): Clear all items in a GuiControl.ListBox control
 * Args:
 *   list_box (GuiControl.ListBox): The ListBox control to clear */
ListBoxClearItems(list_box) {
    Loop ControlGetItems(list_box).Length
        ControlDeleteItem(1, list_box)
}

/* ListBoxSetItems(list_box, items): Set the items in a GuiControl.ListBox control
 * Args:
 *   list_box (GuiControl.ListBox): The ListBox control to set items for
 *   items (Array[String ]): The items to set */
ListBoxSetItems(list_box, items) {
    ListBoxClearItems(list_box)
    For item in items
        ControlAddItem(item, list_box)
}

; ============== GuiControl.ListView ==============
/* ListViewClearItems(list_view): Clear all items in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to clear */
ListViewClearItems(list_view) {
    list_view.Delete() ; Clear all items
}

/* ListViewSetItems(list_view, items): Set the items in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to set items for
 *   items (Array[Array[String]]): The items to set. Each element is an array containing the string values for each columns.
 *   options (String, optional): The options for all set items. Defaults to ""*/
ListViewSetItems(list_view, items, options := "") {
    ListViewClearItems(list_view)
    For index, item in items {
        list_view.Add(options, item*)
    }
}

/* ListViewGetItems(list_view): Get the items in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get items from
 * Returns (Array[Array[String]]): The items in the ListView. Each element is an array containing the string values for each columns. */
ListViewGetItems(list_view) {
    items := []
    for row_index in ArrayRange(1, list_view.GetCount()) {
        row := []
        for col_index in ArrayRange(1, list_view.GetCount("Col")) {
            row.Push(list_view.GetText(row_index, col_index))
        }
        items.Push(row)
    }
    Return items
}

/* ListViewGetRow(list_view, row_index): Get a row from a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get the row from
 *   row_index (Integer): The index of the row to get
 * Returns (Array[String]): The row at the given index */
ListViewGetRow(list_view, row_index) {
    row := []
    for col_index in ArrayRange(1, list_view.GetCount("Col")) {
        row.Push(list_view.GetText(row_index, col_index))
    }
    Return row
}

/* ListViewGetColumn(list_view, col_index): Get a column from a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get the column from
 *   col_index (Integer): The index of the column to get
 * Returns (Array[String]): The column at the given index */
ListViewGetColumn(list_view, col_index) {
    col := []
    for row_index in ArrayRange(1, list_view.GetCount()) {
        col.Push(list_view.GetText(row_index, col_index))
    }
    Return col
}

/* ListViewGetRows(list_view, rows): Get the rows at the given indices from a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get rows from
 *   rows (Array[Integer]): The indices of the rows to get
 * Returns (Array[Array[String]]): The rows at the given indices */
ListViewGetRows(list_view, rows) {
    items := []
    for row_index in rows {
        row := []
        for col_index in ArrayRange(1, list_view.GetCount("Col")) {
            row.Push(list_view.GetText(row_index, col_index))
        }
        items.Push(row)
    }
    Return items
}

/* ListViewGetSelectedIndices(list_view): Get the indices of the selected rows in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get selected indices from
 * Returns (Array[Integer]): The indices of the selected rows */
ListViewGetSelectedIndices(list_view) {
    row_indices := []
    current_selected_index := list_view.GetNext(0)
    while (current_selected_index > 0) {
        row_indices.Push(current_selected_index)
        current_selected_index := list_view.GetNext(current_selected_index)
    }
    Return row_indices
}

/* ListViewGetSelectedItems(list_view): Get the selected rows in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to get selected items from
 * Returns (Array[Array[String]]): The selected rows */
ListViewGetSelectedItems(list_view) {
    row_indices := ListViewGetSelectedIndices(list_view)
    Return ListViewGetRows(list_view, row_indices)
}

/* ListViewSelectAll(list_view): Select all rows in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to select all rows in */
ListViewSelectAll(list_view) {
    For index in ArrayRange(1, list_view.GetCount())
        list_view.Modify(index, "+Select")
}

/* ListViewUnselectAll(list_view): Unselect all rows in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to unselect all rows in */
ListViewUnselectAll(list_view) {
    For index in ArrayRange(1, list_view.GetCount())
        list_view.Modify(index, "-Select")
}

/* ListViewSelectRow(list_view, row_index): Select a row in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to select a row in
 *   row_index (Integer): The index of the row to select */
ListViewSelectRows(list_view, rows) {
    For row in rows
        list_view.Modify(row, "+Select")
}

/* ListViewUnselectRow(list_view, row_index): Unselect a row in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to unselect a row in
 *   row_index (Integer): The index of the row to unselect */
ListViewUnselectRows(list_view, rows) {
    For row in rows
        list_view.Modify(row, "-Select")
}

/* ListViewToggleRow(list_view, row_index): Toggle the selection of a row in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to toggle the selection of a row in
 *   row_index (Integer): The index of the row to toggle the selection of */
ListViewSelectRow(list_view, row) {
    list_view.Modify(row, "+Select")
}

/* ListViewUnselectRow(list_view, row_index): Unselect a row in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to unselect a row in
 *   row_index (Integer): The index of the row to unselect */
ListViewUnselectRow(list_view, row) {
    list_view.Modify(row, "-Select")
}

/* ListViewToggleRow(list_view, row_index): Toggle the selection of a row in a GuiControl.ListView control
 * Args:
 *   list_view (GuiControl.ListView): The ListView control to toggle the selection of a row in
 *   row_index (Integer): The index of the row to toggle the selection of */
ListViewToggleRow(list_view, row) {
    selected_rows := ListViewGetSelectedIndices(list_view)
    If (ArrayIsIn(selected_rows, row))
        ListViewUnselectRow(list_view, row)
    Else
        ListViewSelectRow(list_view, row)
}



; ============== GroupBox ==============

; ============== Hotkey ==============

; ============== Link ==============

; ============== ListBox ==============

; ============== Picture (or Pic) ==============

; ============== Progress ==============

; ============== Radio ==============

; ============== Slider ==============

; ============== StatusBar ==============

; ============== Tab3 / Tab2 / Tab ==============

; ============== Text ==============

; ============== TreeView ==============

; ============== UpDown ==============

; ============== Misc ==============
/* GetStringRepresentation(obj): Get a string representation of an object
 * Args:
 *   obj (Any): The object to get a string representation of
 * Returns (String): The string representation of the object 
 * 
 * Note: was made to have a similar behaviour than the __str__() python methods, allowing for nested representations.
 * Note: Only supports basic objects such as String, Integer, Float, Array and Map.*/
GetStringRepresentation(obj) {
    If obj is String or obj is Integer or obj is Float
        Return obj
    Else If obj is Array {
        str := ""
        For index, item in obj
            str .= GetStringRepresentation(item) . ", "
        Return "[" SubStr(str, 1, -2) "]" ; Remove the last ", "
    }
    Else If obj is Map {
        str := ""
        For key, value in obj
            str .= key . ": " . GetStringRepresentation(value) . ", "
        Return "{" SubStr(str, 1, -2) "}" ; Remove the last ", "
    }
    Else
        throw ValueError("Unsupported type for GetStringRepresentation: " Type(obj)  )
}