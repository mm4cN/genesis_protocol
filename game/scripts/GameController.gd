extends Node2D

@onready var grid: HexGrid = $"../HexGrid"
@onready var deck: Deck = $"../Deck"

var hand: Array[Card] = []
var turn: int = 0

# global metrics
var g_order: int = 0
var g_entropy: int = 0
var g_coherence: int = 0
var g_growth: int = 0

func _ready() -> void:
	deck.load_universal_pool()
	_start_run()

func _start_run() -> void:
	turn = 0
	hand = deck.draw(3)
	_update_ui()
	
func _play_selected_card(tile: Tile) -> void:
	# safety
	if selected_card == null:
		return

	match selected_card.principle:
		Tile.Principle.FRACTURE:
			tile.set_principle(Tile.Principle.FRACTURE, true)

			for n in tile.neighbors_axial():
				var nt = grid.get_tile(n.x, n.y)
				if nt and nt.principle != Tile.Principle.NONE:
					nt.stability = max(nt.stability - 1, 0)
			g_coherence = max(g_coherence - 10, 0)
			g_entropy = clamp(g_entropy + 1, 0, 100)
			g_growth = clamp(g_growth + 1, 0, 100)

		Tile.Principle.DISSOLUTION:
			tile.clear_tile()
			_affect_neighbors_after_dissolution(tile)
		_:
			tile.set_principle(selected_card.principle, true)
			tile.stability = max(tile.stability, 10)

	# remove played card
	var idx := hand.find(selected_card)
	if idx != -1:
		hand.remove_at(idx)

	# draw card
	hand.append_array(deck.draw(1))

	# reset + UI refresh
	selected_card = null
	_update_ui()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var clicked: Tile = _pick_tile(get_global_mouse_position())
		if clicked != null and selected_card != null:
			_play_selected_card(clicked)
			_world_tick()
			_end_turn()

func _pick_tile(mouse_pos: Vector2) -> Tile:
	var nearest: Tile = null
	var best: float = INF
	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t == null:
			continue
		var d: float = t.global_position.distance_to(mouse_pos)
		if d < best and d < 40.0:
			best = d
			nearest = t
	return nearest

func _play_first_card(tile: Tile) -> void:
	if hand.is_empty():
		hand = deck.draw(1)
	var card: Card = hand.pop_front() as Card
	match card.principle:
		Tile.Principle.DISSOLUTION:
			tile.clear_tile()
			_affect_neighbors_after_dissolution(tile)
		_:
			tile.set_principle(card.principle, true)
			tile.stability = max(tile.stability, 10)
	hand.append_array(deck.draw(1))

func _world_tick() -> void:
	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t == null:
			continue
		if t.principle == Tile.Principle.NONE:
			t.age = 0
			continue
		t.age += 1
		match t.principle:
			Tile.Principle.FORM:
				t.stability = clamp(t.stability + 1, 0, 100)
			Tile.Principle.TIME:
				# 25% chance for repetition
				if randi() % 4 == 0:
					t.intensity = clamp(t.intensity + 1, 1, 5)
			Tile.Principle.ENTROPY:
				t.stability = max(t.stability - 1, 0)
			Tile.Principle.GROWTH:
				if randi() % 5 == 0: # ~20%
					_try_spread_growth(t)
			Tile.Principle.RESONANCE:
				if _same_neighbors_count(t) >= 2:
					t.intensity = clamp(t.intensity + 1, 1, 5)
			Tile.Principle.DISSOLUTION:
				pass

	# 2) neighbor interactions
	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t == null or t.principle == Tile.Principle.NONE:
			continue
		var same_count: int = _same_neighbors_count(t)
		var ent_count: int = _count_neighbors_principle(t, Tile.Principle.ENTROPY)
		if same_count >= 2:
			g_coherence = clamp(g_coherence + 1, 0, 100)
			t.stability = clamp(t.stability + 1, 0, 100)
		if ent_count >= 1 and t.principle == Tile.Principle.FORM:
			t.stability = max(t.stability - 1, 0)
			g_entropy = clamp(g_entropy + 1, 0, 100)

	# 3) global metrics from tiles
	_recompute_globals()

	# 4) tile collapse
	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t == null:
			continue
		if t.principle != Tile.Principle.NONE and t.stability <= 0:
			if randi() % 2 == 0:
				t.set_principle(Tile.Principle.ENTROPY, false)
				t.intensity = 1
				t.stability = 5
			else:
				t.clear_tile()
			g_entropy = clamp(g_entropy + 1, 0, 100)

func _end_turn() -> void:
	turn += 1
	_check_revelation()
	_update_ui()

func _try_spread_growth(src: Tile) -> void:
	for n in src.neighbors_axial():
		var t: Tile = grid.get_tile(n.x, n.y)
		if t and t.principle == Tile.Principle.NONE:
			t.set_principle(Tile.Principle.GROWTH, false)
			t.intensity = 1
			t.stability = 5
			g_growth = clamp(g_growth + 1, 0, 100)
			return

