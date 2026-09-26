extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0

var is_upside_down = false
var lock_change = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * -up_direction
	
	if is_on_floor() and lock_change:
		lock_change = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY if !is_upside_down else -JUMP_VELOCITY
	
	# Handle direction.
	if Input.is_action_just_pressed("direction") and not lock_change:
		is_upside_down = !is_upside_down
		up_direction = Vector2.DOWN if is_upside_down else Vector2.UP
		get_node("Sprite2D").rotation = PI if is_upside_down else 0
		if not is_on_floor():
			lock_change = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
