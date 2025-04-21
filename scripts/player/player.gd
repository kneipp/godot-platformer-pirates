extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 90
const JUMP_FORCE = -300
const GRAVITY = 900

var direction :
	get: return direction
	set(value):
		if value == 0 or value == direction: return
		direction = value
		sprite.flip_h = value == -1

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("btn_left", "btn_right")	
	direction = x_input
	
	if Input.is_action_just_pressed("btn_jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		sprite.play("jump")
	elif not is_on_floor() and velocity.y >= 0:
		sprite.play("fall")
	elif x_input == 0 and is_on_floor():
		sprite.play("idle")
	else:
		sprite.play("run")
		
	velocity.x = x_input * 90
	velocity.y += GRAVITY * delta
	move_and_slide()
	
