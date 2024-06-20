extends Menu

@onready var back_btn: Button = %backBtn


func _ready() -> void:
	back_btn.button_down.connect(backToMain)
	
func backToMain():
	toggleVisible(false)
	back.emit()


func _on_save_btn_button_down() -> void:
	ConfigManager.saveFile()
	print_debug("file saved")
	pass # Replace with function body.
