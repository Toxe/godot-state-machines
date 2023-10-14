class_name State extends Node


func _ready() -> void:
    if OS.has_feature("debug"):
        assert_all_exported_state_nodes_are_not_null()


func assert_all_exported_state_nodes_are_not_null() -> void:
    const mask := PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_SCRIPT_VARIABLE
    var script := get_script() as Script

    if script:
        for prop: Dictionary in script.get_script_property_list():
            if prop["type"] == TYPE_OBJECT and prop["class_name"] == &"State":
                if prop["usage"] & mask == mask:
                    assert(get(prop["name"]) != null)


# ---- State interface ------------------------------------------------------
func setup(_sm: StateMachine) -> void: pass

func enter() -> void: pass
func exit() -> void: pass

func process(_delta: float) -> State: return null
func physics_process(_delta: float) -> State: return null
func unhandled_input(_event: InputEvent) -> State: return null
