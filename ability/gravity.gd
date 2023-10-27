extends Node
class_name GravityEffect


@export var player: CharacterBody3D = null
@export var gravity: float = -12.0


func apply(delta: float = 0.0) -> void:
    player.velocity.y += gravity * delta
