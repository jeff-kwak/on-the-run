extends StaticBody3D


func _on_player_exit_detection_body_entered(_body:Node3D):
    print("stage: player finished stage")
    EventBus.player_left_stage.emit(self)
