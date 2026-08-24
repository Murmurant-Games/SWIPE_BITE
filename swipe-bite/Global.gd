extends Node

var main_scene = preload("res://scenes/main.tscn")

var current_swipeable : Swipeable
var main : Main
var main_menu : MainMenu

func _ready() -> void:
	main = main_scene.instantiate()
	get_tree().root.add_child.call_deferred(main)
	main.visible = false
	print("Added main")

func start_game():
	main.visible = true
	main.setup()

func goto_main_menu():
	current_swipeable.queue_free()
	main.visible = false
	main_menu.visible = true
