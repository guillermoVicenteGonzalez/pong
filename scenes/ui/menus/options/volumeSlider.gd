extends HSlider

## name of the audio bus the slider controls
@export var bus_name:String
var bus_index:int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(valueChangeCB)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func valueChangeCB():
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
