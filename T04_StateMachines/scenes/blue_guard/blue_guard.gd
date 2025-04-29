class_name BlueGuard extends CharacterBody2D

var player_in_range := false
var player_detected := false

@onready var player_spotted_icon: Sprite2D = $PlayerSpottedIcon
@onready var player_lost_icon: Sprite2D = $PlayerLostIcon


func _process(_delta: float) -> void:
    if player_spotted_icon.visible:
        player_spotted_icon.global_position = global_position + Vector2(0, -80)
        player_spotted_icon.global_rotation = 0
    if player_lost_icon.visible:
        player_lost_icon.global_position = global_position + Vector2(0, -80)
        player_lost_icon.global_rotation = 0

    var player := get_tree().get_first_node_in_group("player") as Player
    ($PlayerDetector as Area2D).look_at(player.position)


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
