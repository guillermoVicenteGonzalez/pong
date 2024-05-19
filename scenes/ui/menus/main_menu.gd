extends Menu

@onready var options_menu: Control = %optionsMenu
@onready var main_menuparent: MarginContainer = %MainMenuparent


func _on_options_btn_button_down() -> void:
	main_menuparent.hide()
	options_menu.toggleVisible(true)
	pass # Replace with function body.


func _on_options_menu_back() -> void:
	main_menuparent.show()
	pass # Replace with function body.
