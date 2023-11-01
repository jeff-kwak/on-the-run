extends Node


@export var lateral_speed: float = 16.0
@export var forward_speed: float = 10.0
@export var character_node: CharacterBody3D = null


func move(x: float) -> void:
    character_node.velocity.x = x * lateral_speed
    character_node.velocity.z = -forward_speed
    character_node.move_and_slide()
