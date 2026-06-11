extends PointLight2D

const DETECTION_RANGE: float = 150.0

var max_scale: float

func _ready() -> void:
	max_scale = texture_scale

func _process(_delta: float) -> void:
	var npcs = get_tree().get_nodes_in_group("npcs")
	if npcs.is_empty():
		energy = 0.0
		return

	var nearest_dist = INF
	for npc in npcs:
		var d = get_parent().global_position.distance_to(npc.global_position)
		if d < nearest_dist:
			nearest_dist = d

	var t = clamp(remap(nearest_dist, 0.0, DETECTION_RANGE, 1.0, 0.0), 0.0, 1.0)
	energy = t * 2.0
	texture_scale = t * max_scale
