extends Node


@export var speed: float = 16.0
@export var character_node: CharacterBody3D = null


func move(x: float) -> void:
    character_node.velocity.x = x * speed
    character_node.move_and_slide()
