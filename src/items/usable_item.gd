extends "item.gd"

var player
var max_quantity
var keep
var in_flight = false # helper variable for inventory

func effect():
	return true

func use():
	if quantity > 0:
		if effect():
			quantity -= 1

func _init(_player, _icon, _name, _quantity, _max_quantity, _rarity, _keep=false).(_icon, _name, _rarity, _quantity):
	player = _player
	max_quantity = _max_quantity
	rarity = _rarity
	keep = _keep

func clone():
	return get_script().new(player, icon, name, quantity, max_quantity, rarity, keep)

func add(n):
	# returns how many items can't be added due to max_quantity limit
	var max_n = max_quantity - quantity
	if n <= max_n:
		quantity += n
		return 0
	quantity += max_n
	return n - max_n

func set_label_color(label):
	if quantity >= max_quantity:
		label.add_color_override("font_color", Color(1, 0, 0))
		label.add_color_override("font_color_shadow", Color(0, 0, 0, 0))
	else:
		label.add_color_override("font_color", Color(1, 1, 1))
		label.add_color_override("font_color_shadow", Color(0.2, 0.2, 0.2))