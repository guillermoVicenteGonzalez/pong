class_name PauseMenu

extends Menu


@export var mainMenu:PackedScene
@onready var options_menu: Control = %optionsMenu

var isVisible:bool = false

func _ready() -> void:
	visible = isVisible
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		isVisible = togglePauseMenu(!isVisible)
		
func togglePauseMenu(flag:bool)->bool:
	get_tree().paused = flag
	if flag:
		Engine.time_scale = 0
	else: 
		Engine.time_scale = 1
	toggleVisible(flag)
	return flag
	
func resumeGame():
	isVisible = togglePauseMenu(true)
	
func returnToMenu():
	goToPackedScene(mainMenu)
	

#==========================
# EVENTS
#==========================

func _on_main_menu_btn_button_down() -> void:
	returnToMenu()


func _on_options_btn_button_down() -> void:
	changeSubMenu(options_menu)


func _on_resume_btn_button_down() -> void:
	resumeGame()
