extends CharacterBody2D

@export var SPEED := 300
@export var JUMP_SPEED := -600
@export var GRAVITY := 1400
@onready var animplayer = $AnimatedSprite2D
var x_knockback = 0
const UP = Vector2(0,-1)
var attacking = false

func _get_input():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

	# Attack Input
	if Input.is_action_just_pressed("attack") and not attacking:
		_attack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var animation = "idle"

	if direction and not attacking:
		animation = "walk left"
		velocity.x = direction * SPEED
		if direction < 0:
			animplayer.flip_h = false
			x_knockback = -400
			$Area2D/AttackCol.position.x = -36
		else:
			animplayer.flip_h = true
			$Area2D/AttackCol.position.x = 86
			x_knockback = 400
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if animplayer.animation != animation and not attacking:
		animplayer.play(animation)


func _attack():
	$Area2D.monitoring = true
	attacking = true
	animplayer.play("attack")
	await animplayer.animation_finished
	attacking = false
	$attacksound.play()
	$Area2D.monitoring = false

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	_get_input()
	move_and_slide()


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body is RigidBody2D:
			$hitsound.play()
			body.apply_impulse(Vector2(x_knockback, -200))  # Example knockback effect
