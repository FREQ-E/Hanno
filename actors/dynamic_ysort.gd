class_name DynamicYSort
extends VisibilityNotifier2D


func get_z_index() -> int:
	return int(clamp(get_viewport_transform().xform(get_parent().global_transform.origin).y, 0, INF))
