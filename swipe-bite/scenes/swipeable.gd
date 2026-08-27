extends Control

class_name Swipeable

@onready var rtl_story_text: RichTextLabel = $pnlCard/Control/VBoxContainer/rtlStoryText
@onready var pnl_card: PanelContainer = $pnlCard
@onready var card_inital_pos : Vector2 = pnl_card.position
@onready var choice_texts : Array[RichTextLabel] = [$rtlLeft, $rtlRight, $rtlUp]
@onready var rtl_title: RichTextLabel = $pnlCard/Control/VBoxContainer/rtlTitle
@onready var pnl_pic: PanelContainer = $pnlCard/Control/VBoxContainer/pnlPic
@onready var rect_bg : ColorRect = $pnlCard/Control/VBoxContainer/pnlPic/trectPortrait/rectBG
@onready var portrait_mat : ShaderMaterial = $pnlCard/Control/VBoxContainer/pnlPic/trectPortrait/rectBG.material
@onready var trect_portrait: TextureRect = $pnlCard/Control/VBoxContainer/pnlPic/trectPortrait
@onready var anim_player: AnimationPlayer = $animPlayer
@onready var pnl_stylebox : StyleBoxFlat = $pnlCard.get_theme_stylebox("panel")
@onready var rtl_lore: RichTextLabel = $pnlLore/rtlLore
@onready var pnl_lore: PanelContainer = $pnlLore

var portraits = [	#preload("uid://d0aqgef4xhl2l"),
					#preload("uid://dfdnaqkhqai8c"),
					#preload("uid://jh2qwycs2rd"),
					#preload("uid://djddjnv5hjxb3"),
					#preload("uid://dv77bhn6jpk66")
					preload("uid://cqj6wnt6ja5wb"),
					preload("uid://ltcuq17ipgf4"),
					preload("uid://cjqom6l11jsf4"),
					preload("uid://cqqjxidv2sjye")
					
					]

var is_dragging : bool = false
var text = ""
var tags = []
var choices : Array[Choice]
var card_target_pos : Vector2 = Vector2.ZERO
var pos_smoothing_factor : float = 0.25
var tagless_text = ""
var character_data = {}
var lines = []

func setup(story : InkPlayer):
	tags = []
	lines = []
	character_data = {}
	Global.current_swipeable = self
	if story.get_can_continue():
		
		var txt = story.continue_story()
		tags = story.get_current_tags().map(func(x): return str(x))
		
		lines.append(txt)
		print("Line = " + txt)
		while should_skip(story, txt, tags):
			
			txt = story.continue_story()
			var inner_tags = story.get_current_tags().map(func(x): return str(x))
			if inner_tags.size() > 0:
				tags.append(inner_tags[0])
			lines.append(txt)
		
	
		for line : String in lines:
			#line = line.replace("\n", "")
			#print("Line = " + line)
			if line.to_lower().ends_with("[lore]\n"):
				print("Found lore")
				character_data["lore"] = line.replace("[lore]", "")
			if line.to_lower().ends_with("[bio]\n"):
				print("Found bio")
				character_data["bio"] = line.replace("[bio]", "")
				#print("Found bio: " + line)
			if line.to_lower().ends_with("[title]\n"):
				print("Found title")
				character_data["title"] = line.replace("[title]", "")
			
		txt = txt.replace("[br]", "\n")
			
		tagless_text = Utils.text_without_tags(txt)
		if character_data.has("bio"):
			tagless_text = Utils.text_without_tags(character_data["bio"])
			rtl_story_text.text = Global.main.get_hunger_bbcode() + character_data["bio"]
		else:
			rtl_story_text.text = Global.main.get_hunger_bbcode() + txt
			print("No bio 1: [" + txt + "]")
		
		if character_data.has("lore"):
				tagless_text = Utils.text_without_tags(character_data["lore"])
				pnl_lore.visible = true
				rtl_lore.text = character_data["lore"]
		else:
			pnl_lore.visible = true
			rtl_lore.text = ""
	
		if character_data.has("lore"):
			#rtl_title.text =  Global.main.get_hunger_bbcode() + tags[0]
			rtl_title.text =  Global.main.get_hunger_bbcode()
			if character_data.has("title"):
				rtl_title.text += character_data["title"]
			else:
				rtl_title.text += Names.random_name()
			pnl_pic.visible = true
			rect_bg.self_modulate = Color(1, 1, 1, 1.0 - clampf((Utils.change_range(Global.main.get_humanity_delta(), 0.25, 0.75, 0, 1)), 0, 1))
			portrait_mat.set_shader_parameter("colour_1", Color(randf(), randf(), randf()))
			portrait_mat.set_shader_parameter("colour_2", Color(randf(), randf(), randf()))
			portrait_mat.set_shader_parameter("colour_3", Color(0, 0, 0))
			trect_portrait.texture = portraits.pick_random() 
			trect_portrait.flip_h = randf() > 0.5
			
			pnl_stylebox.bg_color = Color(randf_range(0.1, 0.4), randf_range(0.1, 0.4), randf_range(0.1, 0.4))
			
			
			
		else:
			pnl_stylebox.bg_color = Color(0.1, 0.1, 0.1)
			rtl_title.visible = false
			pnl_pic.visible = false
			print("No bio 2")
		
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
		rtl_lore.text = "done"
		
	rtl_lore.visible_characters = 0
	rtl_lore.visible_characters_behavior = TextServer.VC_CHARS_AFTER_SHAPING
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
		rtl_lore.visible_characters = rtl_lore.text.length()
		all_text_visible = true
		anim_player.seek(1.0, true)
		on_all_text_visible()

func _on_button_button_up() -> void:
	end_drag()

func die():
	queue_free()
	
func should_skip(story, txt : String, tags) -> bool:
	txt = str(txt).to_lower()
	#txt = txt.replace("\n", "")
	if (tags.size() > 0 and tags[0].to_lower().begins_with("dn_print")):
		if story.get_current_choices().size() > 0:
			story.choose_choice_index(0)
		return true
	if txt == "\n":
		return true
	if txt.ends_with("[bio]\n"):
		return true
	if txt.ends_with("[title]\n"):
		return true
	if txt.ends_with("[lore]\n"):
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
	if rtl_lore.visible_characters == tagless_text.length():
		if not all_text_visible:
			all_text_visible = true
			on_all_text_visible()
		return
	else:
		await Utils.await_char(tagless_text, text_index)
		if not all_text_visible:
			text_index += 1
			rtl_lore.visible_characters = text_index
			show_next_char()

func on_all_text_visible():
	
	anim_player.play("show_choices")
	choice_texts.map(func(rtl): 
			rtl.self_modulate = Color(1, 1, 1, 1))


func _on_btn_skip_button_down() -> void:
	skip()
