extends RigidBody2D

class_name Ball

@export var radius:int = 10
@export var speed:int = 300

@onready var ball_collision: CollisionShape2D = %ballCollision

var direction = 0
var reset:bool = false


func _ready():
	var shape:CircleShape2D = CircleShape2D.new()
	shape.radius = radius
	ball_collision.shape = shape
	gravity_scale = 0
	linear_velocity.x = speed * direction

func _physics_process(delta: float) -> void:
	linear_velocity.x = speed * direction
	
func _draw() -> void:
	draw_circle(Vector2(0,0),radius,Color(1,1,1))

func resetBall(position:Vector2)->void:
	direction = 0
	
func destroyBall():
	queue_free()

	
func startBall(flag:bool):
	if flag:
		direction = 1
	else:
		direction = -1

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		direction *=-1
	pass # Replace with function body.
