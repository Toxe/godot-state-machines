extends State

@export var player_lost_state: State = null


func _ready() -> void:
    assert(player_lost_state != null)
