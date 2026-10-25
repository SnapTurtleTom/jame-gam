extends Node2D

@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var death_screen: CanvasLayer = $DeathScreen
@onready var respawn: Button = $DeathScreen/Respawn
@onready var string_count: Label = $CanvasLayer/StringCount

var string_collected := 0

func _physics_process(delta: float) -> void:
	if string_collected != 0:
		string_count.text = str(string_collected)
