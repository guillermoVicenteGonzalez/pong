class_name template_level

extends Node2D

@onready var ballScene = preload("res://scenes/level_elements/ball/ball.tscn")
@onready var enemy_player:  = $enemyPlayer


@export_category("Goals")
@export var player1_goal:Goal
@export var player2_goal:Goal

@export_category("UI")
@export var score_hud:ScoreHUD
@export var retry_menu:RetryMenu

@export_category("WALLS")
@export var wall_resource:PackedScene

@export_group("Camera")
#@export var mainCamera:PhantomCamera2D
@export var mainCamera:GameCamera

@export_group("level settings")
@export_range(1,10) var difficulty = 1
@export_range(1,10) var speed = 1
@export var winCondition:int = 10
@export var size: int = 10
@export var stageColor:Color

var player1_score:int = 0
var player2_score:int = 0
var ball:Ball
var players:Array
var topWall:Wall
var botWall:Wall
var stage_center:Vector2
var HSize:float
var VSize:float

const goal_timeout=2

#========================================
# LIFECYCLE
#========================================

func _ready()->void:
	setBgColor()
	players = get_tree().get_nodes_in_group("players") as Array[Player]
	size = setupDimensions(size)
	HSize = size
	VSize = size / 2
	enemy_player.setDifficulty(difficulty)
	stage_center = Vector2(HSize/2, VSize /2)
	generateStage(HSize, VSize)
	resetLevel( 1, stage_center)
	initializePlayersPos(players, HSize, VSize)
	player1_goal.scored.connect(
		func():
			scoreGoal(2)
	)
	
	player2_goal.scored.connect(
		func():
			scoreGoal(1)
	)


#========================================
# LEVEL SETUP
#========================================

func initiateLevel():
	setBgColor()
	players = get_tree().get_nodes_in_group("players") as Array[Player]
	size = setupDimensions(size)
	HSize = size
	VSize = size / 2
	player1_score = 0
	player2_score = 0
	score_hud.setPlayerScore(0,1)
	score_hud.setPlayerScore(0,2)
	enemy_player.setDifficulty(difficulty)
	stage_center = Vector2(HSize/2, VSize /2)
	generateStage(HSize, VSize)
	resetLevel( 1, stage_center)
	initializePlayersPos(players, HSize, VSize)


func createBall(position:Vector2)->Ball:
	var b = ballScene.instantiate()
	b.setSpeed(200 * speed)
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
	print_debug("zoom: " + str(z))
	var zoom = Vector2(z,z)
	mainCamera.setZoom(zoom)
	mainCamera.setPosition(screenCenter)

#========================================
# FUNCTIONALITY
#========================================

func scoreGoal(flag:int):
	var score:int
	await mainCamera.shake(5)
	if flag == 2:
		player2_score +=1
		score = player2_score
		score_hud.setPlayerScore(player2_score,2)
	elif flag == 1:
		player1_score +=1
		score = player1_score
		score_hud.setPlayerScore(player1_score,1)
		
	await get_tree().create_timer(goal_timeout).timeout
	if score == winCondition:
		gameOver(flag)
	else:
		resetLevel(1,stage_center)
		
	

func resetLevel(direction:int, start_pos:Vector2)->void:
	get_tree().paused = true
	initializePlayersPos(players, HSize, VSize) 
	get_tree().paused = true
	var ball = createBall(start_pos)
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
	retry_menu.toggleVisible(true)
	#game over menu

func calculateZoom(size:float)->float:
	var decrement = (size - 600)/100
	var rate = 0.07
	const baseZoom = 0.75
	
	if size > 1300:
		rate = 0.045
	
	return baseZoom - rate * decrement

#========================================
# Utility
#========================================

#========================================
# GETTERS AND SETTERS
#========================================

## Sets difficulty
func setDiff(nDif:int)->void:
	if nDif > 10:
		difficulty = 10
	elif nDif < 10:
		difficulty = nDif


		
func setSize(nSize:int)->void:
	size = nSize
	
func setSpeed(nSpeed:int)->void:
	speed = nSpeed
	
func setMaxGoals(nGoals:int)->void:
	winCondition = nGoals
	
#========================================
# DEBUG
#========================================
## Prints out size, ball speed and enemy difficulty
func _printParameters()->void:
	print_debug("level parameters")
	print("size: " + str(size))
	print("ball speed: " + str(speed))
	print("difficulty: " + str(difficulty))

func setBgColor(nColor:Color = Color.BLACK):
	RenderingServer.set_default_clear_color(nColor)

	
