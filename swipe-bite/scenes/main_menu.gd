extends Control

class_name MainMenu

func _ready() -> void:
	Global.main_menu = self

func _on_btn_play_pressed() -> void:
	self.visible = false
	Global.start_game()
