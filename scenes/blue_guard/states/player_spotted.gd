extends State

@export var follow_player_state: State = null


func _ready() -> void:
    assert(follow_player_state != null)


func enter() -> void:
    var guard := owner as BlueGuard
    guard.get_node("AnimationPlayer").play("player_spotted")


func physics_process(_delta: float) -> State:
    var guard := owner as BlueGuard
    var anim := guard.get_node("AnimationPlayer") as AnimationPlayer

    if not anim.is_playing():
        return follow_player_state

    return null
