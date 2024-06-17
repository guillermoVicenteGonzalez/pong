class_name Goal

extends Area2D

signal scored

@onready var shape: CollisionShape2D = %shape
@onready var explosion_sound: AudioStreamPlayer = %explosionSound

func setSize(height:int)->void:
	shape.shape.size.y = height

func setPosition(pos:Vector2)->void:
	global_position = pos


func onBallEnter(ball:Ball):
	explosion_sound.play()
	ball.destroyBall()
	scored.emit()
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		onBallEnter(body)
