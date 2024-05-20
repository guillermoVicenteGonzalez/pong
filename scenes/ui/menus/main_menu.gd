extends Menu

@onready var options_menu: Control = %optionsMenu
@onready var main_menuparent: MarginContainer = %MainMenuparent
@onready var normal_mode_menu: Menu = %normalModeMenu


func _on_options_btn_button_down() -> void:
	main_menuparent.hide()
	options_menu.toggleVisible(true)
	pass # Replace with function body.


func _on_options_menu_back() -> void:
	main_menuparent.show()
	pass # Replace with function body.


func _on_normal_mode_btn_button_down() -> void:
	main_menuparent.hide()
	normal_mode_menu.toggleVisible(true)
