extends State

@export var walk_state: State = null


func _ready() -> void:
    assert(walk_state != null)
