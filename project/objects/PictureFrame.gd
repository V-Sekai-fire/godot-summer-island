@tool
extends Node3D

@export_file var picture:
	set=_set_picture

func _set_picture(new_picture) -> void:
	if has_node("Picture") and new_picture != picture:
		var file = load(new_picture)
		if file is StreamTexture2D:
			picture = new_picture
			$Picture.mesh.material.set_shader_param("texture_albedo", file)
