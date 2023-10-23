extends MyState

const speed := 300.0

var player: Player = null

var action_strength_move_left := 0.0
var action_strength_move_right := 0.0
var action_strength_move_up := 0.0
var action_strength_move_down := 0.0


func setup() -> void:
    player = state_machine.owner as Player


func unhandled_input(event: InputEvent) -> MyState:
    if not event is InputEventKey or event.is_echo():
        return

    if event.is_action("move_left"):
        action_strength_move_left = 1.0 if event.is_pressed() else 0.0
    elif event.is_action("move_right"):
        action_strength_move_right = 1.0 if event.is_pressed() else 0.0
    elif event.is_action("move_up"):
        action_strength_move_up= 1.0 if event.is_pressed() else 0.0
    elif event.is_action("move_down"):
        action_strength_move_down = 1.0 if event.is_pressed() else 0.0

    return null


func physics_process(_delta: float) -> MyState:
    player.velocity = get_movement_direction() * speed
    player.move_and_slide()
    return null


func get_movement_direction() -> Vector2:
    return Vector2(action_strength_move_right - action_strength_move_left,
                   action_strength_move_down - action_strength_move_up)
