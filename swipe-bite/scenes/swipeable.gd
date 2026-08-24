extends Control

class_name Swipeable

@onready var rtl_story_text: RichTextLabel = $pnlCard/Control/rtlStoryText
@onready var pnl_card: PanelContainer = $pnlCard
@onready var card_inital_pos : Vector2 = pnl_card.position
@onready var choice_texts : Array[RichTextLabel] = [$rtlLeft, $rtlRight]

var is_dragging : bool = false
var text = ""
var choices : Array[Choice]
var card_target_pos : Vector2 = Vector2.ZERO
var pos_smoothing_factor : float = 0.25

func setup(story : InkStory):
	Global.current_swipeable = self
	if story.GetCanContinue():
		
		text = story.ContinueMaximally()
		rtl_story_text.text = text
		story.GetCurrentChoices().map(
			func(ink_choice : InkChoice):
				var choice : Choice = Choice.new()
				choice.setup(story, ink_choice)
				choices.append(choice))
		choice_texts.map(func(rtl): rtl.text = "")
		for index in choices.size():
			choice_texts[index].text = choices[index].get_text()
	else:
		rtl_story_text.text = "done"

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
	print(get_local_mouse_position())
	
func swipe_left():
	if choices.size() > 1:
		choices[1].choose()
		die()

func swipe_right():
	if choices.size() > 0:
		choices[0].choose()
		die()
	else:
		Global.goto_main_menu()
	
func _on_button_button_down() -> void:
	start_drag()

func _on_button_button_up() -> void:
	end_drag()

func die():
	queue_free()
