class_name Menu

extends Control

signal back

func goToScene(scene:String):
	if scene != null:
		await LevelTransitions.fadeToBlack()
		get_tree().paused= false
		Engine.time_scale = 1
		get_tree().change_scene_to_file(scene)
		await LevelTransitions.fadeFromBlack()
		
func goToPackedScene(scene:PackedScene):
	if scene != null:
		await LevelTransitions.fadeToBlack()
		get_tree().paused= false
		var err = get_tree().change_scene_to_packed(scene)
		await LevelTransitions.fadeFromBlack()
	else:
		print_debug("parameter scene is null")

func togglePause(flag:bool)->bool:
	if flag == null:
		get_tree().paused = not get_tree().paused
		toggleVisible(get_tree().paused)
	else:
		get_tree().paused = flag
		toggleVisible(flag)
	return get_tree().paused

func toggleVisible(flag:bool)->bool:
	print(flag)
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

func quitGame():
	get_tree().quit()
	
func changeSubMenu(newMenu:Menu):
	toggleVisible(false)
	newMenu.toggleVisible(true)
	pass
