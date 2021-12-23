class_name CardData extends Reference

var points: int = 0
var level: int = 0
var color: Color
var cost: CardDataCost
var gem_color: Color

func _init(card_json):
	points = card_json['points']
	level = card_json['level']
	color = _get_color_from_string(card_json['color'])
	gem_color = _get_color_from_string(card_json['color'])
	cost = CardDataCost.new(card_json['cost'])

func _get_color_from_string(color_string) -> Color:
	if color_string == "white":
		return Color.white
	elif color_string == "blue":
		return Color.blue
	elif color_string == "green":
		return Color.green
	elif color_string == "red":
		return Color.red
	elif color_string == "black":
		return Color.blanchedalmond
	
	# Incorrect color, we messed up
	return Color.yellow
	

class CardDataCost extends Reference:
	
	var white: int = 0
	var blue: int = 0
	var green: int = 0
	var red: int = 0
	var black: int = 0
	var color_list =  []
	
	func _init(cost_json):
		white = cost_json['white']
		blue = cost_json['blue']
		green = cost_json['green']
		red = cost_json['red']
		black = cost_json['black']
		generate_color_list()
	
	func generate_color_list():
		add_tuple_to_list(color_list, white, Color.white)
		add_tuple_to_list(color_list, blue, Color.blue)
		add_tuple_to_list(color_list, green, Color.green)
		add_tuple_to_list(color_list, red, Color.red)
		add_tuple_to_list(color_list, black, Color.blanchedalmond)
	
	func add_tuple_to_list(tuple_list, color_int, color):
		if color_int != 0:
			tuple_list.append([color, color_int])
	
