extends VBoxContainer

class_name StatUI

@onready var rtl_name: RichTextLabel = $rtlName
@onready var rtl_value: RichTextLabel = $rtlValue
@onready var anim_player: AnimationPlayer = $animPlayer
@onready var rtl_prior: RichTextLabel = $Control/rtlPrior
@onready var trect_stat: TextureRect = $Control2/trectStat
@onready var trect_stat_2: TextureRect = $Control2/trectStat2


var tex_humanity : Texture2D = preload("res://art/humanity.png")
var tex_hunger : Texture2D = preload("res://art/survived.png")
var tex_heat : Texture2D = preload("res://art/night.png")
var tex_night : Texture2D = preload("res://art/cat.png")
var tex_die : Texture2D = preload("res://art/died.png")
var tex_win : Texture2D = preload("res://art/win.png")

var stat_name : String = "Default"
var value
var prior_value

func setup(_name : String, _value):
	stat_name = _name
	value = _value
	prior_value = value
	
	rtl_name.text = stat_name.replace("_", " ")
	rtl_value.text = str(value)
	
	match stat_name.to_lower():
		"hunger": trect_stat.texture = tex_hunger
		"humanity": trect_stat.texture = tex_humanity
		"heat": trect_stat.texture = tex_heat
		"nights_lasted": trect_stat.texture = tex_night
	
	trect_stat_2.texture = trect_stat.texture
	
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
