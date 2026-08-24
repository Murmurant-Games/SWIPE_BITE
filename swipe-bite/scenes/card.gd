extends Control

class_name Card

@onready var lbl_name: Label = $pnlCard/lblName

var card_name : String = ""

func setup(_card_name):
	card_name = str(_card_name)
	lbl_name.text = str(card_name).capitalize()
