tool
extends Node

# Current implementation: just switching between day and night

enum times {DAY, NIGHT}
export (times) var time setget _set_time

export (NodePath) var environment
export (NodePath) var dir_light

onready var panorama_day = preload("res://assets/sky/EpicBlueSunset.png")
onready var panorama_night = preload("res://assets/sky/NightMoonburst.png")

func _set_time(new_time) -> void:
	time = new_time
	if get_parent() == null:
		return
	if not get_parent().get_child_count() > 0:
		return
	var env = get_node(environment).environment
	
	match time:
		times.DAY:
			env.background_sky.panorama = panorama_day
			env.background_energy = 0.2
			env.fog_color = Color(0.13, 0.15, 0.18)
			env.fog_sun_color = Color(0.8, 0.71, 0.62)
			get_node(dir_light).light_color = Color(0.98, 0.97, 0.93)
			get_node("../Lightings/ReflectionProbes/HouseBarInt").interior_ambient_color = Color(0.11, 0.12, 0.14)
		times.NIGHT:
			env.background_sky.panorama = panorama_night
			env.background_energy = 0.2
			env.fog_color = Color(0.03, 0.05, 0.07)
			env.fog_sun_color = Color(0.25, 0.29, 0.39)
			get_node(dir_light).light_color = Color(0.16, 0.23, 0.27)
			get_node("../Lightings/ReflectionProbes/HouseBarInt").interior_ambient_color = Color(0.01, 0.01, 0.02)
