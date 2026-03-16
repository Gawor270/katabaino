extends "res://interactables/interactable.gd"

# Because this function has the exact same name as the one in the base script, 
# Godot will run this one instead when you interact with THIS specific object!
func _on_interacted():
	print("Hello! I am a completely unique test NPC!")
