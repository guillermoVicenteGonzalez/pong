class_name ParticleEffect

extends GPUParticles2D

signal effect_finished

@export var direction:Vector2
@export var color1:Color
@export var color2:Color
## Specifies if the particles will die after the emition is finished
@export var dies:bool

func _ready() -> void:
	one_shot = dies


func setDirection(dir:Vector2):
	pass
	
func play():
	emitting = true
	await finished
	effect_finished.emit()
	if dies:
		queue_free()

func instantiateParticles(position:Vector2, parent:Node, direction:int=0):
	global_position = position
	if direction == 1:
		self.rotation_degrees = 180

	parent.add_child(self)
	self.play()
