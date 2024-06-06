class_name Ball

extends RigidBody2D

@export var explosion:PackedScene

@export var radius:int = 10
@export var speed:int = 300
@export var color:Color = Color(1,1,1)

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
	print("color")
	draw_circle(Vector2(0,0),radius,color)

func resetBall(position:Vector2)->void:
	direction = 0
	
func destroyBall():
#animacion	
	var particles:ExplosionEffect = explosion.instantiate()
	particles.position = global_position
	if direction == 1:
		particles.rotation_degrees = 180
	#particles.rotation = global_rotation
	get_tree().root.add_child(particles)
	particles.play()
	direction = 0
	linear_velocity.x = 0
	queue_free()
	await tree_exited

func setSpeed(num:int):
	speed = num
	
func startBall(dir:int):
	if dir >= 0:
		direction = 1
	else:
		direction = -1

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		direction *=-1
	pass # Replace with function body.


