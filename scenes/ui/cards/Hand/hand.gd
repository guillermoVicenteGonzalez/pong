extends HBoxContainer

var CardUI = preload("res://scenes/ui/cards/CardUI/CardUI.tscn")
var cards:Array
enum state{
	idle,
	selected,
}

func _ready() -> void:
	for i in 5:
		var tempUI = CardUI.instantiate()
		print_debug(tempUI)
		add_child(tempUI)
		#self.add_child(tempUI)



