extends CardState
#dragging state
const DRAG_MINUMUN_THRESHOLD:= 0.05
var minimum_drag_time_elapsed:=false

func enter() -> void:
	var ui_layer=get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.icon.scale=Vector2(1,1)#scale
	card_ui.cost.scale=Vector2(1,1)
	
	Events.card_drag_started.emit(card_ui) #4 if mana
	
	minimum_drag_time_elapsed=false
	var threshold_timer:=get_tree().create_timer(DRAG_MINUMUN_THRESHOLD,false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed=true)


func exit()->void:
	Events.card_drag_ended.emit(card_ui)


func on_input(event: InputEvent)->void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion:= event is InputEventMouseMotion
	var cancel=event.is_action_pressed("right_click") 
	var confirm=event.is_action_released("left_click")#event.is_action_pressed("left_click") or event.is_action_released("right_click")
	
	if single_targeted and mouse_motion and card_ui.targets.size()>0:
		transition_requested.emit(self,CardState.State.AIMING)
		return
	
	if mouse_motion:
		card_ui.global_position=card_ui.get_global_mouse_position()-card_ui.pivot_offset
	if cancel:
		transition_requested.emit(self,CardState.State.BASE)
	elif confirm and minimum_drag_time_elapsed:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self,CardState.State.RELEASED)
