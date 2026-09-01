extends Control

class_name Card

@onready var lbl_name: Label = $pnlCard/lblName
@onready var mat : ShaderMaterial = $pnlCard.material

var card_name : String = ""

func setup(_card_name):
	card_name = str(_card_name)
	lbl_name.text = str(card_name).capitalize()
	#mat.set_shader_parameter("tint", Color(randf_range(0.1, 0.3), randf_range(0.1, 0.3), randf_range(0.1, 0.3)))
