extends CharacterBody2D

@export var gravity = 1200
@export var walk_speed = 300
@export var jump_speed = -400
@export var dash_speed = 750
@export var dash_duration = 0.2
@export var double_tap_time = 0.3  # Time interval to detect double tap

var doublejump = true
var dashing = false
var dash_time_left = 0.0
var last_left_tap = 0.0
var last_right_tap = 0.0


func _move() -> void:
	$dashsprite.visible = false
	$dashsprite.stop()
	$idlesprite.stop()
	$runsprite.visible = true
	$idlesprite.visible = false
	$runsprite.play()

func _idle() -> void:
	walk_speed = 300
	$attacksprite.stop()
	$attacksprite.visible = false
	$dashsprite.visible = false
	$dashsprite.stop()
	$idlesprite.visible = true
	$runsprite.visible = false
	$CrouchCollision.disabled = false
	$NormalCollision.disabled = true
	$CrouchSprite.visible = false
	$idlesprite.play()
	$runsprite.stop()

func _ready() -> void:
	$runsprite.visible = false
	$CrouchCollision.disabled = false
	$NormalCollision.disabled = true
	$CrouchSprite.visible = false
	$idlesprite.visible = true
	$idlesprite.play()
	
func _crouch() -> void:
	walk_speed = 100
	$CrouchCollision.disabled = true
	$NormalCollision.disabled = false
	$idlesprite.visible = false
	$idlesprite.stop()
	$runsprite.stop()
	$CrouchSprite.visible = true
	
func _dash() -> void:
	$CrouchSprite.visible = false
	$idlesprite.stop()
	$dashsprite.visible = true
	$idlesprite.visible = false
	$dashsprite.play()

func _physics_process(delta):
	# Apply gravity
	velocity.y += delta * gravity
	
	# Jumping logic
	if is_on_floor():
		doublejump = true
	if is_on_floor() and Input.is_action_just_pressed('jump'):
		velocity.y = jump_speed
	elif !is_on_floor() and Input.is_action_just_pressed('jump') and doublejump:
		velocity.y = jump_speed
		doublejump = false

	# Horizontal logic
	if dashing:
		_dash()
		dash_time_left -= delta
		if dash_time_left <= 0:
			dashing = false 
		
	else:
		var move_dir = 0
		if Input.is_action_just_pressed("ui_left"):
			if Time.get_ticks_msec() - last_left_tap < double_tap_time * 500:
				start_dash(-1)
			last_left_tap = Time.get_ticks_msec()
		
		
		if Input.is_action_just_pressed("ui_right"):
			if Time.get_ticks_msec() - last_right_tap < double_tap_time * 500:
				start_dash(1)
			last_right_tap = Time.get_ticks_msec()
	

		if Input.is_action_pressed("ui_left"):
			move_dir = -1
		elif Input.is_action_pressed("ui_right"):
			move_dir = 1

		if !dashing:
			velocity.x = move_dir * walk_speed if move_dir != 0 else 0
			if move_dir != 0 and !$CrouchSprite.visible:
				_move()
				$runsprite.flip_h = (move_dir > 0)
				$idlesprite.flip_h = (move_dir > 0)
				$CrouchSprite.flip_h = (move_dir > 0)
				$dashsprite.flip_h = (move_dir > 0)
			else:
				_idle()
			

	move_and_slide()
	
	# Crouching gLogic
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		_crouch()
	if Input.is_action_just_released("ui_down"):
		_idle()

#Dash
func start_dash(direction):
	dashing = true
	dash_time_left = dash_duration
	velocity.x = direction * dash_speed
