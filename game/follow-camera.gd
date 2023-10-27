extends Camera3D


enum MoveMode { IDLE, PHYSICS }


@export var target: Node3D = null
@export var speed: float = 16.0
@export var move_mode: MoveMode = MoveMode.IDLE


var _target_vector: Vector3 = Vector3.ZERO


func _process(delta):
    if move_mode != MoveMode.IDLE:
        return

    _move(delta)

func _physics_process(delta):
    if move_mode != MoveMode.PHYSICS:
        return

    _move(delta)


func _move(delta: float) -> void:

    var direction = target.position - position
    _target_vector.x = direction.x

    if not direction.is_zero_approx():
        position += _target_vector * speed * delta
