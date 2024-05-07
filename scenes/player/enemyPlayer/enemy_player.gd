extends Player


@onready var player_body: ColorRect = %playerBody

@export var speed:int = 300
@export_range(1,maxDiff) var difficulty

var safeRange:int
const maxDiff:int = 10
var diffMarg:int = 0

#========================================
# Lifecycle
#========================================

func _ready() -> void:
	#safeRange = player_body.size.y /4
	safeRange =calculateSafeMargin(difficulty,player_body.size.y)
	diffMarg = calculateDiffMargin(difficulty, maxDiff)
	pass
	
func _physics_process(delta: float) -> void:
	var ball:Ball = get_parent().get_node("ball")
	if ball:
		var ballPos:float = ball.position.y
		velocity = handleMovement(ballPos,speed)
	move_and_slide()

#========================================
# Movement
#========================================
func handleMovement(ballPos:float, speed:float)->Vector2:
	var direction = ballPos - position.y
	if direction > safeRange and randf() > diffMarg:
		return Vector2(0, speed)
	elif direction < -safeRange and randf() > diffMarg:
		return Vector2(0,speed) * -1
	else:
		return Vector2(0,0)

func handleSmoothMovement(ballPos:float) -> Vector2:
	return Vector2(0,ballPos - position.y)
	
#========================================
# Utility (Difficulty)
#========================================

#higher margin == less difficult
func calculateDiffMargin(diff:float, max:float)->float:
	if diff < 0:
		diff = 0
	elif diff > maxDiff:
		diff = maxDiff
	var temp:float = (max - diff)/10
	return temp

#more margin == more difficult (greater size margin)
func calculateSafeMargin(diff:int, size:float):
	return size/(diff/1.6)
	
#========================================
# EXPOSED (getters and setters)
#========================================

func setDifficulty(diff:int):
	difficulty = diff
	
