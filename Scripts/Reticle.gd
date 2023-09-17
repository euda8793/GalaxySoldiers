extends Control
class_name Reticle

@onready
var tree := %"AnimationTree" as AnimationTree

var state_machine : AnimationNodeStateMachinePlayback

func _ready():
	state_machine = tree["parameters/playback"]

func start():
	state_machine.travel("BackAndForth")

func stop():
	state_machine.travel("End")
