class_name template_level

extends Node2D

@onready var ballScene = preload("res://scenes/level_elements/ball/ball.tscn")

@export_category("Goals")
@export var player1_goal:Goal
@export var player2_goal:Goal

@export_category("UI")
@export var score_hud:ScoreHUD

@export_category("WALLS")
@export var wall_resource:PackedScene

@export_group("Camera")
@export var mainCamera:PhantomCamera2D

@export_group("level settings")
@export_range(1,10) var difficulty
@export_range(1,10) var speed
@export var winCondition:int = 10
@export var size: int = 10

var player1_score:int = 0
var player2_score:int = 0
var ball:Ball
var players:Array
var topWall:Wall
var botWall:Wall
var stage_center:Vector2
var HSize:float
var VSize:float

#========================================
# LIFECYCLE
#========================================

func _ready()->void:
	players = get_tree().get_nodes_in_group("players") as Array[Player]
	size = setupDimensions(size)
	print_debug(size)
	HSize = size
	VSize = size / 2
	stage_center = Vector2(HSize/2, VSize /2)
	generateStage(HSize, VSize)
	resetLevel(ball, 1, stage_center)
	initializePlayersPos(players, HSize, VSize)
	print_debug(speed)
	
	player1_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,2)
			if player2_score == winCondition:
				gameOver(2)
			else:
				resetLevel(body,-1,stage_center)
	)
	player2_goal.body_entered.connect(
		func(body:Node):
			scoreGoal(body,1)
			if player1_score == winCondition:
				gameOver(1)
			else:
				resetLevel(body,1,stage_center)
	)
	#ball = createBall(stage_center)
	#ball.startBall(false)

#========================================
# LEVEL SETUP
#========================================

func createBall(position:Vector2)->Ball:
	var b = ballScene.instantiate()
	b.setSpeed(300 * speed)
	add_child(b)
	b.name="ball"
	b.global_position = position
	return b
	
func setupDimensions(size:int)->int:
	if size <= 600:
		return 600
	elif size >= 2000:
		return 2000
	return size
func generateStage(sizeX:int, sizeY:int)->void:
	var screenCenter = Vector2(sizeX/2, sizeY/2)
	var wallMargin = 100
	
	topWall = wall_resource.instantiate() as Wall
	add_child(topWall)
	topWall.setSize(sizeX + wallMargin)
	topWall.setPosition(Vector2(-wallMargin/2,0))
	
	botWall = wall_resource.instantiate() as Wall
	add_child(botWall)
	botWall.setSize(sizeX + wallMargin)
	botWall.setPosition(Vector2(-wallMargin/2,sizeY + botWall.getThickness()))
	
	player1_goal.setSize(sizeY)
	player1_goal.setPosition(Vector2(0 -50,screenCenter.y))
	
	player2_goal.setSize(sizeY)
	player2_goal.setPosition(Vector2(sizeX +50 ,screenCenter.y))
	
	var z:float = calculateZoom(sizeX)
	print_debug(z)
	var zoom = Vector2(z,z)
	mainCamera.zoom = zoom
	mainCamera.position = screenCenter

#========================================
# FUNCTIONALITY
#========================================

func scoreGoal(body:Node, flag:int):
	if flag == 2:
		player2_score +=1
		score_hud.setPlayerScore(player2_score,2)
	elif flag == 1:
		player1_score +=1
		score_hud.setPlayerScore(player1_score,1)

func resetLevel(ball:Ball, direction:int, start_pos:Vector2)->void:
	if ball != null:
		await ball.destroyBall() #we wait until the ball has exited the tree so that we can use the same name
	initializePlayersPos(players, HSize, VSize) 
	get_tree().paused = true
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
	get_tree().paused = false


func initializePlayersPos(players:Array, sizeX:float, sizeY:float):
	var middle = sizeY/2
	(players[0] as Player).setPosition(Vector2(0, middle))
	(players[1] as Player).setPosition(Vector2(sizeX,middle))

func gameOver(playerIndex:int):
	get_tree().paused = true
	score_hud.setMessage("player " + str(playerIndex) + " wins!!")
	score_hud.toggleMessage(true)

func calculateZoom(size:float)->float:
	var zoom =(size / 1000) - (size / 8000)
	if zoom < 0.1:
		return 0.1
	return (size / 1000) - (size / 8000)
	#return 1 - (size / 600)

#========================================
# GETTERS AND SETTERS
#========================================

func setDiff(nDif:int)->void:
	if nDif > 10:
		difficulty = 10
	elif nDif < 10:
		difficulty = 0
		
func setSize(nSize:int)->void:
	size = nSize
	
func setSpeed(nSpeed:int)->void:
	speed = nSpeed
