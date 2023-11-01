extends Node3D


const STAGE_LENGTH: int = 32
const STAGE_POOL: int = 5


@export var possible_stages: Array[PackedScene] = []
@export var start_scene: Node3D = null


var _stages: Array[Node3D] = []
var _next_to_remove: Node3D = null
var _stage_index: int = 0


func _init():
    EventBus.player_left_stage.connect(_on_player_left_stage)


func _ready():
    _stages.resize(STAGE_POOL)
    _stages.append(start_scene)
    for n in range(1, STAGE_POOL):
        _add_random_stage()


func _remove_old_stage() -> void:
    if not _next_to_remove:
        return
    print("world: remove stage at z %s" % _next_to_remove.position.z)
    _next_to_remove.queue_free()


func _add_random_stage() -> void:
        var stage_scene = possible_stages.pick_random()
        var stage = stage_scene.instantiate( )
        _stage_index += 1
        stage.position.z = -STAGE_LENGTH * _stage_index
        _stages.append(stage)
        add_child(stage)


func _on_player_left_stage(stage: Node3D) -> void:
    print("world: player left stage at z %s" % stage.position.z)
    _remove_old_stage()
    _add_random_stage()
    _next_to_remove = stage
