extends KinematicBody2D

var velocity = Vector2()
var damping = 0
var swipe_started = false
var swipe_start = Vector2()
var minimum_drag = 0
var speed = 3500
var right = 0
var left = 0
var vertical = 0
var horizontal = 0


var CHECKRIGHT = false
var CHECKLEFT = false
var CHECKUP = false
var CHECKDOWN = false

var exclusive = false

var Left_Ground_In_Right = 0
var Left_Ground_In_Left = 0

var RIGHTWALL = false
#onready var touch_button = get_node("TouchScreenButton")


onready var hand_down = get_node("/root/Node2D/Camera2D/HandDown")

onready var playsound = get_node("/root/Node2D/MusicAndVFX/AudioStreamPlayer")
onready var Music = get_node("/root/Node2D/MusicAndVFX/AudioStreamPlayer2")
onready var WinMusic = get_node("/root/Node2D/MusicAndVFX/WinMusic")
onready var anim2 = get_node("/root/Node2D/AnimationPlayer2")
onready var anim = get_node("/root/Node2D/AnimationPlayer")
onready var anim3 = get_node("/root/Node2D/AnimationPlayer3")
onready var player = get_node("/root/Node2D/KinematicBody2D/Sprite")
onready var DashLeft = get_node("/root/Node2D/KinematicBody2D/Sprite4")
onready var DashRight = get_node("/root/Node2D/KinematicBody2D/Sprite3")
onready var Block = get_node("/root/Node2D/AnimationPlayer4")
onready var RightUpGoLeftSprite = get_node("/root/Node2D/KinematicBody2D/Sprite6")
onready var RightUpGoLeftAnim = get_node("/root/Node2D/AnimationPlayer5")
onready var LeftUpGoRightSprite = get_node("/root/Node2D/KinematicBody2D/Sprite7")
onready var LeftUpGoRightAnim = get_node("/root/Node2D/AnimationPlayer6")
onready var UpGoDownSprite = get_node("/root/Node2D/KinematicBody2D/Sprite8")
onready var UpGoDownAnim = get_node("/root/Node2D/AnimationPlayer7")
onready var UpGoDownLeftSprite = get_node("/root/Node2D/KinematicBody2D/Sprite9")
onready var UpGoDownLeftAnim = get_node("/root/Node2D/AnimationPlayer8")
onready var PlayerFlip = get_node("/root/Node2D/KinematicBody2D/SpriteFlip")
onready var PlayerFlipRight = get_node("/root/Node2D/KinematicBody2D/SpriteFlipRight")


onready var floor_ray_cast = get_node("/root/Node2D/KinematicBody2D/RayDown")
onready var ceiling_ray_cast = get_node("/root/Node2D/KinematicBody2D/RayUp")
onready var right_ray_cast = get_node("/root/Node2D/KinematicBody2D/RayRight")
onready var left_ray_cast = get_node("/root/Node2D/KinematicBody2D/RayLeft")

onready var StaticRight = get_node("/root/Node2D/KinematicBody2D/RightStale")
onready var StaticLeft = get_node("/root/Node2D/KinematicBody2D/LeftStale")
onready var StaticUp = get_node("/root/Node2D/KinematicBody2D/UpStale")
onready var StaticDown = get_node("/root/Node2D/KinematicBody2D/DownStale")

onready var IdleRightWall = get_node("IdleRightWall")
onready var IdleRightWallAnim = get_node("/root/Node2D/IdleRightWallAnim")

onready var IdleLeftWall = get_node("IdleLeftWall")
onready var IdleLeftWallAnim = get_node("/root/Node2D/IdleLeftWallAnim")

onready var IdleUpLeft = get_node("IdleUpLeft")
onready var IdleUpLeftAnim = get_node("/root/Node2D/IdleUpLeftAnim")

onready var IdleUpRight = get_node("IdleUpRight")
onready var IdleUpRightAnim = get_node("/root/Node2D/IdleUpRightAnim")
onready var animtest = get_node("/root/Node2D/AnimationPlayer9")

onready var spritetest = get_node("/root/Node2D/KinematicBody2D/Sprite10")

onready var Special = get_node("/root/Node2D/Special/StaticBody2D4/Hidden")

onready var CollideSFX = get_node("/root/Node2D/MusicAndVFX/Collide")

onready var StaticDownLeft = $StaticDownLeft
onready var IdleDownRight = $IdleDownRight
onready var IdleDownRightAnim = get_node("/root/Node2D/IdleDownRightAnim")

onready var IdleDownLeft = $IdleDownLeft
onready var IdleDownLeftAnim = get_node("/root/Node2D/IdleDownLeftAnim")

onready var Monitr = get_node("/root/Node2D/Special/StaticBody2D4/PlayerS")

onready var Cam = get_node("/root/Node2D/Camera2D")
onready var CamTween = get_node("/root/Node2D/Camera2D/Tween")

var EXITED = false

var ghostout_entered = false

var zabse = false
var Condition_Stale_And_Up = false

var zero = false
var game_started = false

var flash_duration = 1

var still_area = false

onready var original_special = self.modulate
var Notify_played = 0

onready var player_tween = $TweenPlayer

onready var canvas = get_node("/root/Node2D/WorldModulate/CanvasModulate")
onready var canvas_tween = get_node("/root/Node2D/WorldModulate/Tween")
onready var canvas_original = canvas.color

onready var EnterSound = get_node("/root/Node2D/MusicAndVFX/Enter")

onready var GameOverSound = get_node("/root/Node2D/MusicAndVFX/gameover")
onready var DeathAddon = get_node("/root/Node2D/MusicAndVFX/DeathAddon")

onready var Enter = get_node("/root/Node2D/AnimationPlayer10")
onready var EnterPortal = get_node("/root/Node2D/EnterArena")
onready var EnterPortalTween = get_node("/root/Node2D/EnterArena/Tween")

onready var hintSpecial = get_node("/root/Node2D/Special/Sprite")
onready var hintSpecialTween = get_node("/root/Node2D/Special/SpecialBlink/Tween")

#DOUBLETAP

onready var hand_doubleTap = get_node("/root/Node2D/Camera2D/DoubleTap")
onready var hand_doubleTap_anim = get_node("/root/Node2D/Camera2D/DoubleTap/AnimationPlayer")




onready var GlitchTheTiles = get_node("/root/Node2D/TileMaps/TileMap")

const SHAPE_CIRCLE = 0
const SHAPE_SQUARE = 1

onready var hand_doubleTap_tween = get_node("/root/Node2D/Camera2D/DoubleTap/Tween")


var canvas_modulate
var original_color
var original_special_ghost_out

onready var color_tween = get_node("/root/Node2D/WorldModulate/Tween")

onready var special = get_node("/root/Node2D/Special/StaticBody2D4/Hidden")
onready var special_tween = get_node("/root/Node2D/Special/StaticBody2D4/Hidden/Tween")

onready var Anomalies = get_node("/root/Node2D/Camera2D/Anomalies")
onready var Anomalies_Tween = get_node("/root/Node2D/Camera2D/Anomalies/Tween")

onready var Collision = get_node("/root/Node2D/Special/StaticBody2D4/CollisionShape2D")

onready var GhostOutTile_tween = get_node("/root/Node2D/Special/GhostOutTile/Tween")
onready var GhostOutTile = get_node("/root/Node2D/Special/GhostOutTile/StaticBody2D/TileMap")
onready var GhostOutTile_Cshape = get_node("/root/Node2D/Special/GhostOutTile/StaticBody2D/CollisionShape2D")

onready var Tilemap = get_node("/root/Node2D/TileMaps")
onready var Tilemap_Tween = get_node("/root/Node2D/TileMaps/Tween")

onready var Enemies = get_node("/root/Node2D/Enemies")
onready var Coins = get_node("/root/Node2D/Coins")
onready var GlitchEffect = get_node("/root/Node2D/Special/Sprite")

onready var Trap = get_node("/root/Node2D/Enemies/Trap")
onready var TrapKillMove = get_node("/root/Node2D/Enemies/Trap/KillMoves")
onready var TrapKillMoveSprite = get_node("/root/Node2D/Enemies/Trap/KillMoves/KillMoveEat")
onready var TrapKillMoveAnim = get_node("/root/Node2D/Enemies/Trap/KillMoves/KillMoveEat/KillMoveEat")
onready var TrapArea = get_node("/root/Node2D/Enemies/Trap/TrapArea")
onready var TrapsAnims = get_node("/root/Node2D/Enemies/EnemyAnims")

onready var Lightning = get_node("/root/Node2D/Enemies/Lightning")
onready var LightningAnim = get_node("/root/Node2D/Enemies/Lightning2")
onready var LightningKillMove = get_node("/root/Node2D/Enemies/Lightning/KillMoves")
onready var LightningKillMoveSprite = get_node("/root/Node2D/Enemies/Lightning/KillMoves/LightningKill")
onready var LightningKillMoveAnim = get_node("/root/Node2D/Enemies/Lightning/KillMoves/LightningKill/LightningKillAnim")
onready var LightningArea = get_node("/root/Node2D/Enemies/Lightning/LightningArea")

onready var Lantern = get_node("/root/Node2D/Lantern/WinAnimations")
onready var LanternAnims = get_node("/root/Node2D/Lantern/WinAnimations/GoodWin/GoodWinAnim")
onready var LanternArea = get_node("/root/Node2D/Lantern/GoBackToMenu")

##KILLSOUNDS
#onready var GuardianKillSound = get_node("/root/Node2D/MusicAndVFX/GuardianKill")

