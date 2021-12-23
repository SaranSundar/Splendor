class_name Main extends Node2D

var green_cards = []
var yellow_cards = []
var blue_cards = []

const card_scene = preload("res://scenes/Card/Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var cards_data = load_cards()
	create_cards(cards_data)


func load_cards():
	var file = File.new()
	var path = "assets/splendor.json"
	
	assert(file.file_exists(path), "ERROR: Splendor json file missing.")
	
	file.open(path, file.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	
	assert(len(data.cards) > 0, "ERROR: Splendor json file missing cards data.")
	
	return data.cards

func create_cards(cards_data: Array):
	
	for card_json in cards_data:
		var card_data = CardData.new(card_json)
		if card_data.level == 1:
			green_cards.append(card_data)
		elif card_data.level == 2:
			yellow_cards.append(card_data)
		elif card_data.level == 3:
			blue_cards.append(card_data)
			
	# Shuffle all the cards
	randomize()
	green_cards.shuffle()
	yellow_cards.shuffle()
	blue_cards.shuffle()
	
	var card_position = Vector2(Card.CARD_SIZE.x, 10)
	for i in range(4):
		var green_card = green_cards[i]
		var card = _create_card(card_position, green_card)
		card_position.x += (Vector2.ONE * 1.2 * Card.CARD_SIZE).x
		add_child(card)
	
	card_position = Vector2(0, Card.CARD_SIZE.y)
	for i in range(4):
		var yellow_card = yellow_cards[i]
		var card = _create_card(card_position, yellow_card)
		card_position.x += (Vector2.ONE * 1.2 * Card.CARD_SIZE).x
		add_child(card)
	
	card_position = Vector2(0, Card.CARD_SIZE.y * 2)
	for i in range(4):
		var blue_card = blue_cards[i]
		var card = _create_card(card_position, blue_card)
		card_position.x += (Vector2.ONE * 1.2 * Card.CARD_SIZE).x
		add_child(card)
	
# Only needs to be called whe displaying the UI
func _create_card(card_position, card_data: CardData)-> Card:
	var card: Card = card_scene.instance()
	card.custom_init(card_data)
	card.CARD_POSITION = card_position
	return card
