extends HBoxContainer

onready var headings = $Headings
onready var from = $Content/From/FromLabels/From
onready var subject = $Content/Title/TitleLabels/Title
onready var content = $Content/Content/Content

export var current_hide = 3
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
		if len(title) > 15:
			title = title.substr(0,15)+"..."
		if item >= current_hide:
			headings.add_item(title, null, true)
			headings.set_item_tooltip_enabled(item-current_hide, false)
	headings.select(0, true)

func populate_content(index: int) -> void:
	from.text = emails[index+current_hide]["from"]
	subject.text = emails[index+current_hide]["title"]
	if typeof(emails[index+current_hide]["text"]) == TYPE_ARRAY:
		content.text = emails[index+current_hide]["text"][PlayerData.game_route]
	else:
		content.text = emails[index+current_hide]["text"]
	content.scroll_to_line(0)

func _on_Headings_item_selected(index: int) -> void:
	populate_content(index)

var emails = [
	{
		"title": "ALERT: SECURITY BREACH",
		"from": "Chief of Security",
		"text":
"""ALL PERSONNEL ARE TO LEAVE THE FACILITY AT ONCE. THIS IS NOT A DRILL.

SECURITY PERSONNEL MUST EVACUATE VIA THE NEAREST ELEVATOR.

THIS IS NOT A DRILL.""",
	},
	{
		"title": "Security Reminder",
		"from": "Chief of Security",
		"text":
"""Reminder to all personnel:

We are guests of this facility, invited to serve a very specific purpose.

Respect the privacy of our clients. NEVER attempt to unlock systems that are not in your jurisdiction.
""",
	},
	{
		"title": "Camera Pass",
		"from": "Security Officer Briggs",
		"text": [
"""Hey, sorry, but I just realized that camera 2 is locked by default and you never got the security passcode.

Go to the Locks section on the CCTV interface, select camera 2, and enter the code into the lockpad: 1234

Yes, I know, not a very secure passcode. It's not up to us unfortunately.
""",
"""Hey, sorry, but I just realized that camera 2 is locked by default and you never got the security passcode.

Go to the Locks section on the CCTV interface, select camera 2, and enter the code into the lockpad: 2345
""",
"""Hey, sorry, but I just realized that camera 2 is locked by default and you never got the security passcode.

Go to the Locks section on the CCTV interface, select camera 2, and enter the code into the lockpad: 3456
""",
]
	},
	{
		"title": "Orientation",
		"from": "Security Officer Briggs",
		"text":
"""Hello, and welcome to the Rocket Security Team!

The job is really simple: use the CCTV window to keep an eye on the security cameras and report any suspicious activity.

Your computer terminal should already be set up for you. Just keep watch on cameras 1 and 2.

The terminal also contains a camera 3, but just ignore that one. It's not under your jursidiction.

-Briggs""",
	},
	{
		"title": "Changes to Email System",
		"from": "Human Resources",
		"text":
"""Following the success of our pilot program in which we disabled reply and forwarding functions of email clients, we are proud to announce we have expanded the program by replacing all email clients with new recepit-only inbox systems.

With these new clients, employees are ONLY able to receive messages, without ability to reply, forward, or send messages.

Any complaints or concerns can be sent or forwarded to Human Resources.

--
This is an automated message from an unattended inbox. Do not reply.
""",
	},
	{
		"title": "To: Rocket Security LLC",
		"from": "Office of the COO",
		"text":
"""I have been reviewing our contract, and would like to raise some concerns with respect to your hiring and assignment standards.

Our company handles very confidential information, and moreover, some of the services we require from our security contractors involve a certain degree of discretion.

We ask that you keep this in mind when making decisions on which security officers to assign to our offices. We do NOT want a repeat of what happened at the 'Gaslit' satellite office.

If an unqualified officer is used to terminate an employee, said officer may need to be terminated as well, to maintain confidentiality.

--
B. Russel
Chief Operations Officer
""",
	},
	{
		"title": "A Warning",
		"from": "Old Man",
		"text":
["""Don't try it. They're on the lookout for 'temporal paradoxes.'

They WILL notice.""",
"""Seriously, do not try it. They WILL notice a 'temporal paradox.'

Just play along.""",
"""I am absolute serious. They are watching for 'temporal paradoxes.'

They WILL notice if you know something that you shouldn't know.""",
]
	},
	{
		"title": "Missing Security Equipment",
		"from": "Chief of Security",
		"text":
"""Recently a piece of level 5 security equipment was reported missing from its security station.

Needless to say, it is completely unaccetable to have such a sensitive piece of equipment unaccounted for. The security officer in charge has already been terminated.

If any security officer finds the missing equipment, return it to its designated security station immediately.
""",
	},
		{
		"title": "Return to Electric Lighting",
		"from": "Facility Operations Manager",
		"text":
"""Good News!

Following extensive feedback, the facility has reverted from gas powered lighting back to electric powered lighting.

This decision was not influenced by any rumors of gas poisoning or missing personnel, which, as we continue to remind you, are false.

--
This is an automated message from an unattended inbox. Do not reply.
""",
	},

]

