class_name QuestManager extends Node

@onready var QuestBox: CanvasLayer = ui.get_node("QuestBox")
@onready var QuestTitle: RichTextLabel = ui.get_node("QuestBox/QuestTitle")
@onready var QuestDescription: RichTextLabel = ui.get_node("QuestBox/QuestDescription")

@export_group("Quest Settings")
@export var quest_name: String
@export var quest_description: String
@export var reached_goal_text: String

enum QuestStatus{
	available,
	started,
	reached_goal,
	finished,
}

@export var quest_status: QuestStatus = QuestStatus.available

@export_group("Reward Settings")
@export var reward_amount: int
