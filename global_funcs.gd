extends Node


func yield_and_get_group(group: String) -> Array:
	# this function allows a node to try and get the nodes in a group
	# it will wait until the group exists
	var tree := get_tree()
	
	while not tree.has_group(group):
		yield(tree, "node_added")
	
	return tree.get_nodes_in_group(group)


func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
	
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
