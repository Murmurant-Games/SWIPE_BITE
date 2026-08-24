extends Control

class_name Main

var swipeable_scene = preload("uid://burecohv2qxav")

var stat_ui_scene = preload("uid://bb4g0ohqgsw1q")

var stat_names = ["hunger", "humanity", "heat", "nights_lasted"]
var stats_dict = {}

@onready var story : InkPlayer = $InkPlayer
@onready var hbox_stats: HBoxContainer = $PanelContainer/hboxStats


func _ready() -> void:
	story.connect("loaded", on_story_loaded)
	story.create_story()
	Global.main = self

func on_story_loaded(successfully : bool):
	if !successfully:
		print("Failed to laod story")

func setup():
	hbox_stats.get_children().map(func(x): x.queue_free())
	story.reset()
	stat_names.map(func(stat_name): 
		var stat_ui : StatUI = stat_ui_scene.instantiate()
		hbox_stats.add_child(stat_ui)
		stat_ui.setup(stat_name, story.get_variable(stat_name))
		if stats_dict.has(stat_name):
			stats_dict[stat_name] = stat_ui
		else:
			stats_dict[stat_name] = stat_ui
			story.observe_variable(stat_name, self, "on_var_change")
			)
		
	continue_story()
	pass

func continue_story():
	next_swipeable()
	
func next_swipeable():
	var swipeable : Swipeable = swipeable_scene.instantiate()
	add_child(swipeable)
	swipeable.setup(story)

func on_var_change(var_name : String, value):
	stats_dict[var_name].on_value_changed(value)
		
