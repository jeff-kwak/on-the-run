# Responsible for processing input
# Uses PlayerLocomotion
extends CharacterBody3D


@onready var locomotion = $Ability/PlayerLocomotion


# store desired motion values
var right: float = 0
var left: float = 0


func _process(_delta) -> void:
    right = Input.get_action_strength("right")
    left = Input.get_action_strength("left")


func _physics_process(_delta):
    locomotion.move(right - left)
