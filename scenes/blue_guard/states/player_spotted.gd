extends State

@export var follow_player_state: State = null


func _ready() -> void:
    assert(follow_player_state != null)
