extends VBoxContainer

class_name StatUI

@onready var rtl_name: RichTextLabel = $rtlName
@onready var rtl_value: RichTextLabel = $rtlValue

var stat_name : String = "Default"
var value

func setup(_name : String, _value):
	stat_name = _name
	value = _value
	
	rtl_name.text = stat_name
	rtl_value.text = str(value)
	
func on_value_changed(new_value):
	value = new_value
	update()

func update():
	rtl_value.text = str(value)
