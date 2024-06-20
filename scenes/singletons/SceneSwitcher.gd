class_name SceneSwitcher

extends Node

func changeScene(nScene:String, currentScene:Node=null)->int:
	var root = get_tree().root
	var nScenePacked:PackedScene = load(nScene)
	if !nScenePacked:
		return -1
		
	var instance:Node = nScenePacked.instantiate()
	if !instance:
		return -2
		
	if currentScene == null:
		currentScene = root.get_child(root.get_child_count()-1)

	root.add_child(instance)
	print_debug(currentScene)
	currentScene.queue_free()
	return 1
	
func changeSceneToPacked(nScene:PackedScene, currentScene:Node=null)->int:
	var root = get_tree().root
	var instance:Node = nScene.instantiate()
	if !instance:
		return -1
		
	if currentScene == null:
		currentScene = root.get_child(root.get_child_count()-1)
		print_debug(currentScene)
	print_debug(currentScene)
	root.add_child(instance)
	currentScene.queue_free()
	return 1
	
func changeSceneToInstance(nScene:Node, currentScene:Node=null)->int:
	var root = get_tree().root
	if currentScene == null:
		currentScene = root.get_child(root.get_child_count()-1)
	print_debug(currentScene)
	root.add_child(nScene)
	currentScene.queue_free()
	return 1
