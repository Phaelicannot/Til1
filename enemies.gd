extends CharacterBody2D


var speed = 300.0
var posX = 0
var posY = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	var enemy_shape = $CollisionShape2D.shape.get_rect()
	var player_shape = $"../player/CollisionShape2D".shape.get_rect()
	position.x = posX
	position.y = posY
	if enemy_shape.intersects(player_shape):
		posX = randf_range(10, 100)
		posY = randf_range(0, 10)
		
	#var player = $"../player"
	#var movement = position - player.position 
	#var velocity = movement * speed
	#speed += delta
	#move_and_slide()
