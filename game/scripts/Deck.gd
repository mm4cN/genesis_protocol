extends Node
class_name Deck

var pool:Array[Card] = []
var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func load_universal_pool():
	pool = Principles.pool()

func draw(count:int=1)->Array[Card]:
	if pool.is_empty():
		load_universal_pool()
	var out:Array[Card] = []
	for i in count:
		out.append(pool[rng.randi_range(0, pool.size()-1)])
	return out
