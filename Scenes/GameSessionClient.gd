extends HTTPRequest
class_name GameSessionClient

const base_url := "https://localhost:7270"
const grouped_endpoint := "/GameSessions/"

const GAME_SESSIONS := "gameSessions"
const INFO_TYPE := "informationType"
const ICE_CAND := "iceCandidate"
const SESSION_DESC := "sessionDescription"
const SIGNALING_STEPS := "signalingStepResults"

const NET_RESPONSE_INCORRECT := "Network response incorrect"
const GAME_SESSIONS_RESPONSE_INCORRECT := "Game sessions response incorrect"
const SIGNALING_STEPS_MISSING = "Signaling steps missing"

var api_key := ""
var game_session_name := ""

signal log_error(msg : String)

func _verify_network_response(dict : Dictionary) -> bool:
	var result := dict.has(INFO_TYPE) and (dict.has(ICE_CAND) or dict.has(SESSION_DESC))
	if not result: log_error.emit(NET_RESPONSE_INCORRECT)
	return result

func _verify_game_sessions_response(dict : Dictionary) -> bool:
	var result := dict.has(GAME_SESSIONS)
	if not result: log_error.emit(GAME_SESSIONS_RESPONSE_INCORRECT)
	return result
	
func _verify_signaling_steps(dict : Dictionary) -> bool:
	var result = dict.has(SIGNALING_STEPS)
	if not result: 
		log_error.emit(SIGNALING_STEPS_MISSING)
		return result
	
	for s in dict[SIGNALING_STEPS]:
		if not _verify_network_response(s): return false
	
	return true
	
func _get_request(url : String) -> Dictionary:
	return {}

func _post_request(url : String, data : Dictionary) -> String:
	return ""
	
func _put_request_data(url : String, data : Dictionary) -> String:
	return ""
	
func _put_request(url : String) -> String:
	return ""
	
func _delete_request(url : String) -> String:
	return ""
	
func set_api_key(new_api_key : String) -> void:
	api_key = new_api_key
	
func get_game_sessions(count : int) -> Array[String]:
	var result := _get_request(str(count))
	if not _verify_game_sessions_response(result): return []
	return result[GAME_SESSIONS]

func get_player_status(player_name : String) -> Dictionary:
	var result := _get_request("%s/Player/%s/SignalStatus" % [game_session_name, player_name])
	if not _verify_network_response(result): return {}
	return result

func get_host_status() -> Dictionary:
	var result := _get_request("%s/SignalingStatus" % game_session_name)
	if not _verify_signaling_steps(result): return {}
	return result
	
func host_game_session(new_game_session_name : String, host_player_name : String) -> void:
	game_session_name = new_game_session_name
	
func join_game_session(joined_game_session_name : String, joining_player : String) -> void:
	game_session_name = joined_game_session_name
	
func reconnect_game_session(game_session_name : String, reconnecting_player_name : String) -> void:
	pass
	
func leave_game_session(game_session_name : String, leaving_player_name : String) -> void:
	game_session_name = ""
	pass
	
func connected(game_session_name : String, connected_player_name : String) -> void:
	pass
	
func accept_as_player(accepting_player_name : String) -> void:
	pass
	
func accept_as_host(specific_player_name : String) -> void:
	pass
