extends AnimatedSprite2D

@export var horizontal_sway: Curve
@export var vertical_sway: Curve

@onready var initial_position := position

func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("move_forward"):
		var t := wrapf(Time.get_unix_time_from_system(), 0.0, 1.0)
		position = initial_position + Vector2(horizontal_sway.sample(t) * 50.0, -vertical_sway.sample(t) * 50.0)

	if Input.is_action_pressed("move_back"):
		var t := wrapf(Time.get_unix_time_from_system(), 0.0, 1.0)
		position = initial_position + Vector2(horizontal_sway.sample(t) * 50.0, -vertical_sway.sample(t) * 50.0)

	if Input.is_action_pressed("move_left"):
		var t := wrapf(Time.get_unix_time_from_system(), 0.0, 1.0)
		position = initial_position + Vector2(horizontal_sway.sample(t) * 50.0, -vertical_sway.sample(t) * 50.0)

	if Input.is_action_pressed("move_right"):
		var t := wrapf(Time.get_unix_time_from_system(), 0.0, 1.0)
		position = initial_position + Vector2(horizontal_sway.sample(t) * 50.0, -vertical_sway.sample(t) * 50.0)
	
