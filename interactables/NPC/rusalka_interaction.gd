extends Area2D

func _on_interacted():
	Events.map_change_requested.emit("res://maps/cementery/cementery.tscn", "")
