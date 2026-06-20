extends CharacterBody3D

@export var speed: float = 5.0
@export var mouse_sensitivity: float = 0.003

@onready var hand_sprite: AnimatedSprite2D = $Camera3D/Control/HandSprite
@onready var interact_area: Area3D = $InteractArea

var nearby_vine = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	hand_sprite.animation_finished.connect(_on_hand_animation_finished)

	hand_sprite.stop()
	hand_sprite.animation = "swing"
	hand_sprite.frame = 0

	interact_area.body_entered.connect(_on_interact_area_body_entered)
	interact_area.body_exited.connect(_on_interact_area_body_exited)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)

func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if Input.is_action_pressed("move_back"):
		direction.z += 1

	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction = direction.normalized()

	var move_direction = transform.basis * direction

	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	velocity.y = 0

	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		swing_knife()

func swing_knife():
	hand_sprite.stop()
	hand_sprite.frame = 0
	hand_sprite.play("swing")

	if nearby_vine != null:
		nearby_vine.cut_vine()

func _on_hand_animation_finished():
	hand_sprite.stop()
	hand_sprite.frame = 0

func _on_interact_area_body_entered(body):
	if body.has_method("cut_vine"):
		nearby_vine = body

func _on_interact_area_body_exited(body):
	if body == nearby_vine:
		nearby_vine = null
