class_name RetryMenu

extends Menu

const MAIN_MENU:PackedScene = preload("res://scenes/ui/menus/main_menu.tscn")

func _ready():
	toggleVisible(false)

func retry():
	await LevelTransitions.fadeToBlack()
	var currentLevel = get_tree().get_first_node_in_group("Level")
	currentLevel.initiateLevel()
	toggleVisible(false)
	await LevelTransitions.fadeFromBlack()

func backToMain():
	#print_debug(MainMenu)
	Engine.time_scale = 1
	var currentLevel:Node2D = get_tree().get_first_node_in_group("Level")
	changeSceneToPacked(MAIN_MENU,currentLevel)
	get_tree().paused = false


func _on_replay_btn_button_down() -> void:
	print_debug("retrying?")
	retry()
	
func _on_back_btn_button_down() -> void:
	backToMain()
