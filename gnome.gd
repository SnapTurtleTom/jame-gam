extends CharacterBody2D
class_name Player

@export var speed = 400
@onready var animated_sprite = $AnimatedSprite2D

var input_direction:= Vector2.ZERO
var last_direction:= Vector2.ZERO

func _ready():
	animated_sprite.play("forward-idle")

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction.length() > 0.05:
		last_direction = input_direction

func _physics_process(delta):
	get_input()
	if input_direction.length() <= 0.05:
		idle_animation(last_direction)
	else:
		movement_animation(input_direction)
	
	move_and_slide()

func idle_animation(input_direction: Vector2):
	if input_direction.y > 0:
		animated_sprite.play("forward-idle")
	elif input_direction.y < 0:
		animated_sprite.play("backwards-idle")
	elif input_direction.x > 0:
		animated_sprite.play("right-idle")
	elif input_direction.x < 0:
		animated_sprite.play("left-idle")

func movement_animation(input_direction: Vector2):
	if input_direction.y > 0:
		animated_sprite.play("forward-walk")
	elif input_direction.y < 0:
		animated_sprite.play("backwards-walk")
	elif input_direction.x > 0:
		animated_sprite.play("right-walk")
	elif input_direction.x < 0:
		animated_sprite.play("left-walk")
