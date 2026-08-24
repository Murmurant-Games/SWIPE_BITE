extends Node

var bg_audio : AudioStreamPlayer2D

func files_in_dir(path) -> Array:
	var dir = DirAccess.open(path)
	var filenames = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if (not dir.current_is_dir()):
				filenames.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return filenames

func folders_in_dir(path) -> Array:
	var dir = DirAccess.open(path)
	if dir:
		var folders = []
		for folder in dir.get_directories():
			folders.append(folder)
		return folders
	else:
		print("An error occurred when trying to access the path.")
		return []

func setup_bg_music():
	bg_audio = AudioStreamPlayer2D.new()
	add_child(bg_audio)
	bg_audio.max_distance = 150000
	bg_audio.volume_linear = 0.4
	bg_audio.panning_strength = 0
	bg_audio.set("parameters/looping", true)
	
func play_bg_music(stream):
	if not bg_audio:
		setup_bg_music()
	bg_audio.stream = stream
	bg_audio.play()
	
func is_bg_music_playing() -> bool:
	return bg_audio.playing
	
func stop_bg_music():
	bg_audio.stop()

func play_sound(stream, volume : float = 1.0, variance : float = 0.0, extra_pitch : float = 0.0):
	var audio = AudioStreamPlayer2D.new()
	add_child(audio)
	if variance != 0.0:
		audio.pitch_scale = randf_range(1.0 - (variance * 0.5), 1.0 + (variance * 0.5))
		audio.pitch_scale = audio.pitch_scale + extra_pitch
	audio.max_distance = 15000
	audio.panning_strength = 0
	audio.stream = stream
	audio.volume_linear = volume
	audio.play()
	await audio.finished
	audio.queue_free()
	
func play_sound_random(sound_array, variance : float = 0, extra_pitch : float = 0.0, volume : float = 1.0):
	if sound_array is Array and not sound_array.is_empty():
		play_sound(sound_array.pick_random(), volume, variance, extra_pitch)

func text_without_tags(_text : String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	return regex.sub(_text, "", true)
	
func await_char(_text, _text_index):
	if (_text_index - 1 >= 0):
		var char = _text[_text_index - 1]
		var wait_time = 0
		match char:
			"," : wait_time = 0.3  / (Global.text_speed / 100)
			"." : wait_time = 0.5 / (Global.text_speed / 100)
			"!" : wait_time = 0.35 / (Global.text_speed / 100)
			"?" : wait_time = 0.35 / (Global.text_speed / 100)
			":" : wait_time = 0.4 / (Global.text_speed / 100)
			"-" : wait_time = 0.15 / (Global.text_speed / 100)
			"—" : wait_time = 0.6 / (Global.text_speed / 100)
		await get_tree().create_timer(wait_time).timeout
		
func input(input_name : String, just_pressed : bool = false) -> bool:
	if just_pressed:
		return Input.is_action_just_pressed(input_name)
	else:
		return Input.is_action_pressed(input_name)

func int_to_mins_and_secs_str(secs) -> String:
	secs = int(secs)
	var mins = secs / 60
	var remainder = secs % 60
	if remainder < 10:
		remainder = "0" + str(remainder)
	else:
		remainder = str(remainder)
	var result : String = str(mins) + ":" + remainder
	return result

func free_children(node : Node):
	node.get_children().map(func(x): x.queue_free())
