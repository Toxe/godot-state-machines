class_name RedGuard extends CharacterBody2D

const walk_speed := 50.0
const run_speed := 100.0

@onready var state_chart: StateChart = $StateChart
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_tree().get_first_node_in_group("player")

var player_in_range := false
var player_detected := false
var move_to := Vector2.ZERO
var player_got_away := false


func _process(_delta: float) -> void:
    if $PlayerSpottedIcon.visible:
        $PlayerSpottedIcon.global_position = global_position + Vector2(0, -80)
        $PlayerSpottedIcon.global_rotation = 0
    if $PlayerLostIcon.visible:
        $PlayerLostIcon.global_position = global_position + Vector2(0, -80)
        $PlayerLostIcon.global_rotation = 0

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


func find_new_destination() -> Vector2:
    var x := randf_range(50, ProjectSettings.get_setting("display/window/size/viewport_width") - 50)
    var y := randf_range(50, ProjectSettings.get_setting("display/window/size/viewport_height") - 50)
    return Vector2(x, y)


func update_line(line: Line2D) -> void:
    line.points[1] = move_to * transform
    line.visible = position.distance_to(move_to) > 30.0


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


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    state_chart.send_event("animation_finished")


# ---- walk state -----------------------------------------------------------
func _on_walk_state_entered() -> void:
    animation_player.play("walk")
    move_to = find_new_destination()
    $BlueLine2D.visible = true


func _on_walk_state_exited() -> void:
    $BlueLine2D.visible = false


func _on_walk_state_physics_processing(_delta: float) -> void:
    if player_detected:
        state_chart.send_event("player_spotted")
        return

    update_line($BlueLine2D)

    velocity = position.direction_to(move_to) * walk_speed
    look_at(move_to)

    if position.distance_to(move_to) > 5:
        var old_position := position
        move_and_slide()
        var delta := position - old_position
        var moved_distance := delta.length()

        if moved_distance < (_delta * walk_speed * 0.25):
            move_to = find_new_destination()
    else:
        move_to = find_new_destination()


# ---- follow_player state --------------------------------------------------
func _on_follow_player_state_entered() -> void:
    animation_player.play("run")
    $PlayerDetector.scale = Vector2(1.5, 1.5)
    $RedLine2D.visible = true

    move_to = player.position
    player_got_away = false


func _on_follow_player_state_exited() -> void:
    $PlayerDetector.scale = Vector2(1.0, 1.0)
    $RedLine2D.visible = false


func _on_follow_player_state_physics_processing(_delta: float) -> void:
    if player_got_away:
        state_chart.send_event("player_lost")
        return

    if player_detected:
        move_to = player.position
        $PlayerLostTimer.stop()
    else:
        if $PlayerLostTimer.is_stopped():
            $PlayerLostTimer.start()

    velocity = position.direction_to(move_to) * run_speed
    look_at(move_to)

    update_line($RedLine2D)

    if position.distance_to(move_to) > 5:
        move_and_slide()


func _on_player_lost_timer_timeout() -> void:
    player_got_away = true
