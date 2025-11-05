extends Node2D
class_name HexGrid

@export var tile_scene: PackedScene
@export var radius: int = 3          # 7/19/37 dla 1/2/3
@export var hex_size: float = 48.0

var tiles: Dictionary = {}  # key: Vector2i(q,r) -> Tile

func _ready() -> void:
	generate_hex_map()
	call_deferred("_center_grid")

func generate_hex_map() -> void:
	for child in get_children():
		child.queue_free()
	tiles.clear()

	for q in range(-radius, radius + 1):
		var r1: int = max(-radius, -q - radius)
		var r2: int = min(radius, -q + radius)
		for r in range(r1, r2 + 1):
			var t := tile_scene.instantiate() as Tile
			t.q = q
			t.r = r
			t.position = axial_to_pixel(q, r)
			add_child(t)
			tiles[Vector2i(q, r)] = t

func axial_to_pixel(q: int, r: int) -> Vector2:
	var x := hex_size * sqrt(3.0) * (q + r * 0.5)
	var y := hex_size * 1.5 * r
	return Vector2(x, y)

func get_tile(q: int, r: int) -> Tile:
	return tiles.get(Vector2i(q, r), null)

func _center_grid() -> void:
	var rect := _get_bounds_local()
	if rect.size == Vector2.ZERO:
		return
	var vp_size: Vector2 = get_viewport().get_visible_rect().size
	position = vp_size * 0.5 - (rect.position + rect.size * 0.5)

func _get_bounds_local() -> Rect2:
	var first := true
	var minp := Vector2.ZERO
	var maxp := Vector2.ZERO
	for v in tiles.values():
		var t := v as Node2D
		if t == null:
			continue
		var tp: Vector2 = t.position
		if first:
			minp = tp
			maxp = tp
			first = false
		else:
			minp.x = min(minp.x, tp.x)
			minp.y = min(minp.y, tp.y)
			maxp.x = max(maxp.x, tp.x)
			maxp.y = max(maxp.y, tp.y)
	return Rect2() if first else Rect2(minp, maxp - minp)
