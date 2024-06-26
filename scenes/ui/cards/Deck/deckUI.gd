class_name DeckUI

extends Control

var deck:Deck

static func new_deckUI(nDeck:Deck)->DeckUI:
	var deck_ui_scene: = load("res://scenes/ui/cards/Deck/deckUI.tscn")
	var instance:DeckUI = deck_ui_scene.instantiate()
	instance.deck = nDeck
	return instance
