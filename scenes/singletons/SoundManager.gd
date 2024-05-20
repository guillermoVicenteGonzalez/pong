extends Node

signal masterVolumeChanged
signal musicVolumeChanged
signal effectsVolumeChanged

var master_bus_index:int 
var music_bus_index:int
var effects_bus_index:int

var busDict
var eventDict = {
	"master":masterVolumeChanged, 
	"effects":effectsVolumeChanged, 
	"music":musicVolumeChanged
}

func _ready():
	var master_bus_index = AudioServer.get_bus_index("Master")
	var music_bus_index = AudioServer.get_bus_index("Music")
	var effects_bus_index = AudioServer.get_bus_index("Effects")
	
	busDict = {
		"master":master_bus_index,
		"effects":effects_bus_index,
		"music":music_bus_index
	}
	
	
func setBusVolume(name:String, nValue:float)->float:
	AudioServer.set_bus_volume_db(busDict[name],linear_to_db(nValue))
	eventDict[name].emit(nValue)
	return db_to_linear(AudioServer.get_bus_volume_db(busDict[name]))
	
func getBusVolume(name:String)->float:
	return db_to_linear(AudioServer.get_bus_volume_db(busDict[name]))
	
func getBusVolume_db(name:String)->float:
	return AudioServer.get_bus_volume_db(busDict[name])
	
func printBusValues()->void:
	for i in busDict:
		print(i + ": " + str(linear_to_db(AudioServer.get_bus_volume_db(busDict[i]))) + "\n")
		print(AudioServer.get_bus_volume_db(busDict[i]))
