class_name RedGuard extends CharacterBody2D

var player_in_range := false
var player_detected := false


func _process(_delta: float) -> void:
    if $PlayerSpottedIcon.visible:
        $PlayerSpottedIcon.global_position = global_position + Vector2(0, -80)
        $PlayerSpottedIcon.global_rotation = 0
    if $PlayerLostIcon.visible:
        $PlayerLostIcon.global_position = global_position + Vector2(0, -80)
        $PlayerLostIcon.global_rotation = 0

    var player := get_tree().get_first_node_in_group("player") as Player
    $PlayerDetector.look_at(player.position)


func _physics_process(_delta: float) -> void:
    if player_in_range:
        player_detected = false

        for raycast: RayCast2D in [$PlayerDetector/RayCast2D1, $PlayerDetector/RayCast2D2, $PlayerDetector/RayCast2D3]:
            assert(raycast.enabled)

            var collider := raycast.get_collider()
            if collider and collider is Player:
                player_detected = true
                break


func _on_player_detector_body_entered(body: Node2D) -> void:
    if body is Player:
        player_in_range = true

        for raycast: RayCast2D in [$PlayerDetector/RayCast2D1, $PlayerDetector/RayCast2D2, $PlayerDetector/RayCast2D3]:
            raycast.enabled = true


func _on_player_detector_body_exited(body: Node2D) -> void:
    if body is Player:
        player_in_range = false
        player_detected = false

        for raycast: RayCast2D in [$PlayerDetector/RayCast2D1, $PlayerDetector/RayCast2D2, $PlayerDetector/RayCast2D3]:
            raycast.enabled = false