func _same_neighbors_count(t: Tile) -> int:
	var n: int = 0
	for v in t.neighbors_axial():
		var nt: Tile = grid.get_tile(v.x, v.y)
		if nt and nt.principle == t.principle and nt.principle != Tile.Principle.NONE:
			n += 1
	return n

func _count_neighbors_principle(t: Tile, p: int) -> int:
	var n: int = 0
	for v in t.neighbors_axial():
		var nt: Tile = grid.get_tile(v.x, v.y)
		if nt and nt.principle == p:
			n += 1
	return n

func _affect_neighbors_after_dissolution(tile: Tile) -> void:
	for v in tile.neighbors_axial():
		var nt: Tile = grid.get_tile(v.x, v.y)
		if nt and nt.principle != Tile.Principle.NONE:
			nt.stability = max(nt.stability - 1, 0)
	g_entropy = clamp(g_entropy + 1, 0, 100)
	g_growth = clamp(g_growth + 1, 0, 100)

func _recompute_globals() -> void:
	var order_local: int = 0
	var entropy_local: int = 0
	var coherence_local: int = 0
	var tiles_count: int = 0

	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t and t.principle != Tile.Principle.NONE:
			tiles_count += 1
			if t.principle == Tile.Principle.FORM:
				order_local += 1
			if t.principle == Tile.Principle.ENTROPY:
				entropy_local += 1
			var same_cnt: int = _same_neighbors_count(t)
			if t.principle == Tile.Principle.RESONANCE and same_cnt >= 2:
				coherence_local += 2
			elif same_cnt >= 2:
				coherence_local += 1

	g_order = clamp(int(100.0 * float(order_local) / max(1, tiles_count)), 0, 100)
	g_entropy = clamp(int(100.0 * float(entropy_local) / max(1, tiles_count)), 0, 100)
	g_coherence = clamp(min(100, g_coherence + coherence_local), 0, 100)

func classify_player() -> String:
	var full := 0
	for v in grid.tiles.values():
		var t: Tile = v as Tile
		if t and t.principle != Tile.Principle.NONE:
			full += 1

	var total := grid.tiles.size()

	# Archetypes in priority order
	if g_order >= 70 and g_coherence >= 60:
		return "Architect of Order"
	if g_entropy >= 75:
		return "Entropy Shepherd"
	if g_growth >= 75:
		return "Bloombringer"
	if g_coherence >= 70:
		return "Resonant Oracle"
	if full == total:
		return "Stasis Curator"
	if g_order <= 10 and g_coherence <= 10 and turn >= 10:
		return "Silent Dissolver"
	if g_growth >= 50 and g_entropy >= 40:
		return "Chaotic Gardener"
	if g_coherence >= 85 and turn >= 40:
		return "Ascension"

	# fallback
	return "Wandering Eternal"

func _check_revelation() -> void:
	if g_order >= 80 and g_coherence >= 60:
		_end_run("Harmony")
	elif g_entropy >= 80:
		_end_run("Collapse")
	elif g_growth >= 80:
		_end_run("Expansion")
	elif g_order <= 10 and g_coherence <= 10 and turn >= 8:
		_end_run("Dissolution")

func _end_run(state: String) -> void:
	var style := classify_player()

	print("Revelation:", state, " | Archetype:", style, "| turns=", turn)

	# UI popup
	print("=== WORLD COMPLETE ===")

	set_process_input(false)
	set_process(false)

func _update_ui():
	var lbl = $"../UI/root/Box/Metrics/Label"
	lbl.text = "Turn: %2d | O: %3d | E: %3d | C: %3d | G: %3d" % [
		turn, g_order, g_entropy, g_coherence, g_growth
	]

	# Hand (buttons for now)
	var b0: Button = $"../UI/root/Box/Hand/MarginContainer/HBoxContainer/Card1"
	var b1: Button = $"../UI/root/Box/Hand/MarginContainer/HBoxContainer/Card2"
	var b2: Button = $"../UI/root/Box/Hand/MarginContainer/HBoxContainer/Card3"
	var buttons := [b0, b1, b2]

	for i in buttons.size():
		if i < hand.size():
			buttons[i].text = hand[i].name
			buttons[i].disabled = false
			# Slight glow
			buttons[i].modulate = Color(1,1,1,1) if selected_card != hand[i] else Color(1,1,0.8,1)
		else:
			buttons[i].text = "-"
			buttons[i].disabled = true
			buttons[i].modulate = Color(1,1,1,0.5)


var selected_card: Card
func select_card(card_index: int) -> void:
	if card_index >= 0 and card_index < hand.size():
		selected_card = hand[card_index]
	_update_ui()

func _on_card_1_pressed() -> void:
	select_card(0)

func _on_card_2_pressed() -> void:
	select_card(1)

func _on_card_3_pressed() -> void:
	select_card(2)
