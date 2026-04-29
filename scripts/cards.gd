extends Node2D

@export var card_scene: PackedScene 
@onready var timer = $Timer

var cards_val : Array =["🐶", "🐶", "🐱", "🐱"]
var new_card : Array = []
var card_offset = 5
var first_card: Card = null
var second_card: Card = null


func card_creation():
	for i in range(cards_val.size()):
		var card:Card = card_scene.instantiate()
		card.card_value = cards_val[i]
		card.text = "?"
		card.card_clicked.connect(on_card_clicked)
		new_card.append(card)
		card.position = Vector2(card_offset, 5)
		add_child(card)
		card_offset +=70 

func on_card_clicked(card: Card, card_value: String):
	if card.is_matched == true:
		return
	if first_card and second_card != null:
		return
	
	if first_card == null:
		first_card = card
		card.reveal()
		return
	
	second_card = card
	card.reveal()
	
	if  first_card.card_value == second_card.card_value:
		first_card.validation()
		second_card.validation()
		
	timer.start()
	
	

func _ready() -> void:
	cards_val.shuffle()
	card_creation()


func _on_timer_timeout() -> void:
	if  first_card.card_value == second_card.card_value:
		first_card.visible = false
		second_card.visible = false
		first_card = null
		second_card = null
		check_win()
	elif  first_card.card_value != second_card.card_value:
		first_card.Hide()
		second_card.Hide()
		first_card = null
		second_card = null

func check_win():
	for card: Card in new_card:
		if not card.is_matched:
			return
	print("win")
