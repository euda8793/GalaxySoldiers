extends Node
class_name WeaponConfigurations


func ready():
	for c in get_children():
		if not c is Weapon:
			print("Warning: something other than a 'Weapon' is used as child, please correct")
			
