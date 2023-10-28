# Responsible for processing input
extends CharacterBody3D


@onready var locomotion = $Ability/PlayerLocomotion
@onready var jump = $Ability/Jump
@onready var gravity_effect: GravityEffect = $Ability/Gravity



# store desired motion values
var _right: float = 0.0
var _left: float = 0.0


func _ready() -> void:
    jump.jumped.connect(_on_jumped)
    jump.peaked.connect(_on_peaked)
    jump.landed.connect(_on_landed)


func _process(_delta) -> void:
    _right = Input.get_action_strength("right")
    _left = Input.get_action_strength("left")
    if Input.is_action_just_pressed("jump"):
        jump.trigger()


func _physics_process(delta):
    jump.apply()
    gravity_effect.apply(delta)
    locomotion.move(_right - _left)


func _on_jumped(rise_gravity: float) -> void:
    print("player: jumped")
    gravity_effect.gravity = rise_gravity


func _on_peaked(fall_gravity: float) -> void:
    print("player: peaked")
    gravity_effect.gravity = fall_gravity


func _on_landed() -> void:
    print("player: landed")
    gravity_effect.gravity = -10.0
