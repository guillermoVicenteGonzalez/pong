extends HSlider

## name of the audio bus the slider controls
@export var bus_name:String
var bus_index:int

func _ready() -> void:
	value = SoundManager.getBusVolume(bus_name)
	drag_ended.connect(valueChangeCB)
	pass
	
func valueChangeCB(nValue:float)->void:
	SoundManager.setBusVolume(bus_name,value)
