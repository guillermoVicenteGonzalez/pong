class_name GameCamera

extends Node2D

@export var cameraPos:Vector2 : set = setCameraPos
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var camera: PhantomCamera2D = %camera


func setCameraPos(value:Vector2):
	cameraPos = value
	if camera:
		camera.position = cameraPos

	#camera.position = pos

	pass

func shake(strength:int):
	animation_player.play("shake")
	await animation_player.animation_finished
	pass

func setZoom(nZoom:Vector2):
	camera.set_zoom(nZoom)
	pass

func setPosition(nPosition:Vector2):
	global_position = nPosition

