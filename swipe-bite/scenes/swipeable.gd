extends Control

class_name Swipeable

@export var portrait_dissolve : float = 1.0
@export var lore_tint : Color = Color(0.4, 0.2, 0.4)

@onready var rtl_story_text: RichTextLabel = $pnlCard/Control/VBoxContainer/rtlStoryText
@onready var pnl_card: PanelContainer = $pnlCard
@onready var card_inital_pos : Vector2 = pnl_card.position
@onready var choice_texts : Array[RichTextLabel] = [$rtlLeft, $rtlRight, $rtlUp]
@onready var rtl_title: RichTextLabel = $pnlCard/Control/VBoxContainer/rtlTitle
@onready var pnl_pic: PanelContainer = $pnlCard/Control/VBoxContainer/pnlPic
#@onready var rect_bg : ColorRect = $pnlCard/Control/VBoxContainer/pnlPic/PanelContainer/rectBG
@onready var portrait_mat : ShaderMaterial = pnl_card.material
@onready var trect_card_bg: TextureRect = $pnlCard/pnlCardBG/trectCardBG
@onready var card_bg_mat : ShaderMaterial = trect_card_bg.material
@onready var trect_portrait: TextureRect = $pnlCard/Control/VBoxContainer/pnlPic/TextureRect/trectPortrait
@onready var character_mat : ShaderMaterial = trect_portrait.material
@onready var anim_player: AnimationPlayer = $animPlayer
@onready var pnl_stylebox : StyleBoxFlat = $pnlCard.get_theme_stylebox("panel")
@onready var rtl_lore: RichTextLabel = $pnlLore/rtlLore
@onready var pnl_lore: PanelContainer = $pnlLore
@onready var mat_lore : ShaderMaterial = pnl_lore.material

var tex_humanity : Texture2D = preload("res://art/humanity.png")
var tex_hunger : Texture2D = preload("res://art/survived.png")
var tex_heat : Texture2D = preload("res://art/night.png")
var tex_night : Texture2D = preload("res://art/cat.png")
var tex_die : Texture2D = preload("res://art/died.png")
var tex_win : Texture2D = preload("res://art/win.png")

