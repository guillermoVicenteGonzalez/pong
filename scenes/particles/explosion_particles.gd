class_name ExplosionEffect

extends GPUParticles2D

signal effect_finished

@export var direction:Vector2

func setDirection(dir:Vector2):
	pass
	
func play():
	emitting = true
	await finished
	effect_finished.emit()
	queue_free()

