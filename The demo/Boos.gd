extends KinematicBody2D

onready var BULLED_SCENE = preload("res://Ataka.tscn")

var player = null
var move = Vector2.ZERO
var speed = 1

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position)*speed
	else:
		move = Vector2.ZERO
		
	move - move.normalized()
	move = move_and_collide(move)
	
func _on_Area2D_body_entered(body):
	if body != self:
		player = body
		
func _on_Area2D_body_exited(body):
	player = null
	
	
func fire():
	var bulled = BULLED_SCENE.instance()
	bulled.position = get_global_position()
	bulled.player = player
	get_parent().add_child(bulled)
	$Timer.set_wait_time(1)
	
func _on_Timer_timeout():
	if player != null:
		fire()
