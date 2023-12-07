extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var axis = Input.get_axis("left","right")
	
	if axis == 0:
		play("stand")
	elif $"..".is_on_floor():
		play("walk")
