extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Frog Found 1/4!")
	queue_free()
