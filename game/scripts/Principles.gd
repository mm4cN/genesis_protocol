extends Node
class_name Principles

static func pool()->Array[Card]:
	var arr:Array[Card] = []
	arr.append(_mk("form", Tile.Principle.FORM, "Form", "Increase order; stabilize region."))
	arr.append(_mk("time", Tile.Principle.TIME, "Time", "Echo effects; advance age."))
	arr.append(_mk("entropy", Tile.Principle.ENTROPY, "Entropy", "Introduce decay; destabilize."))
	arr.append(_mk("growth", Tile.Principle.GROWTH, "Growth", "Spread into adjacent empty tiles."))
	arr.append(_mk("resonance", Tile.Principle.RESONANCE, "Resonance", "Amplify clusters of same principle."))
	arr.append(_mk("dissolution", Tile.Principle.DISSOLUTION, "Dissolution", "Clear a tile; raise local entropy."))
	arr.append(_mk("fracture", Tile.Principle.FRACTURE, "Fracture", "Disrupts local resonance, lowering Coherence."))
	return arr

static func _mk(id:String, p:int, name:String, desc:String)->Card:
	var c := Card.new()
	c.id = id
	c.principle = p
	c.name = name
	c.description = desc
	return c
