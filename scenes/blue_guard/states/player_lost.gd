extends State

@export var idle_state: State = null


func enter() -> void:
    var guard := owner as BlueGuard
    guard.get_node("AnimationPlayer").play("player_lost")


func physics_process(_delta: float) -> State:
    var guard := owner as BlueGuard
    var anim := guard.get_node("AnimationPlayer") as AnimationPlayer

    if not anim.is_playing():
        return idle_state

    return null
