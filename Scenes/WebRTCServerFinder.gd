extends MarginContainer

const base_url := "/GameSessions/"

@onready var listUpdatetimer := %ListUpdateTimer as Timer
@onready var request := %GameSessionClient as HTTPRequest
@onready var apiKey := %ApiKeyInput as TextEdit

@onready var playerName := %PlayerNameInput as LineEdit
@onready var createHostName := %CreateHostName as LineEdit

@onready var gameHosts := %GameHosts as ItemList

@onready var hostButton := %HostButton as Button
@onready var joinButton := %JoinButton as Button
@onready var exitButton := %ExitButton as Button
@onready var refreshButton := %RefreshButton as Button

func _release_focus_of_controls():
	playerName.release_focus()
	createHostName.release_focus()
	apiKey.release_focus()
	gameHosts.release_focus()
	hostButton.release_focus()
	joinButton.release_focus()
	refreshButton.release_focus()
	
func _input(event):
	if Input.is_action_just_pressed("toggle_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
		
func _process(delta):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: _release_focus_of_controls()
	
func retrieve_games():
	request.request_completed.connect(func(result, response_code, headers, body):
		var json = JSON.parse_string(body.get_string_from_utf8())
		gameHosts.clear()
		for i in json["gameSessions"]:
			gameHosts.add_item(i)
			
		listUpdatetimer.start())
	
	request.request("%s25" % base_url, [], HTTPClient.METHOD_GET)
	
func _on_list_update_timer_timeout(): retrieve_games()

func _on_refresh_button_pressed(): retrieve_games()
