extends VBoxContainer

class_name StatUI

@onready var rtl_name: RichTextLabel = $rtlName
@onready var rtl_value: RichTextLabel = $rtlValue
@onready var anim_player: AnimationPlayer = $animPlayer
@onready var rtl_prior: RichTextLabel = $Control/rtlPrior

var stat_name : String = "Default"
var value
var prior_value

func setup(_name : String, _value):
	stat_name = _name
	value = _value
	prior_value = value
	
	rtl_name.text = stat_name
	rtl_value.text = str(value)
	
func on_value_changed(new_value):
	prior_value = value
	value = new_value
	update()

func update():
	if stat_name.to_lower() == "hunger":
		rtl_name.text = Global.main.get_hunger_bbcode() + str(stat_name)
		rtl_value.text = Global.main.get_hunger_bbcode() + str(value)
	else:
		rtl_value.text = str(value)
	
	var diff = abs(value - prior_value)
	if diff != 0:
		if value > prior_value:
			rtl_prior.text = "+" + str(diff)# + ", " + str(prior_value) + " -> " + str(value)
		else:
			rtl_prior.text = "-" + str(diff)# + ", " + str(prior_value) + " -> " + str(value)
		rtl_prior.visible = true
		anim_player.play("throb")
		await anim_player.animation_finished
		rtl_prior.visible = false
