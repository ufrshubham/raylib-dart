import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'module.dart';

import '../constants/camera.dart';
import '../constants/gestures.dart';
import '../constants/key_codes.dart';
import '../constants/mouse_cursor.dart';
import '../constants/config_flags.dart';
import '../modules/generated_bindings.dart' as raylib_bind;

part 'raylib_colors.dart';

part '../maps/camera.dart';
part '../maps/gestures.dart';
part '../maps/key_bindings.dart';
part '../maps/mouse_cursors.dart';

class Core extends RaylibModule {
  // Constructs the core module.
  Core(raylib_bind.DartRaylib raylib) : super(raylib) {
    colors = _RaylibColor(raylib);
  }

  // Use this to access the OOTB colors from raylib.
  /// To create custom colors using [createColor].
  late final _RaylibColor colors;

  // A pointer to dynamically allocated window title (c-string).
  ffi.Pointer<Utf8> _windowTitle = ffi.nullptr;

  // A pointer to dynamically allocated clipboard content (c-string).
  ffi.Pointer<Utf8> _clipboardContent = ffi.nullptr;

  // Constants for native boolean values.
  static const _true = raylib_bind.bool.true_1;

  // Might need this in future.
  // ignore: unused_field
  static const _false = raylib_bind.bool.false_1;

  // Converts given strings to native utf-8 strings
  // and exposes it as a int8 pointer.
  ffi.Pointer<Utf8> _toUtf8(String string) {
    return string.toNativeUtf8();
  }

  // **************** Window related APIs. ****************

  // Initialize window and OpenGL context
  void initWindow(int width, int height, String title) {
    malloc.free(_windowTitle);
    _windowTitle = _toUtf8(title);
    raylib.InitWindow(width, height, _windowTitle.cast<ffi.Int8>());
  }

  // Check if KEY_ESCAPE pressed or Close icon pressed
  bool get shouldWindowClose => (raylib.WindowShouldClose() == _true);

  // Close window and unload OpenGL context
  void closeWindow() {
    malloc.free(_windowTitle);
    raylib.CloseWindow();
  }

  // Check if window has been initialized successfully
  bool get isWindowReady => (raylib.IsWindowReady() == _true);

  // Check if window is currently fullscreen
  bool get isWindowFullScreen => (raylib.IsWindowFullscreen() == _true);

  // Check if window is currently hidden (only PLATFORM_DESKTOP)
  bool get isWindowHidden => (raylib.IsWindowHidden() == _true);

  // Check if window is currently minimized (only PLATFORM_DESKTOP)
  bool get isWindowMinimized => (raylib.IsWindowMinimized() == _true);

  // Check if window is currently maximized (only PLATFORM_DESKTOP)
  bool get isWindowMaximized => (raylib.IsWindowMaximized() == _true);

  // Check if window is currently focused (only PLATFORM_DESKTOP)
  bool get isWindowFocused => (raylib.IsWindowFocused() == _true);

  // Check if window has been resized last frame
  bool get isWindowResized => (raylib.IsWindowResized() == _true);

  // Check if one specific window flag is enabled
  bool isWindowState(WindowConfigFlag flag) {
    var isSet = false;
    if (_configFlags[flag] != null) {
      isSet = (raylib.IsWindowState(_configFlags[flag]!) == _true);
    } else {
      throw ArgumentError.value(
          flag, 'flag', 'Does not map to any native window config flag.');
    }
    return isSet;
  }

