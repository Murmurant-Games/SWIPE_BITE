extends Control

class_name Eye

@onready var trect_white: TextureRect = $trectWhite
@onready var trect_retina: TextureRect = $trectWhite/trectRetina
@onready var retina_mat : ShaderMaterial = trect_retina.material
@onready var white_mat : ShaderMaterial = $trectWhite/trectRetina/ColorRect.material
@onready var retina_gradient : Gradient = trect_retina.texture.gradient
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var initial_pos = position
@onready var initial_scale_mult : float = randf_range(0.15, 0.25)


@export var left : float = -128
@export var right : float = 128
@export var up : float = -128
@export var down : float = 128

var heat_delta : float = 0.0
var prior_pos : Vector2 = Vector2.ZERO
var smoothing : float = 0.8
var heat_threshold = 0.5
var showing : bool = false
var mouse_over : bool = false
var pos_offset : Vector2 = Vector2.ZERO
var offset_mult : float = 1.0
var parallax_delta : float = 1.0
var heat = 0.0
var track_mult : float = 1.0

func _ready() -> void:
	smoothing = randf_range(0.75, 0.95)
	scale = Vector2(initial_scale_mult, initial_scale_mult)
	heat_threshold = randf_range(0.1, 0.9)
	offset_mult = Utils.change_range(initial_scale_mult, 0.15, 0.25, 0.75, 1.25)
	offset_mult = randf_range(0.75, 1.25)
	parallax_delta = randf_range(0.005, 0.015)
	smoothing = randf_range(0.025, 0.2)
	if randf() > 0.75:
		track_mult = -1
	
func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if showing and mouse_over:
			print("clicky")

func _process(delta: float) -> void:
	heat_delta = Global.main.get_heat_delta()
	var mouse_pos = trect_white.get_local_mouse_position()
	if heat <= 0.1:
		mouse_pos = Vector2.ZERO
	var mouse_delta_x = clampf(mouse_pos.x - 205, -32, 128)
	var mouse_delta_y = clampf(mouse_pos.y - 25, -32, 48)
	#print(mouse_pos.y)
	var target_pos = Vector2(mouse_delta_x, mouse_delta_y)
	
	if heat_delta >= 0.9:
		target_pos = Vector2(50, 12)
	
	
	trect_retina.position.x = lerpf(trect_retina.position.x, target_pos.x, smoothing)
	trect_retina.position.y = lerpf(trect_retina.position.y, target_pos.y, smoothing)
	
	var target_scale = initial_scale_mult
	if heat_delta >= 0.9:
		target_scale *= 1.5
		
		retina_gradient.set_offset(0, randf_range(0.05, 0.13))
		retina_gradient.set_offset(1, 0.146)
		retina_gradient.set_offset(3, randf_range(0.65, 0.723))
		retina_gradient.set_offset(4, randf_range(0.765, 0.8))
		white_mat.set_shader_parameter("spin_amount", 0.3)
	else:
		white_mat.set_shader_parameter("spin_amount", 1.0)
		
		retina_gradient.set_offset(4, 0.927)
		retina_gradient.set_offset(3, 0.902)
		retina_gradient.set_offset(1, 0.436)
		retina_gradient.set_offset(0, 0.318)
	target_scale = lerpf(scale.x, target_scale, smoothing)
	scale = Vector2(target_scale, target_scale)
	update_heat_visuals()
	update_parallax()
	shake()
	
	#position = lerp(position, position + (pos_offset * offset_mult), 1)
	#var secondary_pos = lerp(pos_offset * offset_mult, mouse_pos, dist_delta)
	position = lerp(position, (pos_offset * offset_mult), (parallax_delta))
	
	var dist = global_position.distance_to(get_global_mouse_position())
	var dist_delta = Utils.change_range(clampf(dist, 100, 900), 100, 900, 0.0, 0.1)
	var track_delta : float = 0.0
	track_delta = Utils.change_range(clampf(heat, 0.2, 0.8), 0.2, 0.8, 0.0, 1.0)
	var track_pos = lerp(global_position, get_global_mouse_position(), dist_delta)
	track_pos = lerp(global_position, track_pos, track_delta)
	global_position = lerp(global_position, track_pos, 0.25)
	#global_position = lerp(global_position, get_global_mouse_position(), dist_delta)
	
	
	pass

func update_parallax():
	var mouse_pos = get_global_mouse_position()
	var mouse_x_delta = Utils.change_range(clampf(mouse_pos.x, 0, 1152), 0, 1152, -1.0, 1.0)
	var mouse_y_delta = Utils.change_range(clampf(mouse_pos.y, 0, 658), 0, 658, -1.0, 1.0)
	#print(mouse_x_delta, mouse_y_delta)
	pos_offset.x = lerpf(initial_pos.x, initial_pos.x - 100, mouse_x_delta)
	pos_offset.y = lerpf(initial_pos.y, initial_pos.y - 60, mouse_y_delta)
	#pos_offset.y = lerpf(initial_pos.y, ctrl_eyes_start_pos.y - 15, mouse_y_delta)
	#ctrl_eyes.position = lerp(ctrl_eyes.position, ctrl_eyes_target_pos, 0.05)
	

func shake():
	var offset =  clampf(heat_delta - 0.5, 0, 0.5) * 2.5
	offset = randf_range(-offset, offset)
	if heat_delta >= 0.9:
		offset = 0
	pos_offset += Vector2(offset, offset)
	pass

func update_heat(_heat):
	heat = _heat

func update_heat_visuals():
	if heat >= heat_threshold and not showing:
		showing = true
		animation_player.play("show")
		#global_position = Vector2(0, 0)
		#trect_retina.self_modulate = Color(randf(), randf(), randf())
		retina_mat.set_shader_parameter("tint", Color(randf_range(0.5, 0.8), randf_range(0.5, 0.8), randf_range(0.5, 0.8)))
		#initial_pos = Vector2(randi_range(0, 1152), randi_range(0, 658))
	elif heat < heat_threshold and showing:
		showing = false
		animation_player.play("hide")
		
	if heat <= 0.1:
		pass
		global_position += Vector2(randi_range(-2, 2), randi_range(-2, 2))
