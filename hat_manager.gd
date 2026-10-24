extends Node2D

var current_hat: Sprite2D = null

func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			child.hide()

func change_hat(new_hat, current_hat: Sprite2D):
	if current_hat != null:
		current_hat.hide()
	
	current_hat = new_hat
	current_hat.visible = true
