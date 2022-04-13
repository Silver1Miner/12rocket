extends HBoxContainer

onready var headings = $Headings
onready var from = $Content/From/FromLabels/From
onready var subject = $Content/Title/TitleLabels/Title
onready var content = $Content/Content/Content

export var current_hide = 2
signal new_message()

func _ready() -> void:
	populate_email_list()
	populate_content(0)

func new_message() -> void:
	if current_hide > 0:
		current_hide -= 1
		populate_email_list()
		populate_content(0)
		emit_signal("new_message")

func populate_email_list() -> void:
	headings.clear()
	for item in len(emails):
		var title = emails[item]["title"]
		if len(title) > 19:
			title = title.substr(0,19)+"..."
		if item >= current_hide:
			headings.add_item(title, null, true)
			headings.set_item_tooltip_enabled(item-current_hide, false)
	headings.select(0, true)

func populate_content(index: int) -> void:
	from.text = emails[index+current_hide]["from"]
	subject.text = emails[index+current_hide]["title"]
	content.text = emails[index+current_hide]["text"]
	content.scroll_to_line(0)

func _on_Headings_item_selected(index: int) -> void:
	populate_content(index)

var emails = [
	{
		"title": "Message 1",
		"from": "Me",
		"text": "Everything is fine",
	},
	{
		"title": "Message 2",
		"from": "Me",
		"text": "Everything is not fine",
	},
	{
		"title": "Message 3",
		"from": "Me",
		"text": "Everything is fine",
	},
	{
		"title": "Message 4",
		"from": "Me",
		"text": "Everything is not fine",
	},
	{
		"title": "Message 5",
		"from": "Me",
		"text": "Set your mind free",
	},
]

