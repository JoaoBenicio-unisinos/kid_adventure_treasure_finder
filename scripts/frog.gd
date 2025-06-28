extends Area2D

@onready var ribbit = $ribbit as AudioStreamPlayer2D
@onready var sprite = $sprite as AnimatedSprite2D

func _on_body_entered(_body:CharacterBody2D):
	ribbit.play()
	sprite.hide()
	print("Frog Found 1/4!")
	await ribbit.finished
	queue_free() 
