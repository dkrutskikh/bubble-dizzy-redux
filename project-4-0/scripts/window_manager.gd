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

  var window := get_window();
  var screenSize := DisplayServer.screen_get_size(window.current_screen);
  window.mode = Window.MODE_FULLSCREEN if _inFullScreen else Window.MODE_WINDOWED;
  window.size = _calculateWindowSize(_inFullScreen, screenSize);
  window.position = DisplayServer.screen_get_position(window.current_screen) + _calculateWindowPosition(_inFullScreen, screenSize);

func _calculateWindowPosition(fullScreen : bool, screenSize : Vector2i) -> Vector2i:
  return (screenSize - _calculateWindowSize(fullScreen, screenSize)) / 2;

func _calculateWindowSize(fullScreen : bool, screenSize : Vector2i) -> Vector2i:
  var widthHeight := screenSize;

  if (!fullScreen):
    widthHeight *= _windowedModeRatio;
    if (widthHeight.aspect() > _maximumAspectRatio):
      widthHeight.x = int(widthHeight.y * _maximumAspectRatio);
    if (widthHeight.aspect() < _minimumAspectRatio):
      widthHeight.y = int(widthHeight.x / _minimumAspectRatio);
    widthHeight.x = int(widthHeight.x) & ~1;
    widthHeight.y = int(widthHeight.y) & ~1;

  return widthHeight;
