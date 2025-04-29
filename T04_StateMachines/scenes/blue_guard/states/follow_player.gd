extends GuardState

const speed := 100.0

@export var player_lost_state: MyState = null

var move_to := Vector2.ZERO
var player_got_away := false

@onready var line: Line2D = $Line2D
@onready var player_lost_timer: Timer = $PlayerLostTimer


func enter() -> void:
    super()
    (guard.get_node("PlayerDetector") as Area2D).scale = Vector2(1.5, 1.5)

    move_to = player.position
    player_got_away = false

    line.visible = true


func exit() -> void:
    super()
    (guard.get_node("PlayerDetector") as Area2D).scale = Vector2(1.0, 1.0)

    line.visible = false


func physics_process(_delta: float) -> MyState:
    if player_got_away:
        return player_lost_state

    if guard.player_detected:
        move_to = player.position
        player_lost_timer.stop()
    else:
        if player_lost_timer.is_stopped():
            player_lost_timer.start()

    guard.velocity = guard.position.direction_to(move_to) * speed
    guard.look_at(move_to)

    update_line()

    if guard.position.distance_to(move_to) > 5:
        guard.move_and_slide()

    return null


func update_line() -> void:
    line.points[0] = guard.position + guard.transform.x * 30.0
    line.points[1] = move_to
    line.visible = guard.position.distance_to(line.points[1]) > 30.0


func _on_player_lost_timer_timeout() -> void:
    player_got_away = true
