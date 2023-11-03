extends Node

const _windowedModeRatio : float = 0.75;
const _maximumAspectRatio : float = 16.0 / 9.0;  # 16 : 9
const _minimumAspectRatio : float =  4.0 / 3.0;  #  4 : 3

var _inFullScreen : bool = false;

func _ready() -> void:
  _inFullScreen = true;
  switchMode();

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("ui_toogle_fullscreen"):
    switchMode();

func switchMode() -> void:
  _inFullScreen = !_inFullScreen;
  OS.window_borderless = _inFullScreen;
  OS.window_maximized = _inFullScreen;
  OS.window_size = _calculateWindowSize(_inFullScreen, OS.get_screen_size(OS.current_screen));
  OS.center_window();

func _calculateWindowSize(fullScreen : bool, screenSize : Vector2) -> Vector2:
  var widthHeight = screenSize;
  if (!fullScreen):
    widthHeight *= _windowedModeRatio;
    if (widthHeight.aspect() > _maximumAspectRatio):
      widthHeight.x = widthHeight.y * _maximumAspectRatio;
    if (widthHeight.aspect() < _minimumAspectRatio):
      widthHeight.y = widthHeight.x / _minimumAspectRatio;
    widthHeight.x = int(widthHeight.x) & ~1;
    widthHeight.y = int(widthHeight.y) & ~1;

  return widthHeight;
