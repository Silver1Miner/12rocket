extends Window

var date = {}
var weekdays = ["Sunday", "Monday", "Tuesday",
"Wednesday", "Thursday", "Friday", "Saturday"]
var months = ["JANUARY", "FEBRUARY", "MARCH",
"APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER",
"OCTOBER", "NOVEMBER", "DECEMBER"]

func _ready() -> void:
	date = OS.get_date()
	refresh()

func refresh() -> void:
	randomize()
	if rand_range(1, 10) < 9:
		$CalendarValues/Weekday.text = weekdays[date["weekday"]]
		$CalendarValues/Month.text = months[date["month"]-1]
		$CalendarValues/Date.text = str(date["day"])
		$CalendarValues/Quote.text = quotes[date["weekday"]]
	else:
		$CalendarValues/Weekday.text = "Stop checking the calendar"
		$CalendarValues/Month.text = "AND GET BACK TO"
		$CalendarValues/Date.text = "WORK"
		$CalendarValues/Quote.text = "DO NOT FORGET: YOU ARE HERE FOREVER"
		yield(get_tree().create_timer(0.3), "timeout")
		$CalendarValues/Weekday.text = weekdays[date["weekday"]]
		$CalendarValues/Month.text = months[date["month"]-1]
		$CalendarValues/Date.text = str(date["day"])
		$CalendarValues/Quote.text = quotes[date["weekday"]]

var quotes := [
	"Hope is the first step toward disappointment.",
	"Don't blame Mondays. Your life is terrible all the time.",
	"Do not fear success. You will never reach it.",
	"Nothing is hard, so long as you are willing to give up.",
	"The harder you work, the richer your boss becomes.",
	"You are a prodct, not a gift.",
	"The beatings will continue until morale improves.",
]
