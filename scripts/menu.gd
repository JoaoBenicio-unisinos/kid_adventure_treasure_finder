extends Control

@onready var sound = $SoundEffect as AudioStreamPlayer

func _on_start_button_pressed() -> void:
	sound.play()
	await sound.finished
	SceneTransition.transition()
	await SceneTransition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/Fase1.tscn")

func _on_quit_pressed() -> void:
	sound.play()
	get_tree().quit()


func _on_options_pressed() -> void:
	sound.play()
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	sound.play()
	pass # Replace with function body.
