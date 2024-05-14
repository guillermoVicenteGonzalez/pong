extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fadeToBlack()->void:
	animation_player.play("fadeToBlack")
	await animation_player.animation_finished
	
func fadeFromBlack()->void:
	animation_player.play("fadeFromBlack")
	await animation_player.animation_finished

func playTransition(animationName:String)->void:
	var animList:PackedStringArray = animation_player.get_animation_list()
	if animList.has(animationName):
		animation_player.play(animationName)
		await animation_player.animation_finished
	
