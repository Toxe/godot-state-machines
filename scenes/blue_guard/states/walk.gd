extends State

const speed := 100.0

@export var player_spotted_state: State = null

var move_to := Vector2.ZERO


func _ready() -> void:
    assert(player_spotted_state != null)


func enter() -> void:
    move_to = find_new_destination()


func physics_process(_delta: float) -> State:
    var guard := owner as BlueGuard

    $Line2D.points[0] = guard.position
    $Line2D.points[1] = move_to

    guard.velocity = guard.position.direction_to(move_to) * speed
    guard.look_at(move_to)

    if guard.position.distance_to(move_to) > 5:
        var old_position := guard.position
        guard.move_and_slide()
        var delta := guard.position - old_position
        var moved_distance := delta.length()

        if moved_distance < (_delta * speed * 0.25):
            move_to = find_new_destination()
    else:
        move_to = find_new_destination()

    return null


func find_new_destination() -> Vector2:
    var x := randf_range(50, ProjectSettings.get_setting("display/window/size/viewport_width") - 50)
    var y := randf_range(50, ProjectSettings.get_setting("display/window/size/viewport_height") - 50)
    return Vector2(x, y)
