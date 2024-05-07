extends Control


################################################################################
################################  VARIABLES  ###################################

var current_menu = null

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


################################################################################
######################  MENU IMPLEMENTATION FUNCTIONS  #########################

func _ready():
	init_navbuttons_to_open_submenus()
	current_menu = $MainMenu
	
	$AnimationPlayer.play("ShowAnimatedBackground")
	$MenuBgAnimated.play("LogoReveal")


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
	elif previous_menu == "MainMenu" || previous_menu == null:
		$AnimationPlayer.play("HideAnimatedBackground")
		$MenuBgAnimated.play("LogoHide")

