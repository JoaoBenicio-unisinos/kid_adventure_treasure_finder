extends Control

signal back_requested

@onready var sound = $SoundEffect as AudioStreamPlayer
var options_instance: Control = null  # Reference to the options menu instance

func _on_start_button_pressed() -> void:
	sound.play()
	SceneTransition.transition()
	await SceneTransition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/Fase1.tscn")

func _on_quit_pressed() -> void:
	sound.play()
	get_tree().quit()

func _on_options_pressed() -> void:
		sound.play()
		var options_instance = load("res://options.tscn").instantiate()
		assert(options_instance.has_signal("back_requested"), "Options scene missing signal!")
		options_instance.back_requested.connect(_on_back_requested)
		add_child(options_instance)
		visible = true  # Hide main menu

func _on_back_requested() -> void:
		sound.play()
		visible = true  # Show main menu
	# Remove options scene
		for child in get_children():
			if child.name == "Options":
				child.queue_free()

func _on_credits_pressed() -> void:
	sound.play()
	get_tree().change_scene_to_file("res://credits.tscn")
	pass # Replac
