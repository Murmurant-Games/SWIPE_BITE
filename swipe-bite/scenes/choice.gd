extends Node

class_name Choice

var ink_choice : InkChoice
var story : InkPlayer

func setup(_story : InkPlayer, _ink_choice : InkChoice):
	ink_choice = _ink_choice
	story = _story
	
func choose():
	story.choose_choice_index(ink_choice.index)
	#story.ChooseChoiceIndex(ink_choice.GetIndex())
	Global.main.continue_story()

func get_text():
	return ink_choice.text
