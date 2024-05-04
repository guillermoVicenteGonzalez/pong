extends Node2D

@onready var ballScene = preload("res://scenes/level_elements/ball/ball.tscn")

@export_category("Goals")
@export var player1_goal:Area2D
@export var player2_goal:Area2D	

#this should be its own node with a script
@export_category("UI")
@export var player1_label:Label
@export var player2_label:Label
@export var message_board:Label

@export_subgroup("level settings")
@export var stage_center:Marker2D
@export_range(1,10) var difficulty
@export_range(1,10) var speed
@export var winCondition:int = 10

var player1_score:int = 0
var player2_score:int = 0
#var ballScene:PackedScene
var ball:Ball

func _ready()->void:
	player1_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,true)
			resetLevel(message_board,body,false,stage_center.position)
	)
	#player2_goal.body_entered.connect(scoreGoal.bind(false))
	player2_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,false)
			resetLevel(message_board,body,true,stage_center.position)
	)

	ball = ballScene.instantiate()
	add_child(ball)
	ball.startBall(true)
	#ball = get_tree().get_first_node_in_group("ball")


func scoreGoal(body:Node, flag:bool):
	if flag:
		player2_score +=1
		player2_label.text = str(player2_score)
	else:
		player1_score +=1
		player1_label.text = str(player1_score)


func resetLevel(label:Label, ball:Ball, direction:bool, start_pos:Vector2)->void:
	ball.destroyBall()
	ball = createBall()
	print_debug(ball)
	var timer:Timer = Timer.new()
	add_child(timer)
	timer.start(3)
	await timer.timeout
	ball.startBall(direction)
	timer.queue_free()
	
func createBall()->Ball:
	var b = ballScene.instantiate()
	add_child(b)
	return b

