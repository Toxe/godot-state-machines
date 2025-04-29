class_name MyState extends Node

var state_machine: MyStateMachine = null


func _ready() -> void:
    if OS.has_feature("debug"):
        assert_all_exported_state_nodes_are_not_null()


func assert_all_exported_state_nodes_are_not_null() -> void:
    const mask := PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_SCRIPT_VARIABLE
    var script: Script = get_script()

    if script:
        for prop: Dictionary in script.get_script_property_list():
            if prop["type"] == TYPE_OBJECT and prop["class_name"] == &"MyState":
                if prop["usage"] & mask == mask:
                    var prop_name: StringName = prop["name"]
                    assert(get(prop_name) != null, "\"%s\" state of %s node \"%s\" is not set." % [prop_name, owner.name, name])


# ---- State interface ------------------------------------------------------
func setup() -> void: pass

func enter() -> void: pass
func exit() -> void: pass

func process(_delta: float) -> MyState: return null
func physics_process(_delta: float) -> MyState: return null
func unhandled_input(_event: InputEvent) -> MyState: return null
