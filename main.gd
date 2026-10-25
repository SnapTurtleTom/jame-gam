extends Node2D

@onready var health_bar: ProgressBar = $ui/HealthBar

const PLAYER_SCENE = preload("res://gnome.tscn")
var player_instant: Node

func _ready() -> void:
	player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	
	add_child(player_instant)
	$hatsmith.player = player_instant

func _physics_process(delta: float) -> void:
	if player_instant != null:
		health_bar.value = player_instant.current_health
