extends Control

class_name MainMenu

@export var bg_col_a : Color = Color("5f0000")
@export var bg_col_b : Color = Color("000000")
@export var bg_col_c : Color = Color("000000")
@export var bgm_volume : float = 0.0
@export var glow_spin : float = 0.2
@export var dissolve : float = 1.0
@export var play_dissolve : float = 1.0

@onready var trect_title_main_glow: TextureRect = $trectTitleMainGlow
@onready var trect_title_main_shadow: TextureRect = $trectTitleMainShadow
@onready var trect_title_main: TextureRect = $trectTitleMain
@onready var anim_player : AnimationPlayer = $animPlayer
@onready var bg_shader_mat : ShaderMaterial = $PanelContainer/ColorRect.material
@onready var glow_shader_mat : ShaderMaterial = $trectTitleMainGlow/ColorRect.material
@onready var title_shader_mat : ShaderMaterial = $trectTitleMain.material
@onready var ctrl_eyes : Control = $ctrlEyes
@onready var eyes : Array = ctrl_eyes.get_children()
@onready var eye_time_offsets : Array = eyes.map(func(eye): return randf_range(0, 20))
@onready var eye_bools : Array = eyes.map(func(eye): return randf() > 0.5)
@onready var btn_play : Button = $btnPlay
@onready var btn_play_mat : ShaderMaterial = btn_play.material

@onready var ctrl_eyes_start_pos : Vector2 = ctrl_eyes.position
@onready var ctrl_eyes_target_pos : Vector2 = ctrl_eyes_start_pos
@onready var title_start_pos : Vector2 = trect_title_main.position
@onready var title_target_pos : Vector2 = title_start_pos

var entering_main : bool = false

func _ready() -> void:
	Global.main_menu = self
	entering_main = false

func _process(delta: float) -> void:
	if anim_player.is_playing():
		bg_shader_mat.set_shader_parameter("colour_1", bg_col_a)
		bg_shader_mat.set_shader_parameter("colour_2", bg_col_b)
		bg_shader_mat.set_shader_parameter("colour_3", bg_col_c)
		glow_shader_mat.set_shader_parameter("spin_amount", glow_spin)
		title_shader_mat.set_shader_parameter("dissolve_value", dissolve)
		btn_play_mat.set_shader_parameter("dissolve_value", play_dissolve)
		var max_vol = db_to_linear(-5.3)
		var current_vol = Utils.change_range(bgm_volume, 0.0, 1.0, 0.0, max_vol)
		AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("BGM"), current_vol)
		
	
	if visible:
		var mouse_pos = get_global_mouse_position()
		var mouse_x_delta = Utils.change_range(clampf(mouse_pos.x, 0, 1152), 0, 1152, -1.0, 1.0)
		var mouse_y_delta = Utils.change_range(clampf(mouse_pos.y, 0, 658), 0, 658, -1.0, 1.0)
		#print(mouse_x_delta, mouse_y_delta)
		ctrl_eyes_target_pos.x = lerpf(ctrl_eyes_start_pos.x, ctrl_eyes_start_pos.x - 25, mouse_x_delta)
		ctrl_eyes_target_pos.y = lerpf(ctrl_eyes_start_pos.y, ctrl_eyes_start_pos.y - 15, mouse_y_delta)
		ctrl_eyes.position = lerp(ctrl_eyes.position, ctrl_eyes_target_pos, 0.056)
		
		title_target_pos.x = lerpf(title_start_pos.x, title_start_pos.x - 10, mouse_x_delta)
		title_target_pos.y = lerpf(title_start_pos.y, title_start_pos.y - 5, mouse_y_delta)
		var title_target_rot = lerpf(0, 2, mouse_x_delta)
		var shadow_target_rot = lerpf(0, -15, mouse_x_delta)
		trect_title_main.position = lerp(trect_title_main.position, title_target_pos, 0.025)
		trect_title_main.rotation_degrees = lerp(trect_title_main.rotation_degrees, title_target_rot, 0.25)
		trect_title_main_shadow.rotation_degrees = lerp(trect_title_main_shadow.rotation_degrees, shadow_target_rot, 0.025)
		
		
		var index = 0
		var heat = 0
		for eye : Eye in eyes:
			if entering_main:
				heat = 0.0
			else:
				if eye_bools[index]:
					heat = Utils.change_range(sin((Time.get_ticks_msec() / 1000.0) + eye_time_offsets[index]), -1, 1, 0, 0.85)
				else:
					heat = Utils.change_range(cos((Time.get_ticks_msec() / 1000.0) + eye_time_offsets[index]), -1, 1, 0, 0.85)
			
			eye.update_heat(heat)
			index += 1
		

func _on_btn_play_pressed() -> void:
	if not entering_main:
		anim_player.play("EnterMain")
		entering_main = true
		await anim_player.animation_finished
		self.visible = false
		Global.start_game()
