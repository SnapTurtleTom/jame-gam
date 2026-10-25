extends Node2D

@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var death_screen: CanvasLayer = $DeathScreen
@onready var respawn: Button = $DeathScreen/Respawn
