extends Area2D

@onready var abrir = $abrir as AnimatedSprite2D
@onready var timer: Timer = $Timer

func _on_body_entered(_body:CharacterBody2D):
	if Global.chave == true:
		Global.abriu = true
		abrir.play("abrir")
		$Timer.start(2)

func _on_timer_timeout() -> void:
		queue_free()
