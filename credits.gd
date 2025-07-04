extends Node2D

@onready var sound = $sound

func _ready() -> void:
	pass 

func _on_voltar_pressed() -> void:
	sound.play
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
