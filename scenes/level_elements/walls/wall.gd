class_name Wall

extends StaticBody2D

@onready var collision: CollisionShape2D = %collision
@onready var shape: ColorRect = %shape


func setSize(size:float, pos:Vector2=Vector2(0,0))->Vector2:
	if collision == null || shape == null:
		return Vector2(0,0)
	else:
		shape.size.x = size
		collision.shape.size.x = size
		collision.shape.size.y = shape.size.y
		collision.position.x = size/2
	return shape.size

	
func setThickness(thickness:float)->float:
	#collision.size.y = thickness
	collision.shape.size.y = thickness
	shape.size.y = thickness
	return shape.size.y
	
func getThickness()->float:
	return shape.size.y

func setPosition(pos:Vector2)->Vector2:
	position = pos
	global_position = pos
	return position
	
func getSize()->Vector2:
	return shape.size
