class_name Player

extends CharacterBody2D

@export var hit_sound:AudioStream
@export var player_res:playerResource
@onready var player_audio: AudioStreamPlayer = %playerAudio

func resetPosition(pos:int)->void:
	position.y = pos

func setPosition(pos:Vector2):
	position = pos

func setSize():
	pass
	
func setSpeed():
	pass


func _on_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		player_audio.play()

