extends CharacterBody2D

@onready var player_body: ColorRect = %playerBody

@export var speed:int = 300
@export_range(1,10) var difficulty

var safeRange:int

func _ready() -> void:
	safeRange = player_body.size.y /4
	print_debug("safe range: " + str(safeRange))
	pass
	
func _physics_process(delta: float) -> void:
	var ball:Ball = get_parent().get_node("ball")
	if ball:
		var ballPos:float = ball.position.y
		velocity = handleMovement(ballPos,speed)
	move_and_slide()


func handleMovement(ballPos:float, speed:float)->Vector2:
	var direction = ballPos - position.y
	if direction > safeRange and randf() > .5:
		return Vector2(0, speed)
	elif direction < -safeRange and randf() > .5:
		return Vector2(0,speed) * -1
	else:
		return Vector2(0,0)

func handleSmoothMovement(ballPos:float) -> Vector2:
	return Vector2(0,ballPos - position.y)

