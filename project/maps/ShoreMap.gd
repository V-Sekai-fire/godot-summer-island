extends Node

var _screenshot_directory = "user://screenshots"
var _capture_tasks = []

func _ready() -> void:
	randomize()
	Directory.new().make_dir(_screenshot_directory)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $DayNightCycle.time == $DayNightCycle.times.DAY:
			$DayNightCycle.time = $DayNightCycle.times.NIGHT
		else:
			$DayNightCycle.time = $DayNightCycle.times.DAY
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_F10:
			_capture()
		if event.scancode == KEY_F1:
			$DebugUI/ControlHelpPanel.visible = !$DebugUI/ControlHelpPanel.visible
		if event.scancode == KEY_F2:
			$DebugUI/Performance.visible = !$DebugUI/Performance.visible
		if event.scancode == KEY_1:
			if $Lightings/HangingLamp.pattern == $Lightings/HangingLamp.patterns.ON:
				$Lightings/HangingLamp.pattern = $Lightings/HangingLamp.patterns.OFF
			else:
				$Lightings/HangingLamp.pattern = $Lightings/HangingLamp.patterns.ON
		if event.scancode == KEY_2:
			if $Lightings/HangingLamp2.pattern == $Lightings/HangingLamp2.patterns.ON:
				$Lightings/HangingLamp2.pattern = $Lightings/HangingLamp2.patterns.OFF
			else:
				$Lightings/HangingLamp2.pattern = $Lightings/HangingLamp2.patterns.ON

func _capture():
	# Start thread for capturing images
	var task = Thread.new()
	task.start(self, "_capture_thread", null)
	_capture_tasks.append(task)

func _capture_thread(_arg):
	# Save image
	var image = get_viewport().get_texture().get_data()
	var path = "%s/capture_%s.png" % [_screenshot_directory, OS.get_unix_time()]
	image.flip_y()
	image.save_png(path)
	print ("Screenshot saved to: %s%s" % [OS.get_user_data_dir(), path])

func _exit_tree():
	for task in _capture_tasks:
		task.wait_to_finish()
