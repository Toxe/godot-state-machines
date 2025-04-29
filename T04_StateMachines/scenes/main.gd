extends Node

@onready var state_chart_debugger: MarginContainer = $StateChartDebugger
@onready var state_chart_debugger_tab_container: TabContainer = $StateChartDebugger/TabContainer


func _ready() -> void:
    state_chart_debugger.visible = false
    state_chart_debugger_tab_container.tab_focus_mode = Control.FOCUS_NONE
    create_window_title_update_timer()
    update_window_title()


func _unhandled_key_input(event: InputEvent) -> void:
    if event.is_action_pressed("quit"):
        get_tree().quit()


func create_window_title_update_timer() -> void:
    var timer := Timer.new()
    add_child(timer)
    timer.timeout.connect(update_window_title)
    timer.start(1.0)


func update_window_title() -> void:
    get_window().title = "%s [%d FPS]" % [ProjectSettings.get_setting("application/config/name"), Performance.get_monitor(Performance.TIME_FPS)]


func _on_toggle_state_chart_debugger_button_pressed() -> void:
    state_chart_debugger.visible = !state_chart_debugger.visible
