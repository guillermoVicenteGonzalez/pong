extends Menu

@onready var options_menu: Control = %optionsMenu
@onready var main_menuparent: MarginContainer = %MainMenuparent
@onready var normal_mode_menu: Menu = %normalModeMenu


func _ready():
	if normal_mode_menu == null:
		normal_mode_menu = load("res://scenes/ui/menus/normal_mode_menu.tscn").instantiate()
		normal_mode_menu.toggleVisible()
		add_child(normal_mode_menu)

func _on_options_btn_button_down() -> void:
	main_menuparent.hide()
	options_menu.toggleVisible(true)
	pass # Replace with function body.

#surely there is an obvious better way to handle this

func _on_options_menu_back() -> void:
	main_menuparent.show()


func _on_normal_mode_btn_button_down() -> void:
	main_menuparent.hide()
	normal_mode_menu.toggleVisible(true)


func _on_normal_mode_menu_back() -> void:
	main_menuparent.show()


func _on_quit_btn_button_down() -> void:
	quitGame()
