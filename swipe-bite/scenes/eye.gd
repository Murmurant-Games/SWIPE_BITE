extends Control

class_name Eye

@onready var trect_white: TextureRect = $trectWhite
@onready var trect_retina: TextureRect = $trectWhite/trectRetina
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

func _ready() -> void:
	smoothing = randf_range(0.75, 0.95)
	scale = Vector2(initial_scale_mult, initial_scale_mult)
	heat_threshold = randf_range(0.1, 0.9)
	

func _process(delta: float) -> void:
	heat_delta = Global.main.get_heat_delta()
	var mouse_pos = get_local_mouse_position()
	#var angle = trect_retina.position.angle_to_point(mouse_pos)
	#var dist = trect_retina.position.distance_to(mouse_pos)
	#
	##(angle * dist)
	#var target = trect_retina.position.move_toward((angle * dist), 1.0)
	#trect_retina.position = target
	#print(rad_to_deg(trect_retina.position.angle_to_point(mouse_pos)))
	var mouse_delta_x = clampf(mouse_pos.x - 205, -32, 128)
	var mouse_delta_y = clampf(mouse_pos.y - 25, -32, 48)
	#print(mouse_pos.y)
	var target_pos = Vector2(mouse_delta_x, mouse_delta_y)
	if heat_delta >= 0.9:
		target_pos = Vector2(50, 12)
		
	trect_retina.position.x = lerpf(trect_retina.position.x, target_pos.x, 1.0 - smoothing)
	trect_retina.position.y = lerpf(trect_retina.position.y, target_pos.y, 1.0 - smoothing)
	#trect_retina.position.x = mouse_delta_x
	#trect_retina.position.y = mouse_delta_y
	
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
	
	shake()
	pass

func shake():
	var offset =  clampf(heat_delta - 0.5, 0, 0.5) * 2.5
	offset = randf_range(-offset, offset)
	if heat_delta >= 0.9:
		offset = 0
	position = initial_pos + Vector2(offset, offset)
	pass

func update_heat(heat):
	if heat >= heat_threshold and not showing:
		showing = true
		animation_player.play("show")
		position = Vector2(randi_range(0, 1152), randi_range(0, 658))
	elif heat < heat_threshold and showing:
		showing = false
		animation_player.play("hide")
		
	
		
	pass
