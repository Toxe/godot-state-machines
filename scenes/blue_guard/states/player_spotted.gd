extends State

@export var follow_player_state: State = null

var guard: BlueGuard = null


func setup(_sm: StateMachine) -> void:
    guard = owner as BlueGuard


func enter() -> void:
    guard.get_node("AnimationPlayer").play("player_spotted")


func physics_process(_delta: float) -> State:
    var anim := guard.get_node("AnimationPlayer") as AnimationPlayer

    if not anim.is_playing():
        return follow_player_state

    return null
