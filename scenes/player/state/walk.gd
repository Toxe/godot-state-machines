extends State

const speed := 300.0


func physics_process(_delta: float) -> State:
    var player := owner as Player
    player.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
    player.move_and_slide()
    return null
