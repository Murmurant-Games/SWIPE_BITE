extends Node

class_name Choice

var ink_choice : InkChoice
var story : InkStory

func setup(_story : InkStory, _ink_choice : InkChoice):
	ink_choice = _ink_choice
	story = _story
	
func choose():
	story.ChooseChoiceIndex(ink_choice.GetIndex())
	Global.main.continue_story()

func get_text():
	return ink_choice.GetText()
