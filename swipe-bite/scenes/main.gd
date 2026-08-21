extends Control

class_name Main

var swipeable_scene = preload("uid://burecohv2qxav")
var story : InkStory = preload("uid://bfe4vwfj67nkv")

@onready var rtl: RichTextLabel = $HBoxContainer/rtlStory
@onready var vbox_choices : VBoxContainer = $HBoxContainer/vboxChoices


func _ready() -> void:
	Global.main = self
	continue_story()

func continue_story():
	# Working on actual swipeables
	#story.ContinueMaximally()
	var swipeable : Swipeable = swipeable_scene.instantiate()
	add_child(swipeable)
	swipeable.setup(story)
	#var text = story.ContinueMaximally()
	##rtl.text = 
	##vbox_choices.get_children().map(func(x): x.queue_free())
	#
	#for choice : InkChoice in story.GetCurrentChoices():
		#var btn : Button = Button.new()
		#vbox_choices.add_child(btn)
		#btn.text = choice.GetText()
		#var on_pressed = func ():
			#story.ChooseChoiceIndex(choice.GetIndex())
			#continue_story()
		#btn.connect("pressed", on_pressed)
