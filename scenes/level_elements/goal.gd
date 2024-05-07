class_name Goal

extends Area2D

@onready var shape: CollisionShape2D = %shape

func setSize(height:int)->void:
	shape.shape.size.y = height

func setPosition(pos:Vector2)->void:
	global_position = pos
