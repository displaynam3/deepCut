extends StaticBody3D

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var collision: CollisionShape3D = $CollisionShape3D

var is_cut := false

func _ready():
	sprite.frame = 0
	sprite.stop()

func cut_vine():
	if is_cut:
		return

	is_cut = true
	sprite.frame = 1
	collision.disabled = true
