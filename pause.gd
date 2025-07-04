extends Control


@onready var sound = $SoundEffect as AudioStreamPlayer
var options_scene_path = "res://options.tscn"
var options_instance: Control = null

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("esc"):
			if get_tree().paused:
				sound.play()
				resume()
			else:
				sound.play()
				pause()

func resume():
	get_tree().paused = false
	sound.play()
	$blur.play ("bluranimback")
	visible = false
	
	
func pause():
	get_tree().paused = true
	sound.play()
	$blur.play ("bluranim")
	visible = true
	
func _on_resumir_pressed():
	sound.play()
	resume()
	
func _on_opcoes_pressed():
	sound.play()
	open_options()

func open_options():
	if options_instance == null:
		options_instance = load("res://options.tscn").instantiate()
		options_instance.back_requested.connect(close_options)  # Connect the back signal
		add_child(options_instance)
		visible = true  
		
func close_options():
	if options_instance:
		options_instance.queue_free()  # Remove the options menu from the scene
		options_instance = null  # Clear the reference
		visible = true  # Show the pause menu again

func _on_reiniciar_pressed():
	sound.play()
	get_tree().reload_current_scene()
	
func _on_sair_pressed():
	sound.play()
	get_tree().quit()
