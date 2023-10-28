extends Node


signal jumped(rise_gravity: float)
signal peaked(fall_gravity: float)
signal landed


enum JumpState { ON_GROUND, JUMPING, RISING, FALLING }


@export var player: CharacterBody3D = null
@export var height: float = 0.0
@export var time_to_peak: float = 0.0
@export var time_to_descend: float = 0.0


var state: JumpState = JumpState.ON_GROUND


var _jvelocity: float = 0.0
var _rise_gravity: float = 0.0
var _fall_gravity: float = 0.0
var _last_py: float = 0.0


func trigger() -> void:
    if state == JumpState.ON_GROUND:
        state = JumpState.JUMPING


func apply() -> void:
    # will not consider jumping in a direction other than straight up
    match state:
        JumpState.ON_GROUND:
            return

        JumpState.JUMPING:
            if player.is_on_floor():
                state = JumpState.RISING
                _jvelocity = (2.0 * height) / time_to_peak
                _rise_gravity = (-2.0 * height) / (time_to_peak * time_to_peak)
                _fall_gravity = (-2.0 * height) / (time_to_descend * time_to_descend)
                player.velocity.y += _jvelocity
                jumped.emit(_rise_gravity)

        JumpState.RISING:
            var py: float = player.velocity.y
            if _last_py >= 0.0 and py < 0.0: # in the air falling
                state = JumpState.FALLING
                peaked.emit(_fall_gravity)
            _last_py = py

        JumpState.FALLING:
            if player.is_on_floor():
                state = JumpState.ON_GROUND
                _jvelocity = 0.0
                landed.emit()
