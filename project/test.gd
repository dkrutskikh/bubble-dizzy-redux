extends Node

func _ready():
  var levelCamera := _createCamera();
  add_child(levelCamera);
  levelCamera.set_owner(self);

  var tapDataExtractor := TapDataExtractor.new("res://original-games/BubbleDizzy(Spectrum).tap");

  var imageTexture := ImageTexture.create_from_image(tapDataExtractor.loadingImage());

  var levelBackground := Sprite3D.new();

  levelBackground.set_name('background');
  levelBackground.set_scale(Vector3(6.0, 6.0, 1.0));
  levelBackground.set_position(Vector3(0.0, 0.0, 0.0));
  levelBackground.set_texture(imageTexture);

  add_child(levelBackground);
  levelBackground.set_owner(self);

#	instantiatingFromTemplate();

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_viewport_size_changed():
  print ("Viewport size changed");

#func instantiatingFromTemplate():
#	var levelSun = DirectionalLight.new();
#	levelSun.set_shadow_mode(DirectionalLight.SHADOW_ORTHOGONAL);
#	levelSun.set_name('sun');
#	levelSun.look_at_from_position(Vector3(-17.004, 29.084, -23.451), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0));
#	add_child(levelSun);
#	levelSun.set_owner(self);
#
#	var levelTerrain = Terrain.new();
#	levelTerrain.set_name('terrain');
#	add_child(levelTerrain);
#	levelTerrain.set_owner(self);

func _createCamera() -> Camera3D:
  var levelCamera := Camera3D.new();

  levelCamera.set_name('camera');
  levelCamera.set_position(Vector3(0.0, 0.0, 9.0));
  levelCamera.look_at_from_position(Vector3(0.0, 0.0, 9.0), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0));
  levelCamera.set_orthogonal(12.0, 1.0, 100.0);
  levelCamera.set_keep_aspect_mode(Camera3D.KEEP_HEIGHT);

  return levelCamera;
