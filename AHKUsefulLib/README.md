# AHKUsefulLib

A collection of useful libraries for AutoHotKey.
Highly unfinished.

## Requirements

All scripts were made for [AutoHotKey v2](https://www.autohotkey.com/).

## AHKUsefulLib

Main purpose of this collection. This library implement several useful functions for AutoHotKey, enabling easier object manipulation.

### Functions
```
ArrayIsIn(array_, value) : Check if a value is in an array
ArrayIsInAt(array_, value) : Check if a value is in an array and return its index
ArrayCount(array_, value) : Count the number of times a value appears in an array
ArrayReverse(array_) : Return reversed array
ArrayJoin(array_, delimiter) : Join array elements into a String with a delimiter
ArraySort(array_, options := "N") : Sort an array
ArrayInsertArray(array_, index, array_to_insert) : Insert an array into another array at a given index
ArrayApply(array_, func, args*) : Apply a function to each element of an array
ArrayRange(start, end, step := 1) : Create an array for a range of numbers
StringSlice(string_, start, end) : Return a slice of a string
StringRepeat(string_, count) : Repeat a string a given number of times
StringPad(string_, length, pad_char := " ", shorten := True) : Pad a string to a given length
StringStartsWith(string_, prefix) : Check if a string starts with a given prefix
StringEndsWith(string_, suffix)  : Check if a string ends with a given suffix
MapKeys(map_) : Return an array with the keys of a map
MapValues(map_) : Return an array with the values of a map
MapToString(map_, key_value_separator := ":", pair_separator := ", ") : Convert a map to a string
MapUnion(map1, map2) : Return a map with the union of two maps
FunctionPartial(func, args*) : Return a function with some arguments already set
ComboBoxClearItems(combo_box) : Clear all items from a ComboBox
ComboBoxSetItems(combo_box, items) : Set items to a ComboBox
DropDownListClearItems(drop_down_list) : Clear all items from a DropDownList
DropDownListSetItems(drop_down_list, items) : Set items to a DropDownList
EditSetFromArray(edit_, array_) : Set the text of an Edit control from an array
EditGetAsArray(edit_) : Get the text of an Edit control as an array
ListBoxClearItems(list_box) : Clear all items from a ListBox
ListBoxSetItems(list_box, items) : Set items to a ListBox
ListViewClearItems(list_view) : Clear all items from a ListView
ListViewSetItems(list_view, items, options := "") : Set items to a ListView
ListViewGetItems(list_view) : Get items from a ListView
ListViewGetRow(list_view, row_index) : Get a row from a ListView
ListViewGetColumn(list_view, col_index) : Get a column from a ListView
ListViewGetRows(list_view, rows) : Get rows from a ListView
ListViewGetSelectedIndices(list_view) : Get selected indices from a ListView
ListViewGetSelectedItems(list_view) : Get selected items from a ListView
ListViewSelectAll(list_view) : Select all rows from a ListView
ListViewUnselectAll(list_view) : Unselect all rows from a ListView
ListViewSelectRows(list_view, rows) : Select rows from a ListView
ListViewUnselectRows(list_view, rows) : Unselect rows from a ListView
ListViewSelectRow(list_view, row) : Select a row from a ListView
ListViewUnselectRow(list_view, row) : Unselect a row from a ListView
ListViewToggleRow(list_view, row) : Toggle a row from a ListView
GetStringRepresentation(obj) : Get a string representation of an object
```

## AHKWinMessageLib

Library implementing functions taking advantage of the Windows messages. This library is still in development.

### Functions
```
DDL_CB_SetItemHeight(control, height) : Set the height of items in a ComboBox or DropDownList
LV_Scroll(list_view, dx := 0, dy := 0) : Scroll a ListView
```

## AHKComplexLib

Library implementing complex numbers and operations with them. This library is still in development.

## AHKMatrixLib

Library implementing matrices and operations with them. This library is still in development.

## License

[MIT](https://choosealicense.com/licenses/mit/)