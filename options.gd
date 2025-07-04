extends Control

signal back_requested

@onready var sound: AudioStreamPlayer = $SoundEffect
@onready var mute_checkbox: CheckBox = $mute_check
var saved_volume_db: float = 0.0
var window_resolution := Vector2(1280, 720)  # Default windowed resolution
var fullscreen_resolution := Vector2(1920, 1080)  # Common fullscreen resolution
var is_muted: bool = false  # Track the mute state


func _ready():
	# Initialize audio
	is_muted = AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
	mute_checkbox.set_pressed(is_muted)  # Set the checkbox state based on the current mute state
	mute_checkbox.toggled.connect(_on_mute_check_toggled)

func center_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position((screen_size - window_size) * 0.5)

func _on_volume_value_changed(value: float):
	if !mute_checkbox.pressed:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_mute_check_toggled(toggled_on: bool) -> void:
	var master_bus = AudioServer.get_bus_index("Master")
	if toggled_on:
		saved_volume_db = AudioServer.get_bus_volume_db(master_bus)
		AudioServer.set_bus_mute(master_bus, true)
		is_muted = true  # Update the mute state
	else:
		AudioServer.set_bus_mute(master_bus, false)
		AudioServer.set_bus_volume_db(master_bus, saved_volume_db)
		is_muted = false  # Update the mute state

func _on_option_button_item_selected(index: int):
	match index:
		0:  # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_size(fullscreen_resolution)
		1:  # Maximized
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		2:  # Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			center_window()
		3:  # Minimized
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)

func _on_voltar_pressed():
	sound.play()
	emit_signal("back_requested")  # Emit the back signal
