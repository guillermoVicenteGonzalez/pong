class_name Menu

extends Control

func goToScene(scene:String):
	if scene != null:
		#await LevelTransition.fadeToBlack() 
		get_tree().paused= false
		Engine.time_scale = 1
		get_tree().change_scene_to_file(scene)
		#await LevelTransition.fadeFromBlack()

func togglePause(flag:bool)->bool:
	if flag == null:
		get_tree().paused = not get_tree().paused
		toggleVisible(get_tree().paused)
	else:
		get_tree().paused = flag
		toggleVisible(flag)
	return get_tree().paused

func toggleVisible(flag:bool)->bool:
#await for animation
	if flag == null:
		if visible:
			hide()
		else:
			show()
	else:
		if flag:
			show()
		else:
			hide()
	return visible
