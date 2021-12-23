class_name Card extends Node2D

const CARD_RADIUS = 3
var CARD_POSITION = Vector2(20, 20)
const CARD_SIZE = Vector2(40, 60)
const COST_BOX_RADIUS = 10
const COST_BOX_SIZE = Vector2(15, 15)
const COST_BOX_OFFSET = Vector2(1, 27)
const COST_BOX_MARGIN = Vector2(2, 2)
const COST_LABEL_OFFSET = Vector2(4, 2)
const GEM_OFFSET = Vector2(18, 8)

onready var points_label = $Points

onready var cost1_label = $Cost1
onready var cost2_label = $Cost2
onready var cost3_label = $Cost3
onready var cost4_label = $Cost4

var card_color: Color
var gem_color: Color

var card_data: CardData

func custom_init(new_card_data: CardData):
	card_data = new_card_data
	update()
	
func _draw():
	card_color = card_data.color
	gem_color = card_data.gem_color
	
	# Draw Card
	var card_box = create_style_box(CARD_RADIUS, card_color)
	draw_style_box(card_box, Rect2(CARD_POSITION, CARD_SIZE))
	
	# Draw Gem
	draw_gem()
	
	# Setup points label
	var points_label_offset = Vector2.ONE * 3
	points_label.set_position(CARD_POSITION + points_label_offset)
	points_label.text = str(card_data.points)
	if card_data.points == 0:
		points_label.visible = false
	
	var positional_offset = Vector2(0, 0)
	
	cost1_label.visible = false
	cost2_label.visible = false
	cost3_label.visible = false
	cost4_label.visible = false
	
	for i in range(len(card_data.cost.color_list)):
		var color_cost = card_data.cost.color_list[i]
		# Top Row
		if i == 0:
			create_cost_box(color_cost, cost1_label, positional_offset)
		elif i == 1:
			positional_offset.x += COST_BOX_SIZE.x + COST_BOX_MARGIN.x
			create_cost_box(color_cost, cost2_label, positional_offset)
		
		# Bottom Row
		elif i == 2:
			positional_offset = Vector2(0, COST_BOX_SIZE.y + COST_BOX_MARGIN.y)
			create_cost_box(color_cost, cost3_label, positional_offset)
		elif i == 3:
			positional_offset.x += COST_BOX_SIZE.x + COST_BOX_MARGIN.x
			create_cost_box(color_cost, cost4_label, positional_offset)
	

func draw_gem():
	_draw_ruby_gem()

func _draw_ruby_gem():
	var points_arc = PoolVector2Array()
	
	# Create Ruby Gem
	points_arc.append(Vector2(0, 0))
	points_arc.append(Vector2(2, -2))
	points_arc.append(Vector2(6, -1))
	points_arc.append(Vector2(7, 1))
	points_arc.append(Vector2(3, 4))
	points_arc.append(Vector2(0, 0))
	
	for i in range(len(points_arc)):
		points_arc[i] *= Vector2.ONE * 3
		points_arc[i] += CARD_POSITION + GEM_OFFSET
	
	var colors = PoolColorArray([gem_color])
	draw_polygon(points_arc, colors)
	draw_polyline(points_arc, Color.black, 1.2, true)


func create_cost_box(color_tuple, label: Label, positional_offset: Vector2):
	var cost_box = create_style_box(COST_BOX_RADIUS, color_tuple[0])
	draw_style_box(cost_box, Rect2(CARD_POSITION + COST_BOX_OFFSET + positional_offset, COST_BOX_SIZE))
	label.set_position(CARD_POSITION + COST_BOX_OFFSET + COST_LABEL_OFFSET + positional_offset)
	label.text = str(color_tuple[1])
	label.visible = true
	

func create_style_box(radius: int, color: Color):
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(radius)
	style_box.bg_color = color
	
	return style_box

