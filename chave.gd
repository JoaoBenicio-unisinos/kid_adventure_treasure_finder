extends Area2D

#@onready var ribbit = $ribbit as AudioStreamPlayer2D
@onready var sprite = $sprite as AnimatedSprite2D

func _on_body_entered(_body:CharacterBody2D):
#	ribbit.play()
	sprite.hide()
	Global.chave = true
	print("key found")
#	await ribbit.finished
	queue_free() 
