extends Node


#Card events
signal card_aim_started(card_ui:CardUI)
signal card_aim_ended(card_ui:CardUI)
signal card_played(card:Card)

#4 Logic
signal card_drag_started(card_ui:CardUI)
signal card_drag_ended(card_ui:CardUI)
