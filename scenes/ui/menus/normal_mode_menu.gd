extends Menu

@export var levelFile:PackedScene
#@export var levelFile:String
@onready var diff_slider: HSlider = %diffSlider
@onready var speed_slider: HSlider = %speedSlider
@onready var size_slider: HSlider = %sizeSlider

var diff:int
var speed:int
var level_size:int

var levelScene:PackedScene


func _ready():
	#levelScene = load(levelFile)
	diff = diff_slider.value
	speed = speed_slider.value
	level_size = size_slider.value
	
	diff_slider.drag_ended.connect(func(value_changed:bool):
		print("im chaning. My current value is: " + str(diff_slider.value))
		diff = diff_slider.value
	)
	
	speed_slider.drag_ended.connect(func(value_changed:bool):
		speed = speed_slider.value
	)
	
	size_slider.drag_ended.connect(func(value_changed:bool):
		level_size = size_slider.value
	)

func playGame():
	print(diff)
	print(level_size)
	print(speed)
	var levelInstance:template_level  = levelFile.instantiate()
	await LevelTransitions.fadeToBlack()
	toggleVisible(false)
	levelInstance.setDiff(diff)
	levelInstance.setSize(level_size)
	levelInstance.setSpeed(speed)
	await get_tree().create_timer(.5).timeout
	LevelTransitions.fadeFromBlack()
	get_tree().root.add_child(levelInstance)
	get_tree().paused = false
	queue_free()




func _on_play_btn_button_down() -> void:
	playGame()
