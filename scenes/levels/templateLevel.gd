extends Node2D

@onready var ballScene = preload("res://scenes/level_elements/ball/ball.tscn")

@export_category("Goals")
@export var player1_goal:Area2D
@export var player2_goal:Area2D	


@export_category("UI")
@export var score_hud:ScoreHUD

@export_subgroup("level settings")
@export var stage_center:Marker2D
@export_range(1,10) var difficulty
@export_range(1,10) var speed
@export var winCondition:int = 10

var player1_score:int = 0
var player2_score:int = 0
var ball:Ball

func _ready()->void:
	player1_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,true)
			resetLevel(body,false,stage_center.position)
	)
	player2_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,false)
			resetLevel(body,true,stage_center.position)
	)
	ball = createBall(stage_center.position)
	ball.startBall(false)

func scoreGoal(body:Node, flag:bool):
	if flag:
		player2_score +=1
		score_hud.setPlayerScore(player2_score,2)
	else:
		player1_score +=1
		score_hud.setPlayerScore(player1_score,1)


func resetLevel(ball:Ball, direction:bool, start_pos:Vector2)->void:
	ball.destroyBall()
	ball = createBall(start_pos)
	var timer:Timer = Timer.new()
	add_child(timer)
	score_hud.toggleMessage(true)
	for i in 3:
		score_hud.setMessage(str(3 - i))
		timer.start(1)
		await timer.timeout
	score_hud.toggleMessage(false)
	ball.startBall(direction)
	timer.queue_free()
	
func createBall(position:Vector2)->Ball:
	var b = ballScene.instantiate()
	b.setSpeed(300 * speed)
	add_child(b)
	b.global_position = position
	return b

