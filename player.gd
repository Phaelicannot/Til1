extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -180.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * .5

	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction < 0:
		$AnimatedSprite2D.scale.x = -1
	if direction > 0:
		$AnimatedSprite2D.scale.x = 1
	if direction:
		velocity.x = direction * SPEED
	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x *= .6
		
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		var mus = get_global_mouse_position()# + $Camera2D.global_position
		var tile = $"../TileMap".local_to_map(mus)
		if $"../TileMap".get_cell_source_id(0, tile) != -1:
			return
		var block_rect = Rect2($"../TileMap".map_to_local(tile) - Vector2($"../TileMap".tile_set.tile_size) / 2, $"../TileMap".tile_set.tile_size)
		var coll_shape = $CollisionShape2D.shape.get_rect()
		coll_shape.position += global_position
		if coll_shape.intersects(block_rect):
			print($CollisionShape2D)
			print("cannot build")
			return
		$"../TileMap".set_cell(0, tile, 2, Vector2i(1,1))
		print(tile)
		await get_tree().create_timer(3).timeout
		$"../TileMap".erase_cell(0,tile)
