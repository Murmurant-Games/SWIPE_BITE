extends Control

class_name Main

var swipeable_scene = preload("uid://burecohv2qxav")
var story : InkStory = preload("uid://bfe4vwfj67nkv")
var stat_ui_scene = preload("uid://bb4g0ohqgsw1q")

var stat_names = ["hunger", "humanity", "heat", "health", "sanity", "security", "nights_lasted"]
var stats_dict = {}

@onready var hbox_stats: HBoxContainer = $PanelContainer/hboxStats


func _ready() -> void:
	Global.main = self
	
	stat_names.map(func(stat_name): 
		var stat_ui : StatUI = stat_ui_scene.instantiate()
		hbox_stats.add_child(stat_ui)
		stat_ui.setup(stat_name, story.FetchVariable(stat_name))
		stats_dict[stat_name] = stat_ui
		story.ObserveVariable(stat_name, on_var_change)
		)
		
	continue_story()

func continue_story():
	next_swipeable()
	
func next_swipeable():
	var swipeable : Swipeable = swipeable_scene.instantiate()
	add_child(swipeable)
	swipeable.setup(story)

func on_var_change(var_name : String, value):
	stats_dict[var_name].on_value_changed(value)
		
