extends State

const speed := 100.0

@export var player_lost_state: State = null

var move_to := Vector2.ZERO
var player_got_away := false


func _ready() -> void:
    assert(player_lost_state != null)


func enter() -> void:
    var guard := owner as BlueGuard
    guard.get_node("AnimationPlayer").play("run")

    move_to = get_player_position()


func physics_process(_delta: float) -> State:
    var guard := owner as BlueGuard

    if player_got_away:
        return player_lost_state

    if guard.player_detected:
        move_to = get_player_position()
        $PlayerLostTimer.stop()
    else:
        if $PlayerLostTimer.is_stopped():
            $PlayerLostTimer.start()

    guard.velocity = guard.position.direction_to(move_to) * speed
    guard.look_at(move_to)

    update_line()

    if guard.position.distance_to(move_to) > 5:
        guard.move_and_slide()

    return null


func get_player_position() -> Vector2:
    var player := get_tree().get_first_node_in_group("player") as Player
    return player.position


func update_line() -> void:
    var guard := owner as BlueGuard
    $Line2D.points[0] = guard.position + guard.transform.x * 30.0
    $Line2D.points[1] = move_to
    $Line2D.visible = guard.position.distance_to($Line2D.points[1]) > 30.0


func _on_player_lost_timer_timeout() -> void:
    player_got_away = true
