extends "res://interactables/interactable.gd"

func _on_interacted():
	# 1. Put the bike in the global backpack!
	PlayerData.has_bicycle = true
	
	# 2. Print a message so we know it worked
	print("Got the Bicycle Effect!")
	
	# 3. Delete the item from the ground so you can't pick it up twice
	queue_free()
