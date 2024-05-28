class_name PauseMenu

extends Menu

@onready var options_menu: Control = %optionsMenu
const MAIN_MENU:PackedScene = preload("res://scenes/ui/menus/main_menu.tscn")

var isVisible:bool = false

func _ready() -> void:
	visible = isVisible
	options_menu.back.connect(onOptionsMenuBack)
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		isVisible = togglePauseMenu(!isVisible)
		
## True means paused, false means unpaused
func togglePauseMenu(flag:bool)->bool:
	get_tree().paused = flag
	if flag:
		Engine.time_scale = 0
	else: 
		Engine.time_scale = 1
	toggleVisible(flag)
	return flag
	
func resumeGame():
	isVisible = togglePauseMenu(false)
	
func returnToMenu():
	#print_debug(MainMenu)
	goToPackedScene(MAIN_MENU)

	

#==========================
# EVENTS
#==========================

func onOptionsMenuBack():
	isVisible = togglePauseMenu(true)

#func _on_main_menu_btn_button_down() -> void:
	#print_debug("main menu")
	#returnToMenu()
#
#
#func _on_options_btn_button_down() -> void:
	#print_debug("options")
	#changeSubMenu(options_menu)
#
#
#func _on_resume_btn_button_down() -> void:
	#print_debug("resume")
	#resumeGame()


func _on_main_menu_btn_button_down() -> void:
	returnToMenu()


func _on_options_btn_button_down() -> void:
	changeSubMenu(options_menu)


func _on_resume_btn_button_down() -> void:
	print_debug("resume")
	resumeGame()
