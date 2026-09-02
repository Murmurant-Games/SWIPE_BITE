extends Control

class_name Main

var swipeable_scene = preload("uid://burecohv2qxav")
var card_scene = preload("uid://cey26of3178o0")
var stat_ui_scene = preload("uid://bb4g0ohqgsw1q")

var stat_names = ["hunger", "humanity", "heat", "nights_lasted"]
var stats_dict = {}
var cards = []
var hunger_delta = 0.0
var red_colours = [Color(0.5, 0, 0), Color(0.08, 0, 0), Color(0, 0, 0)]
var human_colours = [Color(0.03, 0, 0.4), Color(0.56, 0, 0.53), Color(0, 0, 0)]

@onready var story : InkPlayer = $InkPlayer
@onready var vbox_stats: VBoxContainer = $PanelContainer/vboxStats
@onready var hbox_cards: HBoxContainer = $pnlCards/hboxCards
@onready var ctrl_swipeable: Control = $ctrlSwipeable
@onready var ctrl_eyes: Control = $ctrlEyes
@onready var audio_bgm: AudioStreamPlayer2D = $audioBGM
@onready var rect_bg: ColorRect = $ctrlBG/rectBG
@onready var bg_mat: ShaderMaterial = rect_bg.material
@onready var anim_player: AnimationPlayer = $animPlayer

func _ready() -> void:
	story.connect("loaded", on_story_loaded)
	story.create_story()
	$rectBlack.visible = true
	Global.main = self

func _process(delta: float) -> void:
	var humanity_delta = clampf(get_humanity_delta(), 0.0, 1.0)
	var hunger_delta = clampf(get_hunger_delta(), 0.0, 1.0)
	var target_colors = round(Utils.change_range(humanity_delta, 0, 1, 2, 8))
	var target_dither = round(Utils.change_range(hunger_delta, 0, 1, 1, 3))
	var target_spin = Utils.change_range(humanity_delta, 0, 1, 0.05, 0.2)
	var target_contrast = Utils.change_range(hunger_delta, 0, 1, 0.75, 3.0)
	var target_lighting = ((1.0 - hunger_delta) * 0.75)
	var current_spin = bg_mat.get_shader_parameter("spin_amount")
	var current_contrast = bg_mat.get_shader_parameter("contrast")
	var current_lighting = bg_mat.get_shader_parameter("lighting")
	bg_mat.set_shader_parameter("spin_amount", lerpf(current_spin, target_spin, 0.025))
	#bg_mat.set_shader_parameter("colour_1", target_col1)
	#bg_mat.set_shader_parameter("colour_2", target_col2)
	bg_mat.set_shader_parameter("colors", target_colors)
	bg_mat.set_shader_parameter("dither_size", target_dither)
	bg_mat.set_shader_parameter("contrast", lerpf(current_contrast, target_contrast, 0.1))
	bg_mat.set_shader_parameter("lighting", lerpf(current_lighting, target_lighting, 0.1))
	pass

func on_story_loaded(successfully : bool):
	if !successfully:
		print("Failed to load story")
		
	print(story.get_variable("cards"))

func setup():
	anim_player.play("Show")
	vbox_stats.get_children().map(func(x): x.queue_free())
	story.reset()
	stat_names.map(func(stat_name): 
		var stat_ui : StatUI = stat_ui_scene.instantiate()
		vbox_stats.add_child(stat_ui)
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
	
	var last_size = cards.size()
	var new_cards = story.get_variable("cards")
	
	Utils.free_children(hbox_cards)
	new_cards = new_cards.keys()
	new_cards.reverse()
	new_cards.map(func(card_name):
		var card : Card = card_scene.instantiate()
		hbox_cards.add_child(card)
		card.setup(card_name)
		)
	
	cards = new_cards
	
	
func next_swipeable():
	var swipeable : Swipeable = swipeable_scene.instantiate()
	ctrl_swipeable.add_child(swipeable)
	swipeable.setup(story)

func on_var_change(var_name : String, value):
	if var_name.to_lower() == "hunger":
		hunger_delta = clampf(float(value) - 5, 0, 5) / 5.0
		print("hunger delta = " + str(hunger_delta))
	if var_name.to_lower() == "heat":
		ctrl_eyes.get_children().map(func(eye): eye.update_heat(value / 10.0))
	stats_dict[var_name].on_value_changed(value)
	
func get_heat_delta() -> float:
	return story.get_variable("heat") / 10.0

func get_humanity_delta() -> float:
	return story.get_variable("humanity") / 10.0
		
func get_hunger_delta() -> float:
	return story.get_variable("hunger") / 10.0
		
func get_nights_lasted() -> int:
	return int(story.get_variable("nights_lasted"))
		
func get_hunger_bbcode() -> String:
	return "[shake level=" + (str(hunger_delta * 5.0)) +  " rate=" + str(hunger_delta * 20) + "]"

func _on_btn_rest_pressed() -> void:
	#Global.current_swipeable.queue_free()
	#setup()
	story.set_variable("nights_lasted", 20)
	pass


func _on_audio_bgm_finished() -> void:
	audio_bgm.play()
