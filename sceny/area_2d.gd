extends Area2D
func _on_body_entered(body: Node2D) -> void:
	print("elo zelo")
	get_parent().game_over()

	
