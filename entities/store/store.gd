extends Node2D

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_interactive_interacted():
	player.disabled_move = true
	const store_dialogue = preload("res://dialogues/store.dialogue")
	var dialogue = DialogueManager.show_dialogue_balloon(store_dialogue, "store_dialogue")

	await dialogue.tree_exited

	_on_interactive_dialogue_close()

func _on_interactive_dialogue_close():
	player.disabled_move = false
