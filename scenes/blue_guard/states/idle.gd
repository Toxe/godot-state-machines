extends State

@export var walk_state: State = null


func _ready() -> void:
    assert(walk_state != null)


func enter() -> void:
    var guard := owner as BlueGuard
    guard.get_node("AnimationPlayer").play("idle")


func process(_delta: float) -> State:
    return walk_state
