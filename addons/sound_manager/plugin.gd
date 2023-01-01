@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("SoundManager", "res://addons/sound_manager/sound_manager.tscn")


func _exit_tree():
	remove_autoload_singleton("SoundManager")
