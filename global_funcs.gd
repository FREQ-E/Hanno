extends Node


func yield_and_get_group(group: String) -> Array:
	# this function allows a node to try and get the nodes in a group
	# it will wait until the group exists
	var tree := get_tree()
	
	while not tree.has_group(group):
		yield(tree, "node_added")
	
	return tree.get_nodes_in_group(group)
