extends CharacterBody2D

@export var player_res:playerResource

var direction:Vector2

func _physics_process(delta: float) -> void:
	direction.y = Input.get_axis("up","down")

	velocity = handleMovement(direction, player_res.speed)
	move_and_slide()

func handleAccMovement(dir:Vector2, speed:int, acc:int, vel:Vector2, delta:float)->Vector2:
	var v:Vector2 = vel.move_toward(dir * speed, delta * player_res.acc)
	return v

func handleMovement(dir:Vector2, speed:int)->Vector2:
	var v:Vector2 = speed * dir
	return v
