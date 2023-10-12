class_name BlueGuard extends CharacterBody2D

var player_in_range := false
var player_detected := false


func _physics_process(_delta: float) -> void:
    if player_in_range:
        player_detected = false
        for raycast: RayCast2D in [$PlayerDetector/RayCast2D1, $PlayerDetector/RayCast2D2, $PlayerDetector/RayCast2D3]:
            var player := raycast.get_collider() as Player
            if player:
                player_detected = true
                break


func _on_player_detector_body_entered(body: Node2D) -> void:
    if body is Player:
        player_in_range = true


func _on_player_detector_body_exited(body: Node2D) -> void:
    if body is Player:
        player_in_range = false
        player_detected = false
