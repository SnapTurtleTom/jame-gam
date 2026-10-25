extends CharacterBody2D
class_name Player

@export var speed = 400
@onready var animated_sprite = $AnimatedSprite2D

var input_direction:= Vector2.ZERO
var last_direction:= Vector2.ZERO
var current_hat: Sprite2D = null
var current_health = 100
var parent: Node

func _ready():
	parent = self.get_parent()
	
	animated_sprite.play("forward-idle")
	
	for child in get_children():
		if child is Sprite2D:
			child.hide()

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction.length() > 0.05:
		last_direction = input_direction

func _physics_process(delta):
	if current_health <= 0:
		parent.current_hat_backup = current_hat
		remove_child(parent.current_hat_backup)
		parent.add_child(parent.current_hat_backup)
		queue_free()
		ui.death_screen.visible = true
	
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

func change_hat(new_hat, old_hat: Sprite2D):
	if old_hat != null:
		old_hat.hide()
	
	old_hat = new_hat
	old_hat.visible = true
	current_hat = new_hat
