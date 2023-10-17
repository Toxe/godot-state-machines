extends State

const speed := 300.0

var player: Player = null


func setup() -> void:
    player = state_machine.owner as Player


func physics_process(_delta: float) -> State:
    player.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
    player.move_and_slide()
    return null
