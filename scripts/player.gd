extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -300.0
const JUMP_BUFF_TIME = 0.2
const COYOTE_TIME = 0.2
const FALL_GRAVITY = 1500
const GRAVITY = 1000
const DASH_SPEED = 400.0
const DASH_DURATION = 0.2

@onready var personagem = $personagem as AnimatedSprite2D
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var coyote_timer = $CoyoteTime

var dash_timer = 0.0
var jump_buffered = false 
var can_buffer = true #previne spam infinito de pulos 
var can_coyote_jump = false 
var dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	var current_gravity = FALL_GRAVITY if velocity.y >= 0 else GRAVITY
	if not is_on_floor():
		velocity.y += current_gravity * delta
	else:
		velocity.y = 0 
		
	if is_on_floor():
		velocity.y = 0
		can_dash = true
		can_buffer = true
		dashing = false
	# Handle jump.
	if not is_on_floor() and velocity.y < 0:  # If the character is jumping
			personagem.play("jump")  # Play jump animation if not already playing
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() || can_coyote_jump:
			velocity.y = JUMP_VELOCITY
			personagem.play("idle")
			print("floor jump working")
			if can_coyote_jump:
				can_coyote_jump = false
				coyote_timer.start()
				print("coyote jump is working")
				can_buffer = false
		if is_on_floor():
			can_dash = true
	 
		elif can_buffer:
			jump_buffered = true
			jump_buffer_timer.wait_time = JUMP_BUFF_TIME
			jump_buffer_timer.start()
			print("Jump buffered true")
			
	if Input.is_action_just_released("ui_accept") and velocity.y < 0 :
		velocity.y = JUMP_VELOCITY / 5
		
	if jump_buffered and (is_on_floor() or velocity.y > 0): #personagem caindo
		velocity.y = JUMP_VELOCITY
		jump_buffered = false
		can_buffer = false 
		
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		personagem.play("run")
		velocity.x = direction * SPEED
		personagem.flip_h = direction > 0  # True for left, false for right
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if personagem and personagem.is_playing():
			personagem.play ("idle")
			personagem.stop() 
			
	if not is_on_floor() and velocity.y < 0:
			personagem.play("jump")  # Play jump 
	
	if Input.is_action_just_pressed("dash") and is_on_floor() and can_dash :
		dashing = true
		can_dash = false
		dash_timer = DASH_DURATION
		velocity.x = DASH_SPEED * direction if direction != 0 else (1.0 if personagem.flip_h else -1.0) # Dash in facing direction
		print ("dashing is working guys")
		
	if dashing:
		dash_timer -= delta
		if dash_timer <= 0:  
			dashing = false
			velocity.x = SPEED * sign(velocity.x)
			
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor() and velocity.y >= 0 :
		can_coyote_jump = true
		coyote_timer.start(COYOTE_TIME)
		
		
func _on_coyote_time_timeout() -> void:
	can_coyote_jump = false
	
func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false 
	print("Jump buffer EXPIRED")