#DISPLAYS

onready var UI = get_node("/root/Node2D/CanvasLayer3/UI")
onready var UITween = get_node("/root/Node2D/CanvasLayer3/UI/Tween")

onready var Pause = get_node("/root/Node2D/CanvasLayer/Pause")
onready var PauseTween = get_node("/root/Node2D/CanvasLayer/Pause/Tween")

##SPECIAL SOULS

onready var SpecialSouls = get_node("/root/Node2D/SpecialCoins")
onready var SpecialSoulsTween = get_node("/root/Node2D/SpecialCoins/Tween")

onready var GhostDeadCollision = get_node("/root/Node2D/Camera2D/GhostDead/CollisionShape2D")

onready var GhostDead = get_node("/root/Node2D/Camera2D/GhostDead")
onready var GhostDeadTween = get_node("/root/Node2D/Camera2D/GhostDead/Tween")

onready var RestartLevel = get_node("/root/Node2D/Camera2D/RestartLevel")
onready var RestartLevelTween = get_node("/root/Node2D/Camera2D/RestartLevel/Tween")

onready var GoBackMenu = get_node("/root/Node2D/Camera2D/BackToMenu")
onready var GoBackMenuTween = get_node("/root/Node2D/Camera2D/BackToMenu/Tween")

signal player_detected(is_detected)  # Declare the signal here

##TIMERS FIX THE BROKEN YIELD

var timer1 = Timer.new()
var timer2 = Timer.new()
var timer3 = Timer.new()

func _ready(): #KINEMATICBODY JE NASTAVENE NA 0 SCALE VOLE TYX VORLE
	UI.modulate.a = 0
	Pause.modulate.a = 0
	SpecialSouls.modulate.a = 0
	
	Global.health = 100
	Global.coins_can_store = true
	Global.can_collect_coins = false
	Global.can_collect_souls = false
	Global.PickedUpLord = false
	Global.PickedUpEvil = false
	Global.coins_can_store = true
	Global.lock = 0
	Global.can_be_paused = true
	Global.anomaly_notif = 0
	Global.SpecialDeath = false
	Global.General_SpecialDeath = false
	Global.level_passed = false
	Global.guardian_activated = false
	
	RestartLevel.modulate.a = 0
	GhostDead.modulate.a = 0
	GoBackMenu.modulate.a = 0
	
	GhostDeadCollision.disabled = true
	Music.volume_db = -14
	self.scale = Vector2(0.05, 0)
	Global.on_player_stayed = false ## fixes the orange bug where everything is orange after finishing level
	canvas_modulate = get_node("/root/Node2D/WorldModulate/CanvasModulate")
	# Store the original color
	original_color = canvas_modulate.color
	original_special_ghost_out = special.modulate
	
	var timer = Timer.new()  # Create a new Timer node
	timer.wait_time = 2.3  # Set the timer to wait for 3 seconds
	timer.one_shot = true  # Set the timer to only trigger once
	timer.connect("timeout", self, "_on_Timer_timeout")  # Connect the timer's timeout signal to a function
	add_child(timer)  # Add the timer as a child of the current node
	
	timer.start()  # Start the timer
	
	self.add_child(timer1)
	self.add_child(timer2)
	self.add_child(timer3)
	
	timer1.one_shot = true
	timer2.one_shot = true
	timer3.one_shot = true
	
	timer1.wait_time = 0.1
	timer2.wait_time = 0.5
	timer3.wait_time = 3.0
	
	timer1.connect("timeout", self, "_on_timer_timeout1")
	timer2.connect("timeout", self, "_on_timer_timeout2")
	timer3.connect("timeout", self, "_on_timer_timeout3")
	
	timer1.start()

var is_dying = false

