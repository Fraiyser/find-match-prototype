extends Button

class_name Card

signal card_clicked(card: Card, card_value: String )


var card_value: String = ""
var is_opened: bool = false
var is_matched: bool = false


func validation():
	is_matched = true

func reveal():
	self.text = card_value

func Hide():
	self.text = "?"


func _on_pressed() -> void:
	is_opened = true
	card_clicked.emit(self, card_value)
