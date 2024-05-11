extends Control


################################################################################
##################################  NODES  #####################################

var custom_controls_scheme_select
var custom_controls_grid : GridContainer

################################################################################
################################  VARIABLES  ###################################

var current_menu = null
var input_configs : Array[InputConfig]

################################################################################
#################################  SIGNALS  ####################################

signal start_game
signal quit_game

################################################################################
#######################  MENU INTERACTIONS FUNCTIONS  ##########################

func _on_play_button_pressed():
	emit_signal("start_game")


func _on_quit_button_pressed():
	emit_signal("quit_game")


func _on_nav_button_pressed(button):
	open_menu(button.name.replace("Button", "Menu"))


func _on_go_back_button_pressed():
	if current_menu && current_menu.parent_menu:
		open_menu(current_menu.parent_menu.name)
	else:
		open_menu("MainMenu")


func _on_scheme_select_item_selected(index):
	init_inputs_grid_with_scheme(input_configs[index])


################################################################################
######################  MENU IMPLEMENTATION FUNCTIONS  #########################

func _ready():
	current_menu = $MainMenu
	custom_controls_scheme_select = $CustomizeControlsMenu/VBoxContainer/HBoxContainer/SchemeSelect
	custom_controls_grid = $CustomizeControlsMenu/VBoxContainer/InputsGrid

	init_navbuttons_to_open_submenus()
	
	$AnimationPlayer.play("ShowAnimatedBackground")
	$MenuBgAnimated.play("LogoReveal")

	input_configs = [
	 	InputConfig.new("user://control_scheme_wasd_mouse.cfg"),
		InputConfig.new("user://control_scheme_mouse_only.cfg")
	]

	init_input_configs_select()
	init_inputs_grid_with_scheme(input_configs[0])


func init_input_configs_select():
	for config in input_configs:
		custom_controls_scheme_select.add_item(config.name)


func init_navbuttons_to_open_submenus():
	var nav_buttons = get_tree().get_nodes_in_group("MenuNavButton")

	for button in nav_buttons:
		button.connect("pressed", _on_nav_button_pressed.bind(button))


func open_menu(menu_name : String):
	var menu = get_node(NodePath(menu_name))
	var previous_menu = current_menu.name if current_menu else null

	if current_menu:
		current_menu.visible = false
		current_menu = null

	menu.visible = true
	current_menu = menu

	$GoBackButton.visible = menu_name != "MainMenu"

	if menu_name == "MainMenu":
		$AnimationPlayer.play("ShowAnimatedBackground")
		$MenuBgAnimated.play("LogoReveal")
		$MenuBg/MenuBgRect.visible = false
	elif previous_menu == "MainMenu" || previous_menu == null:
		$AnimationPlayer.play("HideAnimatedBackground")
		$MenuBgAnimated.play("LogoHide")
		$MenuBg/MenuBgRect.visible = true

	
func read_controls_scheme(path):
	var config = ConfigFile.new()
	config.load(path)


func init_inputs_grid_with_scheme(input_config : InputConfig):
	var is_locked = input_config.config.get_value("INFO", "Locked", false)

	# Show error messages 
	if input_config.config.get_value("INFO", "Locked", false):
		$CustomizeControlsMenu/VBoxContainer/ErrorLabel.text = "[!] This scheme is locked. Make a copy of it to customize."

	$CustomizeControlsMenu/VBoxContainer/ErrorLabel.visible = $CustomizeControlsMenu/VBoxContainer/ErrorLabel.text.length() > 0

	# Init fields
	$CustomizeControlsMenu/VBoxContainer/GridContainer/MoveWithMouseCheckbox.button_pressed = input_config.config.get_value("INFO", "Move with mouse", false)
	$CustomizeControlsMenu/VBoxContainer/HBoxContainer3/TextEdit.text = input_config.name
	
	$CustomizeControlsMenu/VBoxContainer/GridContainer/MoveWithMouseCheckbox.disabled = is_locked
	$CustomizeControlsMenu/VBoxContainer/HBoxContainer3/TextEdit.editable = !is_locked


	# Masks for input actions to ignore
	var input_ignore_masks = ["ui_.*"]
	
	# Clear gird
	for child in custom_controls_grid.get_children():
		child.queue_free()


	# Going through all of the input actions and adding them to the grid with proper controls, if they were set
	for action_name in InputMap.get_actions():
		action_name = String(action_name)
		var ignore = false
		var regex = RegEx.new()
		
		for mask in input_ignore_masks:
			regex.compile(mask)
			if regex.search(action_name):
				ignore = true
				break

		if ignore:
			continue

		var action = load("res://GameObjects/Menu/ActionKey.tscn").instantiate()
		action.action_name = action_name

		# Find primary input
		var primary_input = input_config.config.get_value("Keyboard", action_name, "")
		var input_type = 0

		if !primary_input:
			primary_input = input_config.config.get_value("Mouse", action_name, "")
			input_type = 1

		if !primary_input:
			push_error("Primary input not found for " + action_name)
		else:
			action.set_primary_input(primary_input, input_type)

		# Find secondary input
		input_type = 0
		var secondary_input = input_config.config.get_value("KeyboardAlt", action_name, "")

		if !secondary_input:
			secondary_input = input_config.config.get_value("MouseAlt", action_name, "")

		if !secondary_input:
			push_error("Secondary input not found for " + action_name)
		else:
			action.set_secondary_input(secondary_input, input_type)

		# Final setup
		custom_controls_grid.add_child(action)	
		action.editable = !input_config.config.get_value("INFO", "Locked", false)
		action.setup()
