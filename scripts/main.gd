extends Node2D

const PLAYER_SCENE = preload("res://scenes/gnome.tscn")
var player_instant: Node

const UI_SCENE = preload("res://scenes/ui.tscn")
var ui_instant: Node

func _ready() -> void:
	player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	add_child(player_instant)
	
	ui_instant = UI_SCENE.instantiate()
	add_child(ui_instant)
	
	$hatsmith.player = player_instant

func _physics_process(delta: float) -> void:
	if player_instant != null and ui_instant != null:
		ui_instant.health_bar.value = player_instant.current_health
