extends Menu

@export var levelFile:PackedScene

@onready var diff_slider: HSlider = %diffSlider
@onready var speed_slider: HSlider = %speedSlider
@onready var size_slider: HSlider = %sizeSlider
@onready var max_goals_input: SpinBox = %maxGoals

var diff:int 
var speed:int
var level_size:int 
var maxGoals:int

var levelScene:PackedScene


func _ready():
	diff = diff_slider.value
	speed = speed_slider.value
	level_size = size_slider.value
	maxGoals = max_goals_input.value
	
	max_goals_input.value_changed.connect(func(value_changed:float):
		maxGoals = max_goals_input.value
	)
	
	diff_slider.drag_ended.connect(func(value_changed:bool):
		diff = diff_slider.value
	)
	
	speed_slider.drag_ended.connect(func(value_changed:bool):
		speed = speed_slider.value
	)
	
	size_slider.drag_ended.connect(func(value_changed:bool):
		level_size = size_slider.value
	)



func playGame():
	var levelInstance:template_level = levelFile.instantiate()
	await LevelTransitions.fadeToBlack()
	levelInstance.setDiff(diff)
	levelInstance.setSize(level_size)
	levelInstance.setSpeed(speed)
	levelInstance.setMaxGoals(maxGoals)
	Scene_Switcher.changeSceneToInstance(levelInstance)
	await LevelTransitions.fadeFromBlack()
	
	
func _on_play_btn_button_down() -> void:
	playGame()


func _on_back_btn_button_down() -> void:
	toggleVisible(false)
	back.emit()
	pass # Replace with function body.
