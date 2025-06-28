extends Area2D
@onready var coinsound = $coinsound as AudioStreamPlayer2D
@onready var sprite = $sprite as AnimatedSprite2D

func _on_body_entered(_body:CharacterBody2D):
	coinsound.play()
	sprite.hide()
	await coinsound.finished
	print ("coinworking!!")
	queue_free()
	