var card_bgs : Array = [
	preload("res://art/Card1.jpg"),
	preload("res://art/Card2.jpg"),
	preload("res://art/Card3.jpg"),
	preload("res://art/Card4.jpg"),
	preload("res://art/Card5.jpg"),
	preload("res://art/Card6.jpg")
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
var setting_up : bool = false

func setup(story : InkPlayer):
	setting_up = true
	tags = []
	lines = []
	character_data = {}
	var humanity_delta = Global.main.get_humanity_delta()
	mat_lore.set_shader_parameter("tint", lore_tint)
	Global.current_swipeable = self
	if story.get_can_continue():
		
		var txt = story.continue_story()
		tags = story.get_current_tags().map(func(x): return str(x))
		
		lines.append(txt)
		print("Line = " + txt)
		while should_skip(story, txt, tags):
			await RenderingServer.frame_post_draw
			txt = story.continue_story()
			var inner_tags = story.get_current_tags().map(func(x): return str(x))
			if inner_tags.size() > 0:
				tags.append(inner_tags[0])
			lines.append(txt)
		
	
		for line : String in lines:
			#line = line.replace("\n", "")
			#print("Line = " + line)
			var lower_line = line.to_lower()
			if lower_line.ends_with("[lore]\n"):
				#print("Found lore")
				character_data["lore"] = line.replace("[lore]", "")
			if lower_line.ends_with("[bio]\n"):
				#print("Found bio")
				character_data["bio"] = line.replace("[bio]", "")
				#print("Found bio: " + line)
			if lower_line.ends_with("[title]\n"):
				#print("Found title")
				character_data["title"] = line.replace("[title]", "")
			if lower_line.ends_with("[pronoun]\n"):
				#print("Found pronoun")
				character_data["pronoun"] = line.replace("[pronoun]", "")
			if lower_line.contains("[stats-avoid]"):
				character_data["avoid"] = line.replace("[stats-avoid]", "")
			if lower_line.contains("[stats-pursue]"):
				character_data["pursue"] = line.replace("[stats-pursue]", "")
			if lower_line.contains("[night]"):
				character_data["night"] = lower_line.replace("[night]", "")
				#print("Encountered night.")
			if lower_line.contains("[warning]"):
				line = line.replace("[warning]", "")
				character_data["warning"] = lower_line.replace("[warning]", "")
				#print("Encountered warning.")
			if lower_line.contains("[explainer]"):
				#line = line.replace("[explainer]", "")
				print("Encountered explain.")
			if lower_line.contains("[end]"):
				character_data["end"] = lower_line.replace("[end]", "")
				print("Found end")
				
			
			
		txt = txt.replace("[br]", "\n")
		txt = txt.replace("[explainer]", "")
		txt = txt.replace("[warning]", "")
		txt = txt.replace("[night]", "")
		txt = txt.replace("[end]", "")
			
		tagless_text = Utils.text_without_tags(txt)
		if character_data.has("bio"):
			tagless_text = Utils.text_without_tags(character_data["bio"])
			rtl_story_text.text = Global.main.get_hunger_bbcode() + character_data["bio"]
		else:
			rtl_story_text.text = Global.main.get_hunger_bbcode() + txt
			#print("No bio 1: [" + txt + "]")
		
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
			#rect_bg.self_modulate = Color(1, 1, 1, 1.0 - clampf((Utils.change_range(humanity_delta, 0.25, 0.75, 0, 1)), 0, 1))
			#rect_bg.self_modulate = Color(1, 1, 1, 1)
			portrait_mat.set_shader_parameter("colour_1", Color(randf(), randf(), randf()))
			portrait_mat.set_shader_parameter("colour_2", Color(randf(), randf(), randf()))
			portrait_mat.set_shader_parameter("colour_3", Color(0, 0, 0))
			card_bg_mat.set_shader_parameter("colors", 4)
			card_bg_mat.set_shader_parameter("tint", Color(randf_range(0.3, 0.7), randf_range(0.3, 0.7), randf_range(0.3, 0.7)))
			
			trect_card_bg.texture = card_bgs.pick_random()
			
			
			if character_data.has("pronoun"):
				#print("Fetching portrait with pronoun: " + str(character_data["pronoun"]))
				trect_portrait.texture = Portraits.get_portrait(character_data["pronoun"])
			else:
				trect_portrait.texture = Portraits.get_portrait()
			trect_portrait.flip_h = randf() > 0.5
			
			
			
			#pnl_stylebox.bg_color = Color(randf_range(0.1, 0.4), randf_range(0.1, 0.4), randf_range(0.1, 0.4))
			character_mat.get_shader_parameter("dissolve_texture").noise.seed = randi()
			
			
		else:
			pnl_stylebox.bg_color = Color(0.1, 0.1, 0.1)
			rtl_title.visible = false
			pnl_pic.visible = false
			#print("No bio 2")
		
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
			if character_data.has("warning"):
				
				var warning_line : String = character_data["warning"].to_lower()
				print("Has warning: " + warning_line)
				if warning_line.contains("attention"):
					print("Warning heat")
					trect_portrait.texture = tex_heat
				elif warning_line.contains("humanity"):
					print("Warning humanity")
					trect_portrait.texture = tex_humanity
				elif warning_line.contains("hungry"):
					print("Warning hunger")
					trect_portrait.texture = tex_hunger
				pnl_pic.visible = true
				card_bg_mat.set_shader_parameter("tint", Color(0.1, 0.1, 0.1))
				
			if character_data.has("night"):
				print("Nox est")
				trect_portrait.texture = tex_night
				pnl_pic.visible = true
				card_bg_mat.set_shader_parameter("colors", 4)
				card_bg_mat.set_shader_parameter("tint", Color(0.1, 0.1, 0.1))
			
			if character_data.has("end"):
				if Global.main.get_nights_lasted() >= 20:
					trect_card_bg.texture = tex_win
					card_bg_mat.set_shader_parameter("invert", false)
					card_bg_mat.set_shader_parameter("tint", Color(0.5, 0.5, 0.5))
				else:
					trect_card_bg.texture = tex_die
					card_bg_mat.set_shader_parameter("invert", false)
					card_bg_mat.set_shader_parameter("tint", Color(0.5, 0.5, 0.5))
					card_bg_mat.set_shader_parameter("colors", 3)
			
			else:
				#card_bg_mat.set_shader_parameter("tint", Color(0.1, 0.1, 0.1))
				card_bg_mat.set_shader_parameter("invert", true)
				#card_bg_mat.set_shader_parameter("colors", 4)
				
			
			current_choices.map(
				func(ink_choice : InkChoice):
					var choice : Choice = Choice.new()
					choice.setup(story, ink_choice)
					choices.append(choice))
			
		for index in choices.size():
			var choice_txt = choices[index].get_text()
			if choice_txt.begins_with("SPARE / AVOID"):
				choice_txt = "Avoid"
				if character_data.has("avoid"):
					choice_txt += "\n" + character_data["avoid"].replace(",", "\n").trim_suffix(" ")
			if choice_txt.begins_with("FEED / FACE"):
				choice_txt = "Pursue"
				if character_data.has("pursue"):
					choice_txt += "\n" + character_data["pursue"].replace(",", "\n")
					#choice_txt += "\n" + character_data["pursue"].replace(",", "\n").trim_suffix(" ")
			choice_texts[index].text = choice_txt
	else:
		rtl_lore.text = "done"
		
	rtl_lore.visible_characters = 0
	rtl_lore.visible_characters_behavior = TextServer.VC_CHARS_AFTER_SHAPING
	setting_up = false
	anim_player.play("show")
	await anim_player.animation_finished
	show_next_char()

func _process(delta: float) -> void:
	if is_dragging:
		var mouse_x_delta = (pnl_card.get_local_mouse_position().x - 125) / 400.0
		mouse_x_delta = clampf(mouse_x_delta, -1, 1)
		card_target_pos.x = card_inital_pos.x + lerpf(0, 200, mouse_x_delta)
		pnl_card.rotation_degrees = lerpf(0, 30, mouse_x_delta)
		
	else:
		card_target_pos.x = card_inital_pos.x
		pnl_card.rotation_degrees = 0
		
	pnl_card.position.x = lerpf(pnl_card.position.x, card_target_pos.x, pos_smoothing_factor)
	
	if anim_player.is_playing():
		character_mat.set_shader_parameter("dissolve_value", portrait_dissolve)
	
func start_drag():
	is_dragging = true

func end_drag():
	is_dragging = false
	var mouse_pos = pnl_card.get_local_mouse_position()
	mouse_pos.x -= 125
	if mouse_pos.x > -140 and mouse_pos.x < 140:
		pass
	elif mouse_pos.x < -140:
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
		anim_player.seek(2.0, true)
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
	if txt.ends_with("[stats-pursue]\n"):
		return true
	if txt.ends_with("[pronoun]\n"):
		return true
	#if txt.ends_with("[explainer]\n"):
		#return true
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
