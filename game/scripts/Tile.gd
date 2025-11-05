extends Node2D
class_name Tile

enum Principle { NONE, FORM, TIME, ENTROPY, GROWTH, RESONANCE, DISSOLUTION, FRACTURE }

@export var q:int = 0
@export var r:int = 0
var intensity:int = 1
var stability:int = 10
var age:int = 0
var principle:int = Principle.NONE

@onready var label: Label = $Label
@onready var spr: Sprite2D = $Sprite2D

func set_principle(p:int, add_intensity:bool=true):
	principle = p
	if add_intensity and intensity < 5:
		intensity += 1
	update_visual()

func clear_tile():
	principle = Principle.NONE
	intensity = 0
	stability = 0
	update_visual()

func _refresh_label():
	label.text = "%s\nI:%d S:%d" % [ _p_name(principle), intensity, stability ]

func _p_name(p:int)->String:
	match p:
		Principle.NONE: return "VOID"
		Principle.FORM: return "FORM"
		Principle.TIME: return "TIME"
		Principle.ENTROPY: return "ENTROPY"
		Principle.GROWTH: return "GROWTH"
		Principle.RESONANCE: return "RESONANCE"
		Principle.DISSOLUTION: return "DISSOLUTION"
		Principle.FRACTURE: return "FRACTURE"
		_: return "?"

func neighbors_axial()->Array[Vector2i]:
	return [
		Vector2i(q+1, r), Vector2i(q+1, r-1), Vector2i(q, r-1),
		Vector2i(q-1, r), Vector2i(q-1, r+1), Vector2i(q, r+1)
	]

func update_visual() -> void:
	match principle:
		Principle.NONE:       modulate = Color(1,1,1,0.12)
		Principle.FORM:       modulate = Color(0.30,0.60,1.00,1)
		Principle.TIME:       modulate = Color(0.65,0.35,1.00,1)
		Principle.ENTROPY:    modulate = Color(1.00,0.30,0.30,1)
		Principle.GROWTH:     modulate = Color(0.30,1.00,0.40,1)
		Principle.RESONANCE:  modulate = Color(1.00,1.00,0.35,1)
		Principle.DISSOLUTION:modulate = Color(0.10,0.10,0.10,0.35)
		Principle.FRACTURE:   modulate = Color(0.45, 0.2, 0.7, 0.9)