func HandleDeath():
	var CamTween2 = get_node("/root/Node2D/Camera2D/Tween2")
	if game_started and not is_dying:
		
		is_dying = true ##Flag that prevents this function from being called multiple times
		
		Global.reset_souls()
		Global.reset_coins()
		Global.health = 0
		
		Global.can_be_paused = false
		Global.can_touch = false
		var TurnOffPause = get_node("/root/Node2D/CanvasLayer/Pause")
		var TurnOffPauseTween = get_node("/root/Node2D/CanvasLayer/Pause/Tween")
		 
		# Create ascending soul particles
		TurnOffPauseTween.interpolate_property(TurnOffPause, "modulate",
			Color(1,1,1,1),
			Color(1,1,1,0),
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		TurnOffPauseTween.start()
		
		
		
		UITween.interpolate_property(UI, "modulate",
			Color(1,1,1,1),
			Color(1,1,1,0),
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		UITween.start()
		
		CamTween.interpolate_property(Cam, "offset",
			Cam.offset,  # Start from current zoom
			Vector2(0, 0),  # Zoom in
			0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		var p_Died = get_node("/root/Node2D/Camera2D/DeathExplosion")
		var GameOverSound2 = get_node("/root/Node2D/MusicAndVFX/GameOver2")
		print("dead")
		p_Died.emitting = true
#			GameOverSound.play()
		DeathAddon.play()
		GameOverSound2.play()
		Music.volume_db = -30
		CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(2.3, 2.3),  # Zoom out
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		canvas.color = Color(0.2, 0.2, 0.2, 1)  # Set initial transparent modulate
		canvas_tween.interpolate_property(canvas, "color",
			canvas_original,  # Start from transparent
			canvas.color,  # Fade to opaque
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		canvas_tween.start()
		player_tween.interpolate_property(self, "modulate",
			self.modulate,  # Start from transparent
			Color(self.modulate.r, self.modulate.g, self.modulate.b, 0),  # Fade to opaque
			0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		player_tween.start()
		yield(player_tween, "tween_all_completed")  # Wait for all tweens to comple
		self.visible = false
		yield(get_tree().create_timer(1), "timeout")
		canvas_tween.interpolate_property(canvas, "color",
			canvas.color,  # Fade to opaque
			canvas_original,  # Start from transparent
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		canvas_tween.start()
		yield(get_tree().create_timer(0.2), "timeout")
		CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(1.65, 1.65),  # Zoom out
			0.8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		Music.stop()
		WinMusic.play()
		TurnOffPause.visible = false
		##Section
		Global.change_world_modulate(Color(0.7, 0.64, 1, 0.35))
# warning-ignore:unused_variable
		var AfterDeathParticles = preload("res://AfterDeathParticles.tscn").instance()
		get_parent().add_child(AfterDeathParticles)
		AfterDeathParticles.setup_ascension(self.position)
		
		# After particles reach the top, form soul shape
		AfterDeathParticles.forming_soul = true
		CamTween2.interpolate_property(Cam, "offset",
			Cam.offset,  # Start from current zoom
			Vector2(0, -1200),  # Zoom out
			0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween2.start()
#		self.position.y = -900
#		self.visible = true
		yield(get_tree().create_timer(0.5), "timeout")
		

		# Define soul shape points
		CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(0.8, 0.8),  # Zoom out
			0.8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		
		yield(get_tree().create_timer(0.4), "timeout")
		
		var soul_shape = [
			Vector2(0, -10), Vector2(5, -5), Vector2(10, 0),
			Vector2(5, 5), Vector2(0, 10), Vector2(-5, 5),
			Vector2(-10, 0), Vector2(-5, -5)
		]
#
		# Update particle properties for soul formation
		AfterDeathParticles.emitting = false
		GhostDead.visible = true
		RestartLevel.visible = true
		GoBackMenu.visible = true
		GhostDeadCollision.disabled = false
		GhostDeadTween.interpolate_property(GhostDead, "modulate",
			Color(1,1,1,0),  
			Color(1,1,1,1),
			1.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		GhostDeadTween.start()
		
		RestartLevelTween.interpolate_property(RestartLevel, "modulate",
			Color(1,1,1,0),  
			Color(1,1,1,1),
			3.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		RestartLevelTween.start()
		
		GoBackMenuTween.interpolate_property(GoBackMenu, "modulate",
			Color(1,1,1,0),  
			Color(1,1,1,1),
			3.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		GoBackMenuTween.start()
#		var PassedText = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/ChamberText")
#		var PassedMenu = get_node("/root/Node2D/CanvasLayer2/passed/Sprite")
#		var buttonTextChange = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/NextLevel/LevelNext")
#		player_tween.interpolate_property(self, "modulate",
#			self.modulate,  # Start from transparent
#			Color(self.modulate.r, self.modulate.g, self.modulate.b, 1),  # Fade to opaque
#			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		player_tween.start()
	
#		var PassedText = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/ChamberText")
#		var PassedMenu = get_node("/root/Node2D/CanvasLayer2/passed/Sprite")
#		var buttonTextChange = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/NextLevel/LevelNext")
#		PassedText.text = "You Perished"
#		buttonTextChange.text = "<\\\\\\"
#		PassedMenu.modulate.r = 1.3
#		PassedMenu.modulate.g = 0.5
#		PassedMenu.modulate.b = 1
#		PassedText.modulate.g = 3
#		PassedText.modulate.b = 4
#		PassedText.modulate.a = 1.5
#		PassedText.rect_position.x = -258
#		TurnOffPause.visible = false ## Turn off pause menu visibility when level passed
#		var Finish = get_node("/root/Node2D/CanvasLayer2/passed/Sprite")
#		var Finish_IN = get_node("/root/Node2D/CanvasLayer2/passed")
#		Finish_IN.visible = true
#		var Finish_tween = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/Tween")
#		Finish_tween.interpolate_property(Finish, "modulate",
#			Color(1.3,0.5,1,0),
#			Color(1.3,0.5,1,0.8),
#			0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		Finish_tween.start()
#		yield(get_tree().create_timer(0.3), "timeout")


func _on_Timer_timeout(): # on START timeout the player can move the player
	Global.can_touch = true 
	Global.can_collect_coins = true
	
	PauseTween.interpolate_property(Pause, "modulate",
		Color(1,1,1,0),
		Color(1,1,1,1),
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	PauseTween.start()
	
	UITween.interpolate_property(UI, "modulate",
		Color(1,1,1,0),
		Color(1,1,1,1),
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	UITween.start()
	
	SpecialSoulsTween.interpolate_property(SpecialSouls, "modulate",
		Color(1,1,1,0),
		Color(1,1,1,1),
		1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	SpecialSoulsTween.start()
	Global.coins_collected = 0
	Global.evil_souls = 0
	Global.angel_souls = 0
	 # Enable touch input after the timer has finished
#onready var touch_button = get_node("/root/KinematicBody2DchScreenButton") 

func _on_timer_timeout1():
	game_started = true
	Global.game_started = true
	
	CamTween.interpolate_property(Cam, "zoom",
		
		Cam.zoom,  # Start from current zoom
		Vector2(1.61, 1.61),  # Zoom out
		2.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	CamTween.start()
	
	EnterPortalTween.interpolate_property(EnterPortal, "modulate",
		
		EnterPortal.modulate,  # Start from current zoom
		Color(EnterPortal.modulate.r, EnterPortal.modulate.g, EnterPortal.modulate.b, 0.5),
		3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	EnterPortalTween.interpolate_property(EnterPortal, "scale",
		
		EnterPortal.scale,  # Start from 0 scale
		Vector2(0.05, 0.05),  # Scale to normal size
		0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
		
	EnterPortalTween.start()
	
	player_tween.interpolate_property(self, "scale",
		
		self.scale,
		Vector2(0.9, 0.8),  # Scale to normal size
		1, Tween.TRANS_QUAD, Tween.EASE_OUT)
		
	player_tween.start()
	
	self.modulate = Color(self.modulate.r, self.modulate.g, self.modulate.b, 0)  # Set initial transparent modulate
	
	player_tween.interpolate_property(self, "modulate",
		
		self.modulate,  # Start from transparent
		Color(original_special),  # Fade to opaque
		1, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		
	player_tween.start()
	
	IdleDownRight.visible = true
	IdleDownRightAnim.play("IdleDownR")
	timer2.start()

func _on_timer_timeout2():
	Enter.play("Enter")
	EnterSound.play()
	timer3.start()
	Global.can_collect_souls = true
	
	
func _on_timer_timeout3():
	TrapsAnims.play("Trap")
	EnterPortalTween.interpolate_property(EnterPortal, "modulate",
		
		EnterPortal.modulate,  # Start from current zoom
		Color(EnterPortal.modulate.r, EnterPortal.modulate.g, EnterPortal.modulate.b, 0.1),
		2, Tween.TRANS_CIRC, Tween.EASE_OUT)
	EnterPortalTween.start()

func _input(event) -> void:
	if event is InputEventScreenTouch and Global.can_touch:
		if event.pressed:
			swipe_started = true
			swipe_start = event.position
		elif !event.pressed and swipe_started:
			var swipe_end = event.position
			var swipe = swipe_end - swipe_start
			if swipe.length() > minimum_drag:
				playsound.play()
				
				var angle = atan2(swipe.y, swipe.x)
				if abs(angle) < PI/4 or abs(angle) > 3*PI/4:
					# Horizontal movement
					velocity = Vector2(swipe.x, 0).normalized() * speed
					if abs(angle) < PI/4:
						# Moving right
						Global.PlayerMovingRight = true
						Global.PlayerMovingLeft = false
						IdleRightWall.visible = false
						IdleLeftWall.visible = false
						player.visible = false
						IdleDownRight.visible = false
						DashLeft.visible = false
						DashRight.visible = true
						anim2.play("dash")
						UpGoDownSprite.visible = false
						RightUpGoLeftSprite.visible = false
						UpGoDownLeftSprite.visible = false
						StaticRight.visible = false
						LeftUpGoRightSprite.visible = false
						PlayerFlip.visible = false
						StaticLeft.visible = false
						CHECKLEFT = false
						exclusive = false
						CHECKUP = false
						spritetest.visible = false
						zabse = false
						StaticUp.visible = false
						StaticDownLeft.visible = false
						IdleDownLeft.visible = false
						PlayerFlipRight.visible = false
						IdleUpLeft.visible = false
						IdleUpRight.visible = false
						StaticDown.visible = false
						horizontal = 1
						right = 1
						vertical = 0
						CHECKDOWN = false
						left = 0
					elif abs(angle)  > 3*PI/4:
						# Moving left
						Global.PlayerMovingLeft = true
						Global.PlayerMovingRight = false
						IdleRightWall.visible = false
						IdleLeftWall.visible = false
						DashLeft.visible = true
						anim3.play("DashLeft")
						RightUpGoLeftSprite.visible = false
						UpGoDownSprite.visible = false
						horizontal = 1
						LeftUpGoRightSprite.visible = false
						UpGoDownLeftSprite.visible = false
						player.visible = false
						IdleDownRight.visible = false
						CHECKRIGHT = false
						StaticRight.visible = false
						StaticDownLeft.visible = false
						IdleDownLeft.visible = false
						StaticLeft.visible = false
						exclusive = false
						CHECKUP = false
						IdleUpLeft.visible = false
						IdleUpRight.visible = false
						StaticDown.visible = false
						zabse = false
						CHECKDOWN = false
						PlayerFlip.visible = false
						StaticUp.visible = false
						PlayerFlipRight.visible = false
						spritetest.visible = false
						DashRight.visible = false
						left = 1
						vertical = 0
						right = 0
					if CHECKRIGHT == true:
						CHECKUP = false
						StaticUp.visible = false
						IdleUpRight.visible = false
						IdleLeftWall.visible = false
						zero = false
						StaticDown.visible = false
						StaticDownLeft.visible = false
						IdleDownLeft.visible = false
						IdleRightWall.visible = true
						zabse = false
						spritetest.visible = false
						CHECKDOWN = false
						IdleUpLeft.visible = false
						player.visible = false
						IdleDownRight.visible = false
						exclusive = false
						DashRight.visible = false
						StaticRight.visible = true
						yield(get_tree().create_timer(0.0001), "timeout")
						StaticRight.visible = false
					if CHECKLEFT == true:
						IdleLeftWall.visible = true
						StaticDown.visible = false
						zero = false
						CHECKDOWN = false
						StaticUp.visible = false
						StaticDownLeft.visible = false
						IdleDownLeft.visible = false
						IdleUpRight.visible = false
						spritetest.visible = false
						player.visible = false
						IdleDownRight.visible = false
						zabse = false
						IdleUpLeft.visible = false
						IdleRightWall.visible = false
						CHECKUP = false
						exclusive = false
						DashLeft.visible = false
						StaticLeft.visible = true
						yield(get_tree().create_timer(0.0001), "timeout")
						StaticLeft.visible = false
#					if anim2.is_playing() and speed == 0:
#						IdleRightWall.visible = true
#						IdleLeftWall.visible = false
#						IdleRightWallAnim.play("IdleR")
#						yield(get_tree().create_timer(0.5), "timeout")
#						anim2.stop(false)
#						DashRight.visible = false
#						DashLeft.visible = false
#						print("playing right")
#					if anim3.is_playing() and speed == 0:
#						IdleRightWall.visible = false
#						IdleLeftWall.visible = true
#						IdleLeftWallAnim.play("IdleL")
#						yield(get_tree().create_timer(0.5), "timeout")
#						anim3.stop(false)
#						DashRight.visible = false
#						DashLeft.visible = false
#						print("playing left")
				else:
					# Vertical movement
					vertical = 1
					horizontal = 0
					DashLeft.visible = false
					StaticLeft.visible = false
					StaticDown.visible = false
					IdleUpRight.visible = false
					DashRight.visible = false
					IdleLeftWall.visible = false
					IdleRightWall.visible = false
					StaticUp.visible = false
					spritetest.visible = false
					player.visible = false 
					IdleDownRight.visible = false
					IdleUpLeft.visible = false
					StaticRight.visible = false
					PlayerFlip.visible = false
					PlayerFlipRight.visible = false
					exclusive = false
					velocity = Vector2(0, swipe.y).normalized() * speed
				if right == 0 and left == 0 and zero and vertical == 1:
					zabse = true
				else:
					zabse = false
				if swipe.y > 0 and right == 1 and vertical == 1: #pridano right = 0 muze zpusobovat problemy
					IdleDownRight.visible = true
					IdleDownRightAnim.play("IdleDownR")
					UpGoDownSprite.visible = false
					StaticDown.visible = false
					PlayerFlip.visible = false
					LeftUpGoRightSprite.visible = false
					IdleUpLeft.visible = false
					IdleRightWall.visible = false
					CHECKDOWN = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					exclusive = false
					IdleLeftWall.visible = false
					IdleUpRight.visible = false
					StaticLeft.visible = false
					StaticUp.visible = false
					spritetest.visible = false
					CHECKUP = false
					zabse = false
					StaticRight.visible = false
					zero = false
					UpGoDownLeftSprite.visible = false
					PlayerFlipRight.visible = false
					print("swipe.y > 0 and right == 1 and vertical == 1")
				if swipe.y < 0 and right == 1 and vertical == 1:
					exclusive = false
					IdleUpLeft.visible = true
					IdleUpLeftAnim.play("IdleUpL")
					UpGoDownSprite.visible = false
					CHECKDOWN = false
					IdleLeftWall.visible = false
					StaticLeft.visible = false
					IdleRightWallAnim.stop(false)
					IdleRightWall.visible = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					IdleUpRight.visible = false
					zabse = false
					StaticDown.visible = false
					zero = false
					StaticUp.visible = false
					player.visible = false
					IdleDownRight.visible = false
					spritetest.visible = false
					StaticRight.visible = false
					CHECKUP = false
					UpGoDownLeftSprite.visible = false
					PlayerFlipRight.visible = false
					PlayerFlip.visible = true
					yield(get_tree().create_timer(0.0001), "timeout")
					PlayerFlip.visible = false
					print(" swipe.y < 0 and right == 1 and vertical == 1:")
				if swipe.y > 0 and left == 1 and vertical == 1: #pridano left = 0 muze zpusobovat problemy
					IdleDownLeft.visible = true
					IdleDownLeftAnim.play("IdleDownL")
					IdleLeftWall.visible = false
					UpGoDownSprite.visible = false
					IdleRightWall.visible = false
					StaticLeft.visible = false
					spritetest.visible = false
					IdleUpRight.visible = false
					CHECKUP = false
					UpGoDownLeftSprite.visible = false
					StaticRight.visible = false
					StaticDown.visible = false
					CHECKDOWN = false
					StaticUp.visible = false
					PlayerFlip.visible = false
					PlayerFlipRight.visible = false
					print("swipe.y > 0 and left == 1 and vertical == 1:")
				elif swipe.y < 0 and left == 1 and vertical == 1:
					StaticLeft.visible = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					IdleUpRight.visible = true
					IdleUpRightAnim.play("IdleUpR")
					UpGoDownSprite.visible = false
					IdleUpLeft.visible = false
					IdleRightWall.visible = false
					IdleLeftWall.visible = false
					StaticDown.visible = false
					CHECKDOWN = false
					CHECKUP = false
					StaticRight.visible = false
					player.visible = false
					IdleDownRight.visible = false
					StaticUp.visible = false
					spritetest.visible = false
					exclusive = false
					UpGoDownLeftSprite.visible = false
					PlayerFlipRight.visible = false
					print("swipe.y < 0 and left == 1 and vertical == 1:")
#
				if right == 0 and left == 0 and swipe.y < 0:
					RightUpGoLeftSprite.visible = true
					RightUpGoLeftAnim.play("RightUPgoLeft")
					player.visible = false
					IdleDownRight.visible = false
					PlayerFlip.visible = false
					StaticLeft.visible = false
					IdleUpRight.visible = false 
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					IdleLeftWall.visible = false
					IdleRightWall.visible = false
					zabse = false
					PlayerFlipRight.visible = false
					UpGoDownSprite.visible = false
					DashLeft.visible = false
					DashRight.visible = false
					CHECKDOWN = false
					StaticRight.visible = false
					CHECKUP = true
					UpGoDownLeftSprite.visible = false
					StaticUp.visible = false
					StaticDown.visible = false
					LeftUpGoRightSprite.visible = false
					exclusive = false
					player.visible = false
					IdleDownRight.visible = false
					IdleUpLeft.visible = false
				else:
					pass
				if CHECKUP == true:
					IdleRightWall.visible = false
					player.visible = false
					IdleDownRight.visible = false
					IdleUpRight.visible = false
					CHECKUP = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					LeftUpGoRightSprite.visible = false
					IdleLeftWall.visible = false
					IdleUpLeft.visible = true
					IdleUpLeftAnim.play("IdleUpL")
					RightUpGoLeftSprite.visible = false
					spritetest.visible = false
					CHECKDOWN = false
				if right == 0 and left == 0 and swipe.y > 0:
					LeftUpGoRightSprite.visible = false
					player.visible = false
					IdleDownRight.visible = false
					IdleUpLeft.visible = false
					IdleRightWall.visible = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					IdleUpRight.visible = false
					IdleLeftWall.visible = false
					UpGoDownSprite.visible = true
					spritetest.visible = false
					StaticLeft.visible = false
					CHECKUP = false
					CHECKDOWN = true
					DashLeft.visible = false
					DashLeft.visible = false
					StaticUp.visible = false
					StaticRight.visible = false
					PlayerFlip.visible = false
					PlayerFlipRight.visible = false
					UpGoDownAnim.play("FromUPgoDown")
					UpGoDownLeftSprite.visible = false
					StaticDown.visible = false
#					exclusive = true
					print("right == 0 and left == 0 and swipe.y > 0")
					
				elif zabse:
					UpGoDownSprite.visible = false
					RightUpGoLeftSprite.visible = false
					
				if CHECKDOWN == true: ##USE FOR IDLE UP DOWN RIGHT
					UpGoDownSprite.visible = false
					IdleRightWall.visible = false
					IdleLeftWall.visible = false
					StaticDownLeft.visible = false
					IdleDownLeft.visible = false
					zabse = false
					CHECKUP = false
					RightUpGoLeftSprite.visible = false
					LeftUpGoRightSprite.visible = false
					IdleDownRight.visible = true
					IdleDownRightAnim.play("IdleDownR")
					CHECKDOWN = false
					spritetest.visible = false
					IdleUpLeft.visible = false
					exclusive = false
##
###					if swipe.y > 0 and half_right == 1:
###						half_right = 0
###						print("Swipe down go back right")
###
###					elif swipe.y > 0 and half_left == 1:
###						half_left = 0
###						print("Swipe down go back left")
###			swipe_started = false
###			if right == 1 and swipe.y < 0:
###				Block.play("block")
###				right = 0
###				half_right = 1
###
###			elif left == 1 and swipe.y < 0:
###				print("LEFT")
###				Block.play("block")
###				left = 0
###				half_left = 1
###
##
var was_on_ceiling = false
var was_on_right_wall = false
var was_on_left_wall = false
var was_on_floor = false


func _physics_process(_delta):
	
	drawback()
	
	if !Global.is_flashing and $Tween.is_active():
		$Tween.stop(self)
		self.modulate = Color(self.modulate.r, self.modulate.g, self.modulate.b, 1)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Global.SpecialDeath:
		var hand_move_right = get_node("/root/Node2D/Camera2D/TutorialHand")
		var tutorialHandUp = get_node("/root/Node2D/Camera2D/HandUp")
		var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
		Global.can_touch = false
		speed = 0
#		self.visible = false
		
		hand_move_right.visible = false
		tutorialHandUp.visible = false
		hand_move_down.visible = false
		hand_doubleTap.visible = false
		

	if Global.General_SpecialDeath:
		var hand_move_right = get_node("/root/Node2D/Camera2D/TutorialHand")
		var tutorialHandUp = get_node("/root/Node2D/Camera2D/HandUp")
		var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
		Global.can_touch = false
		speed = 0
#		self.visible = false
		
		hand_move_right.visible = false
		tutorialHandUp.visible = false
		hand_move_down.visible = false
		hand_doubleTap.visible = false
#		self.position = Global.PlayerPosition
	
	if Global.on_player_stayed == true and EXITED == false and !Global.tile_dissapear:
		velocity = Vector2(0, 1).normalized() * speed
		Global.on_player_stayed = false
		$WrongAddon.play()
		$Wrong.play()
		Global.Ended = false
		print("flush")
#		Monitr.monitoring = false
#		Monitr.monitorable = false
		canvas.color = Color(2, 1, 0.5, 0.7)  # Set initial transparent modulate
		canvas_tween.interpolate_property(canvas, "color",
			canvas_original,  # Start from transparent
			canvas.color,  # Fade to opaque
			2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		canvas_tween.start()
		hintSpecialTween.interpolate_property(hintSpecial, "modulate",
			Color(1.87, 1, 1, 0.54), 
			Color(1.87, 1, 1, 0), 
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hintSpecialTween.start()
		yield(get_tree().create_timer(0.5), "timeout")
		hintSpecial.visible = false
		yield(get_tree().create_timer(1), "timeout")
		canvas_tween.interpolate_property(canvas, "color",
			canvas.color,  # Fade to opaque
			canvas_original,  # Start from transparent
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		canvas_tween.start()
		yield(get_tree().create_timer(1), "timeout")
		hintSpecial.visible = true
		hintSpecialTween.interpolate_property(hintSpecial, "modulate",
			Color(1.87, 1, 1, 0),
			Color(1.87, 1, 1, 0.54), 
			0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hintSpecialTween.start()
	if $RayUp.is_colliding():
		pass
	elif $RayDown.is_colliding():
		pass
	zero = false
	if velocity == Vector2.ZERO:
		zero = true
	else:
		zero = false
	floor_ray_cast.force_raycast_update()
	var is_on_floor = floor_ray_cast.is_colliding()
	
	if is_on_floor and !was_on_floor and right == 0 and left == 0:
		IdleUpLeft.visible = false
		CHECKDOWN = true
		exclusive = false
		
	if !is_on_floor and was_on_floor and right == 0 and left == 0:
		CHECKUP = false
		IdleUpLeft.visible = false
		RightUpGoLeftAnim.play("RightUPgoLeft")
		RightUpGoLeftSprite.visible = true
		
	elif !is_on_floor and was_on_floor and vertical == 1 and left == 1:
		RightUpGoLeftSprite.visible = false
		StaticLeft.visible = false
		StaticUp.visible = false
		IdleLeftWall.visible = false
		UpGoDownSprite.visible = false
		zabse = false
		spritetest.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		IdleUpLeft.visible = false
		IdleUpRight.visible = false
		StaticDown.visible = false
		IdleRightWall.visible = false
		PlayerFlipRight.visible = false
		LeftUpGoRightSprite.visible = true
		CHECKUP = false
		exclusive = false
		StaticRight.visible = false
		CHECKDOWN = false
		PlayerFlip.visible = false
		player.visible = false
		IdleDownRight.visible = false
		UpGoDownLeftSprite.visible = false
		LeftUpGoRightAnim.play("LeftUPgoRight")
		Left_Ground_In_Left = 1
		Left_Ground_In_Right = 0
		left = 1
		right = 0
	if !is_on_floor and was_on_floor and vertical == 1 and right == 1:
		RightUpGoLeftSprite.visible = true
		UpGoDownSprite.visible = false
		StaticDown.visible = false
		IdleLeftWall.visible = false
		StaticLeft.visible = false
		IdleRightWall.visible = false
		CHECKUP = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		spritetest.visible = false
		IdleUpRight.visible = false
		StaticUp.visible = false
		IdleUpLeft.visible = false
		PlayerFlipRight.visible = false
		StaticRight.visible = false
		exclusive = false
		player.visible = false
		IdleDownRight.visible = false
		
		zabse = false
		PlayerFlip.visible = false
		LeftUpGoRightSprite.visible = false
		CHECKDOWN = false
		UpGoDownLeftSprite.visible = false
		RightUpGoLeftAnim.play("RightUPgoLeft")
		Left_Ground_In_Right = 1
		Left_Ground_In_Left = 0
		right = 1
		left = 0
	
	was_on_floor = is_on_floor
	
	ceiling_ray_cast.force_raycast_update()
	var is_on_ceiling = ceiling_ray_cast.is_colliding()
	
	
	if is_on_ceiling and !was_on_ceiling and right == 0 and left == 0:
		CHECKUP = true
		player.visible = false
		IdleDownRight.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		LeftUpGoRightSprite.visible = false
		exclusive = false
		
	if !is_on_ceiling and was_on_ceiling and right == 0 and left == 0: # if the player recently left the ceiling and didnt move
		CHECKDOWN = false
		player.visible = false
		IdleDownRight.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		UpGoDownSprite.visible = true
		exclusive = false
		UpGoDownAnim.play("FromUPgoDown")
		
	elif !is_on_ceiling and was_on_ceiling and vertical == 1 and left == 1:
		RightUpGoLeftSprite.visible = false
		StaticLeft.visible = false
		StaticRight.visible = false
		StaticUp.visible = false
		IdleLeftWall.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		IdleUpRight.visible = false
		spritetest.visible = false
		zabse = false
		IdleUpLeft.visible = false
		IdleRightWall.visible = false
		CHECKUP = false
		LeftUpGoRightSprite.visible = false
		StaticDown.visible = false
		exclusive = true
		PlayerFlipRight.visible = false
		CHECKDOWN = false
		UpGoDownSprite.visible = false
		player.visible = false
		IdleDownRight.visible = false
		PlayerFlip.visible = false
		UpGoDownLeftSprite.visible = true
		UpGoDownLeftAnim.play("FromUpGoDownLeft")
		left = 1
	if !is_on_ceiling and was_on_ceiling and vertical == 1 and right == 1:
		RightUpGoLeftSprite.visible = false
		LeftUpGoRightSprite.visible = false
		PlayerFlipRight.visible = false
		IdleUpRight.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		IdleUpLeft.visible = false
		StaticLeft.visible = false
		spritetest.visible = false
		StaticUp.visible = false
		exclusive = true
		zabse = false
		IdleLeftWall.visible = false
		IdleRightWall.visible = false
		StaticDown.visible = false
		StaticRight.visible = false
		player.visible = false
		IdleDownRight.visible = false
		UpGoDownSprite.visible = true
		CHECKDOWN = false
		CHECKUP = false
		UpGoDownLeftSprite.visible = false
		PlayerFlip.visible = false
		UpGoDownAnim.play("FromUPgoDown")
		right = 1
	was_on_ceiling = is_on_ceiling
#
	right_ray_cast.force_raycast_update()
	var is_on_right_wall = right_ray_cast.is_colliding()
	if is_on_right_wall and !was_on_right_wall:
		CHECKRIGHT = true
		CHECKUP = false
		CHECKDOWN = false
		StaticDown.visible = false
	elif !is_on_right_wall and was_on_right_wall:
		pass
	if is_on_right_wall and !was_on_right_wall:
		CollideSFX.play()

	was_on_right_wall = is_on_right_wall

	left_ray_cast.force_raycast_update()
	var is_on_left_wall = left_ray_cast.is_colliding()
	if is_on_left_wall and !was_on_left_wall:

		CHECKLEFT = true
		CHECKUP = false
		CHECKDOWN = false
		StaticDown.visible = false
		
	if is_on_left_wall and !was_on_left_wall:
		CollideSFX.play()
		
		
		
	if is_on_ceiling and !was_on_ceiling and !is_on_right_wall and !is_on_left_wall:
		CollideSFX.play()
		
	if is_on_floor and !was_on_floor and !is_on_right_wall and !is_on_left_wall:
		CollideSFX.play()
		
	elif !is_on_left_wall and was_on_left_wall:
		pass
	was_on_left_wall = is_on_left_wall
	
	
	velocity = lerp(velocity, Vector2.ZERO, damping)
	

func _on_DeathTimer_timeout():
	Music.volume_db = -14
	HandleDeath()

##
##
##
##
##
##
###
###
##
##

#
##
#var last_horizontal = 0  # 1 for right, -1 for left, 0 for none
#
#func _input(event) -> void:
#	if event is InputEventScreenTouch:
#		if event.pressed:
#			swipe_started = true
#			swipe_start = event.position
#		elif !event.pressed and swipe_started:
#			var swipe_end = event.position
#			var swipe = swipe_end - swipe_start
#			if swipe.length() > minimum_drag:
#				playsound.play()
#				var angle = atan2(swipe.y, swipe.x)
#				if abs(angle) < PI/4 or abs(angle) > 3*PI/4:
#					# Horizontal movement
#					velocity = Vector2(swipe.x, 0).normalized() * speed
#					if abs(angle) < PI/4:
#						# Moving right
#						last_horizontal = 1
#						# ... (rest of your code)
#					elif abs(angle)  > 3*PI/4:
#						# Moving left
#						last_horizontal = -1
#						# ... (rest of your code)
#				else:
#					# Vertical movement
#					vertical = 1
#					horizontal = 0
#					velocity = Vector2(0, swipe.y).normalized() * speed
#					# ... (rest of your code)
#
#func _on_Area2D2_body_entered(body):
#	if game_started == true and vertical == 1 and last_horizontal == 1:
#		# Moving up after moving right
#		print("Moving up after right")
#		pass
#		# ... (rest of your code)
#	elif game_started == true and vertical == 1 and last_horizontal == -1:
#		# Moving up after moving left
#		print("Moving up after left")
#		pass
#		# ... (rest of your code)






#func _on_Area2D2_body_exited(body):
#	if game_started == true and vertical == 1 and left == 1:
#		RightUpGoLeftSprite.visible = false
#		UpGoDownSprite.visible = false
#		PlayerFlipRight.visible = false
#		LeftUpGoRightSprite.visible = true
#		PlayerFlip.visible = false
#		player.visible = false
#		UpGoDownLeftSprite.visible = false
#		LeftUpGoRightAnim.play("LeftUPgoRight")
#		print("WE GOING UP LEFT")
#		left = 1
#		right = 0
#	if game_started == true and vertical == 1 and right == 1:
#		RightUpGoLeftSprite.visible = true
#		UpGoDownSprite.visible = false
#		PlayerFlipRight.visible = false
#		player.visible = false
#		PlayerFlip.visible = false
#		LeftUpGoRightSprite.visible = false
#		UpGoDownLeftSprite.visible = false
#		RightUpGoLeftAnim.play("RightUPgoLeft")
#		print("WE GOING UP RIGHT")
#		right = 1
#		left = 0


#func _on_Area2D_body_exited(body):
#	if game_started == true and vertical == 1 and right == 1:
#		RightUpGoLeftSprite.visible = false
#		LeftUpGoRightSprite.visible = false
#		PlayerFlipRight.visible = false
#		player.visible = false
#		UpGoDownSprite.visible = true
#		UpGoDownLeftSprite.visible = false
#		PlayerFlip.visible = false
#		UpGoDownAnim.play("FromUPgoDown")
#		print ("WE GOING DOWN RIGHT")
#		right = 0
#	if game_started == true and vertical == 1 and left == 1:
#		RightUpGoLeftSprite.visible = false
#		LeftUpGoRightSprite.visible = false
#		PlayerFlipRight.visible = false
#		UpGoDownSprite.visible = false
#		player.visible = false
#		PlayerFlip.visible = false
#		UpGoDownLeftSprite.visible = true
#		UpGoDownLeftAnim.play("FromUpGoDownLeft")
#		print("WE GOING DOWN LEFT")
#		left = 0


func _on_AnimationPlayer2_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !IdleDownRight.visible and!PlayerFlip.visible and !PlayerFlipRight.visible and !player.visible and !IdleUpLeft.visible and !IdleUpRight.visible and !LeftUpGoRightSprite.visible and !RightUpGoLeftSprite.visible and !UpGoDownSprite.visible and !UpGoDownLeftSprite.visible and !DashLeft.visible:
		IdleRightWall.visible = true
		IdleLeftWall.visible = false
		IdleRightWallAnim.play("IdleR")
		player.visible = false
		IdleDownRight.visible = false
		StaticDownLeft.visible = false
		IdleUpLeft.visible = false
		spritetest.visible = false
		IdleDownLeft.visible = false
		anim2.stop(false)
		DashRight.visible = false
		DashLeft.visible = false



func _on_AnimationPlayer3_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !IdleDownRight.visible and !PlayerFlip.visible and  !IdleUpRight.visible and !PlayerFlipRight.visible and !player.visible and !IdleUpLeft.visible and !LeftUpGoRightSprite.visible and !RightUpGoLeftSprite.visible and !UpGoDownSprite.visible and !UpGoDownLeftSprite.visible and !DashRight.visible:
		IdleRightWall.visible = false
		IdleLeftWall.visible = true
		player.visible = false
		IdleDownRight.visible = false
		IdleUpLeft.visible = false
		IdleLeftWallAnim.play("IdleL")
		anim3.stop(false)
		IdleDownLeft.visible = false
		spritetest.visible = false
		DashRight.visible = false
		StaticDownLeft.visible = false
		DashLeft.visible = false


func _on_AnimationPlayer5_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !IdleDownRight.visible and !PlayerFlip.visible and !IdleUpRight.visible and !PlayerFlipRight.visible and !player.visible and !LeftUpGoRightSprite.visible and !UpGoDownSprite.visible and !UpGoDownLeftSprite.visible:
		IdleRightWall.visible = false
		IdleLeftWall.visible = false
		DashRight.visible = false
		DashLeft.visible = false
		StaticDownLeft.visible = false
		player.visible = false
		IdleDownRight.visible = false
		spritetest.visible = false
		IdleDownLeft.visible = false
		IdleUpLeft.visible = true
		RightUpGoLeftSprite.visible = false
		IdleUpRight.visible = false


func _on_AnimationPlayer6_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !IdleDownRight.visible and!PlayerFlip.visible and !IdleUpLeft.visible and !PlayerFlipRight.visible and !player.visible and !RightUpGoLeftSprite.visible and !UpGoDownSprite.visible and !UpGoDownLeftSprite.visible:
		IdleRightWall.visible = false
		IdleLeftWall.visible = false
		IdleUpLeft.visible = false
		DashRight.visible = false
		spritetest.visible = false
		DashLeft.visible = false
		IdleUpRight.visible = true
		player.visible = false
		IdleDownLeft.visible = false
		StaticDownLeft.visible = false
		IdleDownRight.visible = false
		LeftUpGoRightSprite.visible = false
		





func _on_AnimationPlayer7_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !PlayerFlip.visible and !PlayerFlipRight.visible and !player.visible and !RightUpGoLeftSprite.visible and !UpGoDownLeftSprite.visible:
		IdleRightWall.visible = false
		IdleLeftWall.visible = false
		IdleUpLeft.visible = false
		DashRight.visible = false
		spritetest.visible = false
		DashLeft.visible = false
		IdleUpRight.visible = false
		player.visible = false
		UpGoDownSprite.visible = false
		StaticDownLeft.visible = false
		IdleDownLeft.visible = false
		IdleDownRight.visible = true
		IdleDownRightAnim.play("IdleDownR")
		
		
		


func _on_AnimationPlayer8_animation_finished(_anim_name):
	if velocity == Vector2.ZERO and !PlayerFlip.visible and !PlayerFlipRight.visible and !player.visible and !RightUpGoLeftSprite.visible and !UpGoDownSprite.visible:
		IdleRightWall.visible = false
		IdleLeftWall.visible = false
		IdleUpLeft.visible = false
		DashRight.visible = false
		spritetest.visible = false
		DashLeft.visible = false
		StaticDownLeft.visible = false
		IdleUpRight.visible = false
		player.visible = false
		UpGoDownLeftSprite.visible = false
		UpGoDownSprite.visible = false
		IdleDownRight.visible = false
		IdleDownLeft.visible = true
		IdleDownLeftAnim.play("IdleDownL")



func flash():
	if game_started:
		if Notify_played == 0:
			$Notify.play()
			Notify_played = 1
		Global.can_Be_Deployed = true
		still_area = true
		Global.is_flashing = true
		for i in range(20):  # Flash 10 times
			if Global.is_flashing:
				$Tween.interpolate_property(self, "modulate",
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 1),
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 0),
					flash_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, i * flash_duration * 2)
				$Tween.interpolate_property(self, "modulate",
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 0),
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 1),
					flash_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, flash_duration + i * flash_duration * 2)
		$Tween.start()
		

func flash2():
	if game_started:
		if Notify_played == 0:
			$Notify.play()
			Notify_played = 1
		Global.can_Be_Deployed = true
		still_area = true
		Global.is_flashing = true
		for i in range(20):  # Flash 10 times
			if Global.is_flashing:
				$Tween.interpolate_property(self, "modulate",
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 1),
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 0),
					flash_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, i * flash_duration * 2)
				$Tween.interpolate_property(self, "modulate",
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 0),
					Color(self.modulate.r, self.modulate.g, self.modulate.b, 1),
					flash_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, flash_duration + i * flash_duration * 2)
		$Tween.start()

func _on_Area2D_body_entered(_body):
	flash()
	Global.tile_dissapear = false
	Global.entered_trigger_ghost_out = true

func _on_Area2D_body_exited(_body):
	Global.can_Be_Deployed = false
	Global.entered_trigger_ghost_out = false
	$Tween.stop(self)
	self.modulate = Color(self.modulate.r, self.modulate.g, self.modulate.b, 1)
	Global.is_flashing = false
	still_area = false

func drawback():
	if game_started:
		set_deferred("monitorable", true)
#		yield(get_tree().create_timer(0.8), "timeout")
		if Global.Ended == true and ghostout_entered and !EXITED:
			Global.on_player_stayed = true

	

func _on_PlayerS_body_entered(_body):
	if game_started:
		drawback()
		ghostout_entered = true
		var tutorialHandUp = get_node("/root/Node2D/Camera2D/HandUp")
		var hand_move_right2 = get_node("/root/Node2D/Camera2D/TutorialHand2")
		var hand_move_right_anim2 = get_node("/root/Node2D/Camera2D/TutorialHand2/AnimationPlayer")
		hand_move_right2.visible = true
		Tilemap_Tween.interpolate_property(Tilemap, "modulate",
			Tilemap.modulate,
			Color(1,1,1,1),
			1, Tween.TRANS_QUAD, Tween.EASE_OUT)
		Tilemap_Tween.start()
		Enemies.visible = true
		Enemies.modulate = Color(1,1,1,1)
		Coins.visible = true
		Coins.modulate = Color(1.35,0.9,0.87,0.7)
		GlitchEffect.visible = true
		GlitchEffect.modulate = Color(1,1,1,0.73)
		hand_move_right_anim2.play("hand")
		tutorialHandUp.visible = false
		Global.tile_dissapear = false
		EXITED = false
		#________________________
		#Here belongs the code that executes when you stay on the block or simply don´t touch it at all
		#!WARNING! dont forget to add the Global.on_player_stayed = true variable
		# or just maybe dont forget to paste the code from DoubleTap.gd
		#AND THE PASTED Code here SHOULD STILL STAY IN DOUBLETAP.gd because it still 
		#needs to revert the colors even though the player hasnt moved on the block


func _on_PlayerS_body_exited(_body):
	var tutorialHandUp = get_node("/root/Node2D/Camera2D/HandUp")
	print("exit")
	EXITED = true
	Monitr.set_deferred("monitoring", false)
	var hand_move_right2 = get_node("/root/Node2D/Camera2D/TutorialHand2")
	hand_move_right2.visible = false
	Global.Ended = true ## SET IT TO FALSE tommorow 10.3.24 is today
	Global.tile_dissapear = false #Disables tile disappearing when the player lefts the 
	#ghost out area so that it doesnt flip the player back down while he just entered the 
	#area after exiting the tile dissapear area
	
	##After the timer hits 0 the end phase starts
	
	Global.Exited_PlayerS = 1
	
	color_tween.interpolate_property(canvas_modulate, "color",
		Color(0.8, 1, 1.5, 0.6), original_color, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	color_tween.start()

	# Start the fade out and scale out using Tween for the Special sprite
	
	CamTween.interpolate_property(Cam, "zoom",
		Cam.zoom,  # Start from current zoom
		Vector2(1.61, 1.61),  # Zoom out
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	CamTween.start()
	
	tutorialHandUp.visible = false
	Global.Ended = true
	
	Anomalies_Tween.interpolate_property(Anomalies, "modulate",
		Color(1,1,1,1),
		Color(1,1,1,0),
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	Anomalies_Tween.start()
	
	yield(get_tree().create_timer(0.5), "timeout")
	Anomalies.visible = false
	
	special_tween.interpolate_property(special, "modulate",
		Color(2,2,4, 1),  # Start from opaque
		Color(2,2,4, 0),  # Fade to transparents
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	special_tween.start()
	
	GhostOutTile_tween.interpolate_property(GhostOutTile, "modulate",
		Color(5, 0.5, 2, 0.05),
		Color(1,0.37,0.5, 0.7),
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	GhostOutTile_tween.start()
	
	GhostOutTile_Cshape.disabled = false
	# After the fade out, set Special to not visible
	yield(special_tween, "tween_all_completed")  # Wait for all tweens to complete
	
	special.visible = false
	Collision.disabled = true
	Global.is_flashing = true
	Global.loop_Stop = true
	Global.lock = 0
	Music.volume_db = -14
	Global.anomaly_notif = 1
	Global.can_be_paused = true
	Global.Exited_PlayerS = 0
	#________________________________
	#Here belongs the code that executes when you exited the area of the block, so disabling the colors etc
	
	#AND THE PASTED Code here SHOULD STILL STAY IN DOUBLETAP.gd because it still 
	#needs to revert the colors even though the player hasnt moved on the block
	#_________________________________
	
	

func _on_LightningArea_body_entered(_body):
	if game_started and Global.health > 0:
		Music.volume_db = -30
		Global.General_SpecialDeath = true
		CamTween.interpolate_property(Cam, "zoom",
				Cam.zoom,  # Start from current zoom
				Vector2(1.3, 1.3),  # Zoom in
				0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		
		Lightning.hframes = 700
		LightningAnim.stop()
		LightningKillMove.visible = true
		LightningKillMoveAnim.play("LightningKill")
		LightningArea.set_deferred("monitoring", false)
		
		var LightningKillTimer = Timer.new()  # Create a new Timer node
		LightningKillTimer.wait_time = 0.7 # Set the timer to wait for 3 seconds
		LightningKillTimer.one_shot = true  # Set the timer to only trigger once
		LightningKillTimer.connect("timeout", self, "_on_LightningKillTimer_timeout")  # Connect the timer's timeout signal to a function
		add_child(LightningKillTimer)  # Add the timer as a child of the current node
		
		LightningKillTimer.start()
	if game_started and Global.PlayerMovingRight:
		LightningKillMoveSprite.flip_h = true
	elif game_started and Global.PlayerMovingLeft:
		LightningKillMoveSprite.flip_h = false
	else:
		pass

func _on_LightningKillTimer_timeout():
	Music.volume_db = -14
	Lightning.hframes = 8
	LightningKillMove.visible = false
	LightningKillMoveAnim.stop()
	LightningAnim.play("Lightning")
	HandleDeath()


func _on_TutorialMovedRight_body_entered(_body):
	if game_started:
		
		var _hand_move_right_anim = get_node("/root/Node2D/Camera2D/TutorialHand/AnimationPlayer")
		var hand_move_right = get_node("/root/Node2D/Camera2D/TutorialHand")
		var hand_move_right_tween = get_node("/root/Node2D/Camera2D/TutorialHand/Tween")
		
		hand_doubleTap_tween.interpolate_property(hand_doubleTap, "modulate",
			hand_doubleTap.modulate,
			Color(0.5,0.6,0.6,0),
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_doubleTap_tween.start()
		
		var TutorialTimer1 = Timer.new()
		add_child(TutorialTimer1)
		TutorialTimer1.wait_time = 0.5
		TutorialTimer1.one_shot = true
		TutorialTimer1.connect("timeout", self, "_on_TutorialTimer1_timeout", [hand_move_right_tween, hand_move_right])
		TutorialTimer1.start()
		
func _on_TutorialTimer1_timeout(hand_move_right_tween, hand_move_right):
	hand_doubleTap.visible = false
	
	hand_move_right_tween.interpolate_property(hand_move_right, "modulate",
		hand_move_right.modulate,
		Color(1,1,1,0),
		0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hand_move_right_tween.start()
	
	var TutorialTimer2 = Timer.new()
	add_child(TutorialTimer2)
	TutorialTimer2.wait_time = 0.01
	TutorialTimer2.one_shot = true
	TutorialTimer2.connect("timeout", self, "_on_TutorialTimer2_timeout", [hand_move_right])
	TutorialTimer2.start()

func _on_TutorialTimer2_timeout(hand_move_right):
	var hand_move_right_anim = get_node("/root/Node2D/Camera2D/TutorialHand/AnimationPlayer")
	hand_move_right_anim.stop()
	hand_move_right.visible = false
	
	var TutorialTimer3 = Timer.new()
	add_child(TutorialTimer3)
	TutorialTimer3.wait_time = 0.05
	TutorialTimer3.one_shot = true
	TutorialTimer3.connect("timeout", self, "_on_TutorialTimer3_timeout")
	TutorialTimer3.start()

func _on_TutorialTimer3_timeout():
	var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
	var hand_move_down_tween = get_node("/root/Node2D/Camera2D/HandDown/Tween")
	var hand_move_down_anim = get_node("/root/Node2D/Camera2D/HandDown/AnimationPlayer")
	
	hand_move_down.visible = true
	hand_move_down_tween.interpolate_property(hand_move_down, "modulate",
		Color(0.5,0.6,0.6,0),
		Color(0.5,0.6,0.6,1),
		0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hand_move_down_tween.start()
	
	var TutorialTimer4 = Timer.new()
	add_child(TutorialTimer4)
	TutorialTimer4.wait_time = 0.5
	TutorialTimer4.one_shot = true
	TutorialTimer4.connect("timeout", self, "_on_TutorialTimer4_timeout", [hand_move_down_anim])
	TutorialTimer4.start()

func _on_TutorialTimer4_timeout(hand_move_down_anim):
	hand_move_down_anim.play("handDown")
	
	var TutorialTimer5 = Timer.new()
	add_child(TutorialTimer5)
	TutorialTimer5.wait_time = 5.9
	TutorialTimer5.one_shot = true
	TutorialTimer5.connect("timeout", self, "_on_TutorialTimer5_timeout")
	TutorialTimer5.start()

func _on_TutorialTimer5_timeout():
	var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
	var hand_move_down_tween = get_node("/root/Node2D/Camera2D/HandDown/Tween")
	
	hand_move_down_tween.interpolate_property(hand_move_down, "modulate",
		hand_move_down.modulate,
		Color(0.5,0.6,0.6,0),
		0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hand_move_down_tween.start()
	
	var TutorialTimer6 = Timer.new()
	add_child(TutorialTimer6)
	TutorialTimer6.wait_time = 0.2
	TutorialTimer6.one_shot = true
	TutorialTimer6.connect("timeout", self, "_on_TutorialTimer6_timeout")
	TutorialTimer6.start()

func _on_TutorialTimer6_timeout():
	var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
	var hand_move_down_anim = get_node("/root/Node2D/Camera2D/HandDown/AnimationPlayer")
	hand_move_down.visible = false
	hand_move_down_anim.stop()



func _on_TutorialMoveDown_body_entered(_body):
	if game_started:
		var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
		var hand_move_down_tween = get_node("/root/Node2D/Camera2D/HandDown/Tween")
		var hand_move_down_anim = get_node("/root/Node2D/Camera2D/HandDown/AnimationPlayer")
		hand_move_down_tween.interpolate_property(hand_move_down, "modulate",
			hand_move_down.modulate,
			Color(0.5,0.6,0.6,0),
			0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_move_down_tween.start()
		yield(get_tree().create_timer(0.1), "timeout")
		hand_move_down.visible = false
		hand_move_down_anim.stop()
		hand_doubleTap.visible = true
		hand_doubleTap_tween.interpolate_property(hand_doubleTap, "modulate",
			Color(0.5,0.6,0.6,0),
			Color(0.5,0.6,0.6,1),
			2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_doubleTap_tween.start()


func _on_TutorialMoveRight2_body_entered(_body):
	if game_started:
		print("enter")
		var hand_move_down = get_node("/root/Node2D/Camera2D/HandDown")
		var hand_move_down_tween = get_node("/root/Node2D/Camera2D/HandDown/Tween")
		var hand_move_down_anim = get_node("/root/Node2D/Camera2D/HandDown/AnimationPlayer")
		var hand_move_right_anim = get_node("/root/Node2D/Camera2D/TutorialHand/AnimationPlayer")
		hand_move_down_tween.interpolate_property(hand_move_down, "modulate",
			hand_move_down.modulate,
			Color(0.5,0.6,0.6,0),
			0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_move_down_tween.start()
		yield(get_tree().create_timer(0.05), "timeout")
		hand_move_down.visible = false
		hand_move_down_anim.stop()
		var hand_move_right = get_node("/root/Node2D/Camera2D/TutorialHand")
		var hand_move_right_tween = get_node("/root/Node2D/Camera2D/TutorialHand/Tween")
		hand_move_right.visible = true
		hand_move_right_tween.interpolate_property(hand_move_right, "modulate",
			Color(0.5,0.6,0.6,0),
			Color(0.5,0.6,0.6,1),
			0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_move_right_tween.start()
		hand_move_right_anim.play("hand")
		yield(get_tree().create_timer(5.9), "timeout")
		hand_move_right_tween.interpolate_property(hand_move_right, "modulate",
			Color(0.5,0.6,0.6,1),
			Color(0.5,0.6,0.6,0),
			0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		hand_move_right_tween.start()
		yield(get_tree().create_timer(0.2), "timeout")
		hand_move_right.visible = false
		hand_move_right_anim.stop()


func _on_Area2D2_body_entered(_body):
	if game_started:
		Global.tile_dissapear = true
		Global.entered_trigger_ghost_tile = true
		flash2()


func _on_Area2D2_body_exited(_body):
	Global.can_Be_Deployed = false
	Global.entered_trigger_ghost_tile = false
	$Tween.stop(self)
	self.modulate = Color(self.modulate.r, self.modulate.g, self.modulate.b, 1)
	Global.is_flashing = false
	still_area = false


func _on_GoBackToMenu_body_entered(_body):
	if game_started:
		
		var TurnOffPause = get_node("/root/Node2D/CanvasLayer/Pause")
		self.visible = false
		Global.can_be_paused = false
		Global.can_touch = false
		TurnOffPause.visible = false
		var sound_on_win = get_node("/root/Node2D/MusicAndVFX/Win")
		sound_on_win.play()
		Music.volume_db = -30
		Lantern.visible = true
		CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(1, 1),  # Zoom in
			0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		yield(get_tree().create_timer(0.2), "timeout")
		CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(1.61, 1.61),  # Zoom out
			0.8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		LanternAnims.play("GoodWin")
		LanternArea.set_deferred("monitoring", false)
		WinMusic.play()
		yield(CamTween, "tween_all_completed")  # Wait for all tweens to complete
		
		var WinTimer = Timer.new()  # Create a new Timer node
		WinTimer.wait_time = 1 # Set the timer to wait for 3 seconds
		WinTimer.one_shot = true  # Set the timer to only trigger once
		add_child(WinTimer)  # Add the timer as a child of the current node
		WinTimer.connect("timeout", self, "_on_LanternTimer_timeout")  # Connect the timer's timeout signal to a function
		WinTimer.start()  # Start the timer

func _on_LanternTimer_timeout():
#	Music.stop()
	
	Global.win_level_souls()
	Global.win_level()
	
	var won = get_node("/root/Node2D/Camera2D/PlayerExplosion")
	won.emitting = true
	yield(get_tree().create_timer(1.6), "timeout")
	Global.change_world_modulate(Color(0.7, 0.64, 1, 0.35))
# warning-ignore:unused_variable
	var TurnOffPause = get_node("/root/Node2D/CanvasLayer/Pause")
#		TurnOffPause.visible = false ## Turn off pause menu visibility when level passed
	var Finish = get_node("/root/Node2D/CanvasLayer2/passed/Sprite")
	var Finish_IN = get_node("/root/Node2D/CanvasLayer2/passed")
	var Finish_tween = get_node("/root/Node2D/CanvasLayer2/passed/Sprite/Tween")
	Finish_IN.visible = true
	Finish_tween.interpolate_property(Finish, "modulate",
		Color(1,0.9,1,0),
		Color(1,0.9,1,0.85),
		0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	Finish_tween.start()
	Finish.visible = true
	Global.can_be_paused = false
	Global.can_touch = false
	TurnOffPause.visible = false
	yield(get_tree().create_timer(0.3), "timeout")

#Glitch Effect Body entered
func _on_PlayerAura_body_entered(_body):
	if game_started:
		GlitchTheTiles.z_index = 900


func _on_PlayerAura_body_exited(_body):
	if game_started:
		GlitchTheTiles.z_index = 4096

func _on_TutorialMoveDown_body_exited(_body):
	if game_started:
		hand_down.visible = false
		var tween = Tween.new() # Create a new Tween instance
		hand_doubleTap.add_child(tween)
		tween.interpolate_property(hand_doubleTap, "modulate",
			Color(0.5,0.6,0.6,1),
			Color(0.5,0.6,0.6,0),
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.call_deferred("start") # Use call_deferred to delay the start

		# Create a Timer node programmatically
# warning-ignore:return_value_discarded
		$Timer2.call_deferred("start") ## USING call_deffered because using .start() makes problems
		#also using timer because yield(get_tree().create_timer(1), "timeout") creates problems
		#only on this particular node

# This function will be called when the timer times out


func _on_Button_button_up():
	pass
# warning-ignore:return_value_discarded
#	get_tree().change_scene("res://Menu.tscn")

func _on_Timer2_timeout():
	hand_doubleTap.visible = false


## Detection for guardian if the player has entered his area, this is the safe area

func _on_GuardianDetectionSafe_body_entered(_body):
	pass

## Detection for guardian if the player has entered his area, this is the danger area
func _on_GuardianDetectionDanger_body_entered(_body):
	if game_started and Global.health > 0:
		
		if !Global.guardian_activated:
			var Guardian = get_node("/root/Node2D/Enemies/GuardianBody")
			Guardian.set_collision_layer_bit(2, false)
			Guardian.set_collision_mask_bit(2, false)
			var SlowMoTimer = Timer.new()  # Create a new Timer node
			SlowMoTimer.wait_time = 0.1  # Set the timer to wait for 3 seconds
			var GuardianBodyAnim = get_node("/root/Node2D/Enemies/GuardianBody/Guardian/GuardianBodyAnim")
			var GuardianShieldAnim = get_node("/root/Node2D/Enemies/GuardianBody/Guardian/GuardianShield/GuardianShieldAnim")
			SlowMoTimer.one_shot = true  # Set the timer to only trigger once
			SlowMoTimer.connect("timeout", self, "_on_SlowMoTimer_timeout")  # Connect the timer's timeout signal to a function
			add_child(SlowMoTimer)  # Add the timer as a child of the current node
			Engine.time_scale = 0.1
			GuardianBodyAnim.play("guardianBody")
			GuardianBodyAnim.playback_speed = 4.3
			GuardianShieldAnim.play("GuardianShield")
			GuardianShieldAnim.playback_speed = 4.3
			var DangerFx = get_node("/root/Node2D/MusicAndVFX/DangerFx")
			var DangerFx2 = get_node("/root/Node2D/MusicAndVFX/DangerFx2")
			DangerFx2.play()
			DangerFx.play()
			Music.volume_db = -40
			CamTween.interpolate_property(Cam, "zoom",
				Cam.zoom,  # Start from current zoom
				Vector2(0.7, 0.7),  # Zoom in
				0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			CamTween.start()
			emit_signal("player_detected", true)
			SlowMoTimer.start()
		else:
			Global.SpecialDeath = true
			Music.volume_db = -30
			CamTween.interpolate_property(Cam, "offset",
				Cam.offset,  # Start from current zoom
				Vector2(-100, 0),  # Zoom in
				0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			CamTween.start()
			CamTween.interpolate_property(Cam, "zoom",
				Cam.zoom,  # Start from current zoom
				Vector2(1.4, 1.4),  # Zoom in
				0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			CamTween.start()
			var timerDeathTrigger = Timer.new()  # Create a new Timer node
			timerDeathTrigger.wait_time = 1.35  # Set the timer to wait for 3 seconds
			timerDeathTrigger.one_shot = true  # Set the timer to only trigger once
			timerDeathTrigger.connect("timeout", self, "_on_DeathTimer_timeout")  # Connect the timer's timeout signal to a function
			add_child(timerDeathTrigger)  # Add the timer as a child of the current node
			
			timerDeathTrigger.start()  # Start the timer
			
		if Global.health == 0:
			var GuardianMonitor = get_node("/root/Node2D/Enemies/GuardianBody/Guardian/GuardianDetectionDanger")
			GuardianMonitor.set_deferred("monitoring", false)

func _on_SlowMoTimer_timeout():
	var Guardian = get_node("/root/Node2D/Enemies/GuardianBody")
	Guardian.set_collision_layer_bit(2, true)
	Guardian.set_collision_mask_bit(2, true)
	Engine.time_scale = 1
	var GuardianBodyAnim = get_node("/root/Node2D/Enemies/GuardianBody/Guardian/GuardianBodyAnim")
	GuardianBodyAnim.playback_speed = 1
	var GuardianShieldAnim = get_node("/root/Node2D/Enemies/GuardianBody/Guardian/GuardianShield/GuardianShieldAnim")
	GuardianShieldAnim.playback_speed = 1
	CamTween.interpolate_property(Cam, "zoom",
			Cam.zoom,  # Start from current zoom
			Vector2(1.61, 1.61),  # Zoom out
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	CamTween.start()
	Global.guardian_activated = true
	Music.volume_db = -40
	yield(get_tree().create_timer(0.5), "timeout")
	Music.volume_db = -35
	yield(get_tree().create_timer(0.5), "timeout")
	Music.volume_db = -30
	yield(get_tree().create_timer(0.5), "timeout")
	Music.volume_db = -25
	yield(get_tree().create_timer(0.5), "timeout")
	Music.volume_db = -20
	yield(get_tree().create_timer(0.5), "timeout")
	Music.volume_db = -14
#	emit_signal("player_detected", false)



func _on_TrapArea_body_entered(_body):
	if game_started and Global.health > 0:
		Music.volume_db = -30
		Global.General_SpecialDeath = true
		CamTween.interpolate_property(Cam, "zoom",
				Cam.zoom,  # Start from current zoom
				Vector2(1.3, 1.3),  # Zoom in
				0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		CamTween.start()
		TrapKillMove.visible = true
		Trap.hframes = 1
		TrapsAnims.stop()
		TrapArea.set_deferred("monitoring", false)
		TrapKillMoveAnim.play("KillMoveEat")
		var TrapKillTimer = Timer.new()  # Create a new Timer node
		TrapKillTimer.wait_time = 2.7 # Set the timer to wait for 3 seconds
		TrapKillTimer.one_shot = true  # Set the timer to only trigger once
		TrapKillTimer.connect("timeout", self, "_on_TrapKillTimer_timeout")  # Connect the timer's timeout signal to a function
		add_child(TrapKillTimer)  # Add the timer as a child of the current node
		
		TrapKillTimer.start()  # Start the timer
	if game_started and Global.PlayerMovingRight:
		TrapKillMoveSprite.flip_h = true
	elif game_started and Global.PlayerMovingLeft:
		TrapKillMoveSprite.flip_h = false
	else:
		pass
	

func _on_TrapKillTimer_timeout():
	Music.volume_db = -14
	HandleDeath()

