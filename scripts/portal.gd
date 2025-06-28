extends Area2D

@export var nextScene = ""
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(_body:CharacterBody2D):
	SceneTransition.transition()
	await SceneTransition.on_transition_finished
	get_tree().change_scene_to_file(nextScene)
	
