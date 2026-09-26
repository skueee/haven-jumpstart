extends Node


func _on_world_border_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://gameover.tscn")


func _on_won_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://won.tscn")