  // Set window configuration state using flags
  void setWindowState(List<WindowConfigFlag> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_configFlags[flag] != null) {
        bitMaskedFlag |= _configFlags[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native window config flag.');
      }
    }
    raylib.SetWindowState(bitMaskedFlag);
  }

  // Clear window configuration state flags
  void clearWindowState(List<WindowConfigFlag> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_configFlags[flag] != null) {
        bitMaskedFlag |= _configFlags[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native window config flag.');
      }
    }
    raylib.ClearWindowState(bitMaskedFlag);
  }

  // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
  void toggleFullscreen() {
    raylib.ToggleFullscreen();
  }

  // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
  void maximizeWindow() {
    raylib.MaximizeWindow();
  }

  // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
  void minimizeWindow() {
    raylib.MinimizeWindow();
  }

  // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
  void restoreWindow() {
    raylib.RestoreWindow();
  }

  // Set icon for window (only PLATFORM_DESKTOP)
  void setWindowIcon(raylib_bind.Image image) {
    raylib.SetWindowIcon(image);
  }

  // Set title for window (only PLATFORM_DESKTOP)
  set windowTitle(String title) {
    malloc.free(_windowTitle);
    _windowTitle = _toUtf8(title);
    raylib.SetWindowTitle(_windowTitle.cast<ffi.Int8>());
  }

  // Set window position on screen (only PLATFORM_DESKTOP)
  void setWindowPosition(int x, int y) {
    raylib.SetWindowPosition(x, y);
  }

  // Set monitor for the current window (fullscreen mode)
  set windowMonitor(int monitor) => raylib.SetWindowMonitor(monitor);

  // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  void setWindowMinSize(int width, int height) {
    raylib.SetWindowMinSize(width, height);
  }

  // Set window dimensions
  void setWindowSize(int width, int height) {
    raylib.SetWindowMinSize(width, height);
  }

  // Get native window handle
  ffi.Pointer<ffi.Void> get windowHandle => raylib.GetWindowHandle();

  // Get current screen width
  int get screenWidth => raylib.GetScreenWidth();

  // Get current screen height
  int get screenHeight => raylib.GetScreenHeight();

  // Get number of connected monitors
  int get monitorCount => raylib.GetMonitorCount();

  // Get current connected monitor
  int get currentMonitor => raylib.GetCurrentMonitor();

  // Get specified monitor position
  raylib_bind.Vector2 getMonitorPosition(int monitor) {
    return raylib.GetMonitorPosition(monitor);
  }

  // Get specified monitor width (max available by monitor)
  int getMonitorWidth(int monitor) {
    return raylib.GetMonitorWidth(monitor);
  }

  // Get specified monitor height (max available by monitor)
  int getMonitorHeight(int monitor) {
    return raylib.GetMonitorHeight(monitor);
  }

  // Get specified monitor physical width in millimetres
  int getMonitorPhysicalWidth(int monitor) {
    return raylib.GetMonitorPhysicalWidth(monitor);
  }

  // Get specified monitor physical height in millimetres
  int getMonitorPhysicalHeight(int monitor) {
    return raylib.GetMonitorPhysicalHeight(monitor);
  }

  // Get specified monitor refresh rate
  int getMonitorRefreshRate(int monitor) {
    return raylib.GetMonitorRefreshRate(monitor);
  }

  // Get window position XY on monitor
  raylib_bind.Vector2 get windowPosition => raylib.GetWindowPosition();

  // Get window scale DPI factor
  raylib_bind.Vector2 get windowScaleDPI => raylib.GetWindowScaleDPI();

  // Get the human-readable, UTF-8 encoded name of the primary monitor
  String getMonitorName(int monitor) {
    return raylib.GetMonitorName(monitor).cast<Utf8>().toDartString();
  }

  // Set clipboard text content
  set clipboardText(String text) {
    malloc.free(_clipboardContent);
    _clipboardContent = _toUtf8(text);
    raylib.SetClipboardText(_clipboardContent.cast<ffi.Int8>());
  }

  // Get clipboard text content
  String get clipboardText =>
      raylib.GetClipboardText().cast<Utf8>().toDartString();

  // **************** Cursor related APIs. ****************

  void showCursor() {
    raylib.ShowCursor();
  }

  // Hides cursor
  void hideCursor() {
    raylib.HideCursor();
  }

  // Check if cursor is not visible
  bool get isCursorHidden => (raylib.IsCursorHidden() == _true);

  // Enables cursor (unlock cursor)
  void enableCursor() {
    raylib.EnableCursor();
  }

  // Disables cursor (lock cursor)
  void disableCursor() {
    raylib.DisableCursor();
  }

  // Check if cursor is on the current screen.
  bool get isCursorOnScreen => (raylib.IsCursorOnScreen() == _true);

  // **************** Drawing related APIs. ****************

  // Set background color (framebuffer clear color)
  void clearBackground(raylib_bind.Color color) {
    raylib.ClearBackground(color);
  }

  // Setup canvas (framebuffer) to start drawing
  void beginDrawing() {
    raylib.BeginDrawing();
  }

  // End canvas drawing and swap buffers (double buffering)
  void endDrawing() {
    raylib.EndDrawing();
  }

  // Initialize 2D mode with custom camera (2D)
  void beginMode2D(raylib_bind.Camera2D camera) {
    raylib.BeginMode2D(camera);
  }

  // Ends 2D mode with custom camera
  void endMode2D() {
    raylib.EndMode2D();
  }

  // Initializes 3D mode with custom camera (3D)
  void beginMode3D(raylib_bind.Camera3D camera) {
    raylib.BeginMode3D(camera);
  }

  // Ends 3D mode and returns to default 2D orthographic mode
  void endMode3D() {
    raylib.EndMode3D();
  }

  // Initializes render texture for drawing
  void beginTextureMode(raylib_bind.RenderTexture target) {
    raylib.BeginTextureMode(target);
  }

  // Ends drawing to render texture
  void endTextureMode() {
    raylib.EndTextureMode();
  }

  // Begin custom shader drawing
  void beginShaderMode(raylib_bind.Shader shader) {
    raylib.BeginShaderMode(shader);
  }

  // End custom shader drawing (use default shader)
  void endShaderMode() {
    raylib.EndShaderMode();
  }

  // Begin blending mode (alpha, additive, multiplied)
  void beginBlendMode(int mode) {
    raylib.BeginBlendMode(mode);
  }

  // End blending mode (reset to default: alpha blending)
  void endBlendMode() {
    raylib.EndBlendMode();
  }

  // Begin scissor mode (define screen area for following drawing)
  void beginScissorMode(int x, int y, int width, int height) {
    raylib.BeginScissorMode(x, y, width, height);
  }

  // End scissor mode
  void endScissorMode() {
    raylib.EndScissorMode();
  }

  // Begin stereo rendering (requires VR simulator)
  void beginVrStereoMode(raylib_bind.VrStereoConfig config) {
    raylib.BeginVrStereoMode(config);
  }

  // End stereo rendering (requires VR simulator)
  void endVrStereoMode() {
    raylib.EndVrStereoMode();
  }

  // **************** VR stereo config functions for VR simulator. ****************

  // Load VR stereo config for VR simulator device parameters
  raylib_bind.VrStereoConfig loadVrStereoConfig(
      raylib_bind.VrDeviceInfo device) {
    return raylib.LoadVrStereoConfig(device);
  }

  // Unload VR stereo config
  void unloadVrStereoConfig(raylib_bind.VrStereoConfig config) {
    raylib.UnloadVrStereoConfig(config);
  }

  // **************** Screen-space-related functions. ****************

  // Returns a ray trace from mouse position
  raylib_bind.Ray getMouseRay(
          raylib_bind.Vector2 mousePosition, raylib_bind.Camera3D camera) =>
      raylib.GetMouseRay(mousePosition, camera);

  // Returns camera transform matrix (view matrix)
  raylib_bind.Matrix getCameraMatrix(raylib_bind.Camera3D camera) =>
      raylib.GetCameraMatrix(camera);

  // Returns camera 2d transform matrix
  raylib_bind.Matrix getCameraMatrix2D(raylib_bind.Camera2D camera) =>
      raylib.GetCameraMatrix2D(camera);

  // Returns the screen space position for a 3d world space position
  raylib_bind.Vector2 getWorldToScreen(
          raylib_bind.Vector3 position, raylib_bind.Camera3D camera) =>
      raylib.GetWorldToScreen(position, camera);

  // Returns size position for a 3d world space position
  raylib_bind.Vector2 getWorldToScreenEx(raylib_bind.Vector3 position,
          raylib_bind.Camera3D camera, int width, int height) =>
      raylib.GetWorldToScreenEx(position, camera, width, height);

  // Returns the screen space position for a 2d camera world space position
  raylib_bind.Vector2 getWorldToScreen2D(
          raylib_bind.Vector2 position, raylib_bind.Camera2D camera) =>
      raylib.GetWorldToScreen2D(position, camera);

  // Returns the world space position for a 2d camera screen space position
  raylib_bind.Vector2 getScreenToWorld2D(
          raylib_bind.Vector2 position, raylib_bind.Camera2D camera) =>
      raylib.GetScreenToWorld2D(position, camera);

  // **************** Timing related APIs. ****************

  // Set target FPS (maximum)
  set targetFPS(int fps) => raylib.SetTargetFPS(fps);

  // Returns current FPS
  int get fps => raylib.GetFPS();

  // Returns time in seconds for last frame drawn (delta time)
  double get frameTime => raylib.GetFrameTime();

  // Returns elapsed time in seconds since InitWindow()
  double get time => raylib.GetTime();

  // **************** Misc. functions. ****************

  // Returns a random value between min and max (both included)
  int getRandomValue(int min, int max) => raylib.GetRandomValue(min, max);

  // Takes a screenshot of current screen (filename extension defines format)
  void takeScreenshot(String fileName) {
    final nativeString = _toUtf8(fileName);
    raylib.TakeScreenshot(nativeString.cast<ffi.Int8>());
    malloc.free(nativeString);
  }

  // Setup init configuration flags (view FLAGS)
  void setConfigFlags(List<WindowConfigFlag> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_configFlags[flag] != null) {
        bitMaskedFlag |= _configFlags[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native window config flag.');
      }
    }
    raylib.SetConfigFlags(bitMaskedFlag);
  }

  // **************** Files management functions. ****************

  // Check if a file has been dropped into window
  bool get isFileDropped => (raylib.IsFileDropped() == raylib_bind.bool.true_1);

  // Get dropped files names
  List<String> getDroppedFiles() {
    List<String> filenames = [];

    ffi.Pointer<ffi.Int32> nativeCount = calloc.allocate<ffi.Int32>(1);
    final nativeStrings = raylib.GetDroppedFiles(nativeCount);

    for (var i = 0; i < nativeCount.value; ++i) {
      filenames
          .add(nativeStrings.elementAt(i).value.cast<Utf8>().toDartString());
    }
    // Cleans the native memory.
    raylib.ClearDroppedFiles();

    return filenames;
  }

  // **************** Input-related functions: keyboard. ****************

  // Detect if a key has been pressed once
  bool isKeyPressed(KeyboardKeyCode key) =>
      (raylib.IsKeyPressed(_keyboardKeys[key]!) == raylib_bind.bool.true_1);

  // Detect if a key is being pressed
  bool isKeyDown(KeyboardKeyCode key) =>
      (raylib.IsKeyDown(_keyboardKeys[key]!) == raylib_bind.bool.true_1);

  // Detect if a key has been released once
  bool isKeyReleased(KeyboardKeyCode key) =>
      (raylib.IsKeyReleased(_keyboardKeys[key]!) == raylib_bind.bool.true_1);

  // Detect if a key is NOT being pressed
  bool isKeyUp(KeyboardKeyCode key) =>
      (raylib.IsKeyUp(_keyboardKeys[key]!) == raylib_bind.bool.true_1);

  // Set a custom key to exit program (default is ESC)
  set exitKey(KeyboardKeyCode key) => raylib.SetExitKey(_keyboardKeys[key]!);

  // Get key pressed (keycode), call it multiple times for keys queued
  KeyboardKeyCode getKeyPressed() {
    final nativeKey = raylib.GetKeyPressed();
    // Do a reverse lookup.
    final index = _keyboardKeys.values.toList().indexOf(nativeKey);
    return _keyboardKeys.keys.elementAt(index);
  }

  // Get char pressed (unicode), call it multiple times for chars queued
  int getCharPressed() => raylib.GetCharPressed();

  // **************** Input-related functions: gamepads. ****************

  // Detect if a gamepad is available
  bool isGamepadAvailable(int gamepad) =>
      (raylib.IsGamepadAvailable(gamepad) == raylib_bind.bool.true_1);

  // Check gamepad name (if available)
  bool isGamepadName(int gamepad, String name) {
    final nativeString = _toUtf8(name);
    bool flag = (raylib.IsGamepadName(gamepad, nativeString.cast<ffi.Int8>()) ==
        raylib_bind.bool.true_1);
    malloc.free(nativeString);
    return flag;
  }

  // Return gamepad internal name id
  String getGamepadName(int gamepad) =>
      raylib.GetGamepadName(gamepad).cast<Utf8>().toDartString();

  // Detect if a gamepad button has been pressed once
  bool isGamepadButtonPressed(int gamepad, GamepadButtonCode button) =>
      (raylib.IsGamepadButtonPressed(gamepad, _gamepadButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a gamepad button is being pressed
  bool isGamepadButtonDown(int gamepad, GamepadButtonCode button) =>
      (raylib.IsGamepadButtonDown(gamepad, _gamepadButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a gamepad button has been released once
  bool isGamepadButtonReleased(int gamepad, GamepadButtonCode button) =>
      (raylib.IsGamepadButtonReleased(gamepad, _gamepadButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a gamepad button is NOT being pressed
  bool isGamepadButtonUp(int gamepad, int button) =>
      (raylib.IsGamepadButtonUp(gamepad, _gamepadButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Get the last gamepad button pressed
  GamepadButtonCode getGamepadButtonPressed() {
    final nativeKey = raylib.GetGamepadButtonPressed();
    final index = _gamepadButtons.values.toList().indexOf(nativeKey);
    return _gamepadButtons.keys.elementAt(index);
  }

  // Return gamepad axis count for a gamepad
  int getGamepadAxisCount(int gamepad) => raylib.GetGamepadAxisCount(gamepad);

  // Return axis movement value for a gamepad axis
  double getGamepadAxisMovement(int gamepad, GamepadAxisCode axis) =>
      raylib.GetGamepadAxisMovement(gamepad, _gamepadAxis[axis]!);

  // Set internal gamepad mappings (SDL_GameControllerDB)
  int setGamepadMappings(String mappings) {
    final nativeString = _toUtf8(mappings);
    final result = raylib.SetGamepadMappings(nativeString.cast<ffi.Int8>());
    malloc.free(nativeString);
    return result;
  }

  // **************** Input-related functions: mouse. ****************

  // Detect if a mouse button has been pressed once
  bool isMouseButtonPressed(MouseButtonCode button) =>
      (raylib.IsMouseButtonPressed(_mouseButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a mouse button is being pressed
  bool isMouseButtonDown(MouseButtonCode button) =>
      (raylib.IsMouseButtonDown(_mouseButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a mouse button has been released once
  bool isMouseButtonReleased(MouseButtonCode button) =>
      (raylib.IsMouseButtonReleased(_mouseButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Detect if a mouse button is NOT being pressed
  bool isMouseButtonUp(MouseButtonCode button) =>
      (raylib.IsMouseButtonUp(_mouseButtons[button]!) ==
          raylib_bind.bool.true_1);

  // Returns mouse position X
  int get mouseX => raylib.GetMouseX();

  // Returns mouse position Y
  int get mouseY => raylib.GetMouseY();

  // Returns mouse position XY
  raylib_bind.Vector2 get mousePosition => raylib.GetMousePosition();

  // Set mouse position XY
  void setMousePosition(int x, int y) => raylib.SetMousePosition(x, y);

  // Set mouse offset
  void setMouseOffset(int offsetX, int offsetY) =>
      raylib.SetMouseOffset(offsetX, offsetY);

  // Set mouse scaling
  void setMouseScale(double scaleX, double scaleY) =>
      raylib.SetMouseScale(scaleX, scaleY);

  // Returns mouse wheel movement Y
  double get mouseWheelMove => raylib.GetMouseWheelMove();

  // Set mouse cursor
  set mouseCursor(MouseCursor cursor) =>
      raylib.SetMouseCursor(_mouseCursor[cursor]!);

  // **************** Input-related functions: touch. ****************

  // Returns touch position X for touch point 0 (relative to screen size)
  int get touchX => raylib.GetMouseX();

  // Returns touch position Y for touch point 0 (relative to screen size)
  int get touchY => raylib.GetMouseY();

  // Returns touch position XY for a touch point index (relative to screen size)
  raylib_bind.Vector2 getTouchPosition(int index) =>
      raylib.GetTouchPosition(index);

  // **************** Gestures and Touch Handling Functions. ****************

  // Enable a set of gestures using flags
  void setGesturesEnabled(List<Gesture> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_gestures[flag] != null) {
        bitMaskedFlag |= _gestures[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native gesture flag.');
      }
    }
    raylib.SetGesturesEnabled(bitMaskedFlag);
  }

  // Check if a gesture have been detected
  bool isGestureDetected(Gesture gesture) {
    bool flag = false;
    if (_gestures[gesture] != null) {
      flag = (raylib.IsGestureDetected(_gestures[gesture]!) == _true);
    } else {
      throw ArgumentError.value(
          gesture, '$gesture', 'Does not map to any native gesture flag.');
    }
    return flag;
  }

  // Get latest detected gesture
  Gesture get gestureDetected {
    final nativeGesture = raylib.GetGestureDetected();
    final index = _gestures.values.toList().indexOf(nativeGesture);
    return _gestures.keys.elementAt(index);
  }

  // Get touch points count
  int get touchPointsCount => raylib.GetTouchPointsCount();

  // Get gesture hold time in milliseconds
  double get gestureHoldDuration => raylib.GetGestureHoldDuration();

  // Get gesture drag vector
  raylib_bind.Vector2 get gestureDragVector => raylib.GetGestureDragVector();

  // Get gesture drag angle
  double get gestureDragAngle => raylib.GetGestureDragAngle();

  // Get gesture pinch delta
  raylib_bind.Vector2 get gesturePinchVector => raylib.GetGesturePinchVector();

  // Get gesture pinch angle
  double get gesturePinchAngle => raylib.GetGesturePinchAngle();

  // **************** Camera System Functions. ****************

  // Set camera mode (multiple camera modes available)
  void setCameraMode(raylib_bind.Camera3D camera, CameraMode mode) {
    if (_cameraModes[mode] != null) {
      raylib.SetCameraMode(camera, _cameraModes[mode]!);
    } else {
      throw ArgumentError.value(
          mode, '$mode', 'Does not map to any native camera modes.');
    }
  }

  // Update camera position for selected mode
  void updateCamera(ffi.Pointer<raylib_bind.Camera3D> camera) {
    raylib.UpdateCamera(camera);
  }

  // Set camera pan key to combine with mouse movement (free camera)
  set cameraPanControl(MouseButtonCode keyPan) {
    if (_mouseButtons[keyPan] != null) {
      raylib.SetCameraPanControl(_mouseButtons[keyPan]!);
    } else {
      throw ArgumentError.value(
          keyPan, '$keyPan', 'Does not map to any native mouse keys.');
    }
  }

  // Set camera alt key to combine with mouse movement (free camera)
  set cameraAltControl(KeyboardKeyCode keyAlt) {
    if (_keyboardKeys[keyAlt] != null) {
      raylib.SetCameraAltControl(_keyboardKeys[keyAlt]!);
    } else {
      throw ArgumentError.value(
          keyAlt, '$keyAlt', 'Does not map to any native keyboard keys.');
    }
  }

  // Set camera smooth zoom key to combine with mouse (free camera)
  set cameraSmoothZoomControl(KeyboardKeyCode keySmoothZoom) {
    if (_keyboardKeys[keySmoothZoom] != null) {
      raylib.SetCameraSmoothZoomControl(_keyboardKeys[keySmoothZoom]!);
    } else {
      throw ArgumentError.value(keySmoothZoom, '$keySmoothZoom',
          'Does not map to any native keyboard keys.');
    }
  }

  // Set camera move controls (1st person and 3rd person cameras)
  void setCameraMoveControls(
      KeyboardKeyCode keyFront,
      KeyboardKeyCode keyBack,
      KeyboardKeyCode keyRight,
      KeyboardKeyCode keyLeft,
      KeyboardKeyCode keyUp,
      KeyboardKeyCode keyDown) {
    int _keyFront;
    int _keyBack;
    int _keyRight;
    int _keyLeft;
    int _keyUp;
    int _keyDown;

    if (_keyboardKeys[keyFront] != null) {
      _keyFront = _keyboardKeys[keyFront]!;
    } else {
      throw ArgumentError.value(
          keyFront, '$keyFront', 'Does not map to any native keyboard keys.');
    }
    if (_keyboardKeys[keyBack] != null) {
      _keyBack = _keyboardKeys[keyBack]!;
    } else {
      throw ArgumentError.value(
          keyBack, '$keyBack', 'Does not map to any native keyboard keys.');
    }
    if (_keyboardKeys[keyRight] != null) {
      _keyRight = _keyboardKeys[keyRight]!;
    } else {
      throw ArgumentError.value(
          keyRight, '$keyRight', 'Does not map to any native keyboard keys.');
    }
    if (_keyboardKeys[keyLeft] != null) {
      _keyLeft = _keyboardKeys[keyLeft]!;
    } else {
      throw ArgumentError.value(
          keyLeft, '$keyLeft', 'Does not map to any native keyboard keys.');
    }
    if (_keyboardKeys[keyUp] != null) {
      _keyUp = _keyboardKeys[keyUp]!;
    } else {
      throw ArgumentError.value(
          keyUp, '$keyUp', 'Does not map to any native keyboard keys.');
    }
    if (_keyboardKeys[keyDown] != null) {
      _keyDown = _keyboardKeys[keyDown]!;
    } else {
      throw ArgumentError.value(
          keyDown, '$keyDown', 'Does not map to any native keyboard keys.');
    }

    raylib.SetCameraMoveControls(
        _keyFront, _keyBack, _keyRight, _keyLeft, _keyUp, _keyDown);
  }

  // **************** Struct constructors. ****************
  // Creates an object of Vector2.
  raylib_bind.Vector2 createVector2(double x, double y) =>
      raylib.CreateVector2(x, y);

  // Creates an object of Color with given RGBA values.
  // Each channel showing be between 0-255.
  raylib_bind.Color createColor(int r, int g, int b, int a) =>
      raylib.CreateColor(r, g, b, a);

  // Creates an object of Image.
  raylib_bind.Image createImage(ffi.Pointer<ffi.Void> data, int width,
          int height, int mipmaps, int format) =>
      raylib.CreateImage(data, width, height, mipmaps, format);

  raylib_bind.Camera2D createCamera2D(raylib_bind.Vector2 offset,
      raylib_bind.Vector2 target, double rotation, double zoom) {
    return raylib.CreateCamera2D(offset, target, rotation, zoom);
  }

  // Needs to be freed.
  ffi.Pointer<raylib_bind.Camera3D> createCamera3D(
      raylib_bind.Vector3 position,
      raylib_bind.Vector3 target,
      raylib_bind.Vector3 up,
      double fovy,
      CameraProjection projection) {
    ffi.Pointer<raylib_bind.Camera3D> camera = ffi.nullptr;

    if (_cameraProjections[projection] != null) {
      camera = raylib.MemAlloc(ffi.sizeOf<raylib_bind.Camera3D>())
          .cast<raylib_bind.Camera3D>();

      camera.ref.position = position;
      camera.ref.target = target;
      camera.ref.up = up;
      camera.ref.fovy = fovy;
      camera.ref.projection = _cameraProjections[projection]!;
    } else {
      throw ArgumentError.value(projection, '$projection',
          'Does not map to any native projection types.');
    }

    return camera;
  }
}
