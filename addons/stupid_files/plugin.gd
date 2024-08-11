@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("StupidFiles", "res://addons/stupid_files/stupidFiles.tscn")


func _exit_tree():
	remove_autoload_singleton("StupidFiles")
