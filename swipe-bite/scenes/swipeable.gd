extends Control

class_name Swipeable

@onready var rtl_story_text: RichTextLabel = $pnlCard/Control/VBoxContainer/rtlStoryText
@onready var pnl_card: PanelContainer = $pnlCard
@onready var card_inital_pos : Vector2 = pnl_card.position
@onready var choice_texts : Array[RichTextLabel] = [$rtlLeft, $rtlRight, $rtlUp]
@onready var lbl_title: Label = $pnlCard/Control/VBoxContainer/lblTitle
@onready var pnl_pic: PanelContainer = $pnlCard/Control/VBoxContainer/pnlPic
@onready var trect_portrait: TextureRect = $pnlCard/Control/VBoxContainer/pnlPic/trectPortrait
@onready var anim_player: AnimationPlayer = $animPlayer

var portraits = [	#preload("uid://d0aqgef4xhl2l"),
					preload("uid://dfdnaqkhqai8c"),
					preload("uid://jh2qwycs2rd"),
					preload("uid://djddjnv5hjxb3"),
					preload("uid://dv77bhn6jpk66")
					]

var is_dragging : bool = false
var text = ""
var choices : Array[Choice]
var card_target_pos : Vector2 = Vector2.ZERO
var pos_smoothing_factor : float = 0.25

func setup(story : InkPlayer):
	Global.current_swipeable = self
	if story.get_can_continue():
		
		var txt = story.continue_story()
		var tags = story.get_current_tags().map(func(x): return str(x))
		
		while should_skip(story, txt, tags):
			txt = story.continue_story()
			tags = story.get_current_tags().map(func(x): return str(x))
		
			
		rtl_story_text.text =  txt
		
		if tags.size() > 0:
			lbl_title.text = tags[0]
			pnl_pic.visible = true
			trect_portrait.texture = portraits.pick_random()
		else:
			lbl_title.visible = false
			pnl_pic.visible = false
		
		choice_texts.map(func(rtl): 
			rtl.text = ""
			rtl.self_modulate = Color(1, 1, 1, 0))
		
		var current_choices = story.get_current_choices()
		if current_choices.size() == 0:
			var choice : Choice = Choice.new()
			var ink_choice : InkChoice = InkChoice.new()
			ink_choice.index = 0
			ink_choice.text = "CONTINUE"
			choice.setup(story, ink_choice)
			choice = Choice.new()
			ink_choice  = InkChoice.new()
			ink_choice.index = 1
			ink_choice.text = "CONTINUE"
			choice.setup(story, ink_choice)
			choices.append(choice)
			
		else:
			current_choices.map(
				func(ink_choice : InkChoice):
					var choice : Choice = Choice.new()
					choice.setup(story, ink_choice)
					choices.append(choice))
			
		for index in choices.size():
			var choice_txt = choices[index].get_text()
			if choice_txt.begins_with("SPARE / AVOID"):
				choice_txt = "Avoid"
			if choice_txt.begins_with("FEED / FACE"):
				choice_txt = "Pursue"
			choice_texts[index].text = choice_txt
	else:
		rtl_story_text.text = "done"
		
	rtl_story_text.visible_characters = 0
	rtl_story_text.visible_characters_behavior = TextServer.VC_CHARS_AFTER_SHAPING
	await anim_player.animation_finished
	show_next_char()

func _process(delta: float) -> void:
	if is_dragging:
		var mouse_x_delta = get_local_mouse_position().x / 400.0
		mouse_x_delta = clampf(mouse_x_delta, -1, 1)
		card_target_pos.x = card_inital_pos.x + lerpf(0, 200, mouse_x_delta)
		pnl_card.rotation_degrees = lerpf(0, 30, mouse_x_delta)
		
	else:
		card_target_pos.x = card_inital_pos.x
		pnl_card.rotation_degrees = 0
		
	pnl_card.position.x = lerpf(pnl_card.position.x, card_target_pos.x, pos_smoothing_factor)
	
func start_drag():
	is_dragging = true

func end_drag():
	is_dragging = false
	var mouse_pos = get_local_mouse_position()
	if mouse_pos.x > -280 and mouse_pos.x < 280:
		pass
	elif mouse_pos.x < -280:
		swipe_left()
	else:
		swipe_right()
	#print(get_local_mouse_position())
	
func swipe_left():
	if choices.size() > 1:
		choices[1].choose()
		die()

func swipe_right():
	if choices.size() > 0:
		choices[0].choose()
		die()
	else:
		#if Global.main.story.get_can_continue():
			#Global.main.continue_story()
			#die()
		Global.goto_main_menu()
	
func swipe_up():
	if choices.size() > 2:
		choices[2].choose()
		die()

func _on_button_button_down() -> void:
	skip()
	start_drag()

func skip():
	if not all_text_visible:
		rtl_story_text.visible_characters = rtl_story_text.text.length()
		all_text_visible = true
		on_all_text_visible()

func _on_button_button_up() -> void:
	end_drag()

func die():
	queue_free()
	
func should_skip(story, txt : String, tags) -> bool:
	txt = str(txt).to_lower()
	if (tags.size() > 0 and tags[0].to_lower().begins_with("dn_print")):
		if story.get_current_choices().size() > 0:
			story.choose_choice_index(0)
		return true
	if txt.begins_with("next:"):
		return true
	if txt.begins_with("feed / face:"):
		return true
	if txt.begins_with("spare / avoid:"):
		return true
	if txt.begins_with("game opening screen etc."):
		return true
	if txt == "
":
		return true
	if txt == ("human
"):
		return true
	if txt == ("vampire
"):
		return true
	if txt == ("play game
"):
		return true
		
	return false
	
	
var text_index = 0
var all_text_visible = false
func show_next_char():
	if rtl_story_text.visible_characters == rtl_story_text.text.length():
		if not all_text_visible:
			all_text_visible = true
			on_all_text_visible()
		return
	else:
		await Utils.await_char(rtl_story_text.text, text_index)
		if not all_text_visible:
			text_index += 1
			rtl_story_text.visible_characters = text_index
			show_next_char()

func on_all_text_visible():
	
	anim_player.play("show_choices")
	choice_texts.map(func(rtl): 
			rtl.self_modulate = Color(1, 1, 1, 1))


func _on_btn_skip_button_down() -> void:
	skip()
