extends Node

var config:ConfigFile

const audioBuses = ["master","effects","music"]
const filePath:String = "user://userSettings.cfg"


func _ready() -> void:
	config = ConfigFile.new()
	var err = config.load(filePath)
	if err != OK:
		setupConfigFile(config)
	else:
		loadConfigValues(config)
		SoundManager.printBusValues()

	SoundManager.masterVolumeChanged.connect(func(n:float):
		setBusVolumeConfig("master",n)
		pass
	)
	SoundManager.musicVolumeChanged.connect(func(n:float):
		setBusVolumeConfig("music",n)
		pass
	)
	SoundManager.effectsVolumeChanged.connect(func(n:float):
		setBusVolumeConfig("effects",n)
		pass
	)

func setupConfigFile(conf:ConfigFile):
	for i in audioBuses:
		conf.set_value("audio",i,1)
	conf.save(filePath)

func loadConfigValues(conf:ConfigFile):
	SoundManager.setBusVolume("master",conf.get_value("audio","master"))
	SoundManager.setBusVolume("music",conf.get_value("audio","music"))
	SoundManager.setBusVolume("effects",conf.get_value("audio","effects"))


func setBusVolumeConfig(name:String, v:float)->void:
	config.set_value("audio",name,SoundManager.getBusVolume(name))


func saveFile()->void:
	config.save("user://userSettings.cfg")
	
